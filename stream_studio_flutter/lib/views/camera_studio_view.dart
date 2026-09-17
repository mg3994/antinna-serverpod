import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:stream_studio_client/stream_studio_client.dart';

class CameraStudioView extends StatefulWidget {
  final Client client;
  final String streamId;

  const CameraStudioView({
    super.key,
    required this.client,
    required this.streamId,
  });

  @override
  State<CameraStudioView> createState() => _CameraStudioViewState();
}

class _CameraStudioViewState extends State<CameraStudioView> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  RTCPeerConnection? _peerConnection;
  OverlayConfig? _activeOverlay;
  bool _isConnected = false;
  double _currentZoom = 1.0;
  bool _isTorchOn = false;
  bool _isAudioMuted = false;
  int _activeCameraIndex = 0; // 0 = Back, 1 = Front
  Timer? _heartbeatTimer;
  final String _deviceId = 'cam_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

  @override
  void initState() {
    super.initState();
    _setupStudioCamera();
  }

  Future<void> _setupStudioCamera() async {
    await _localRenderer.initialize();

    try {
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': true,
        'video': {
          'facingMode': _activeCameraIndex == 0 ? 'environment' : 'user',
          'mandatory': {
            'minWidth': '1280',
            'minHeight': '720',
            'minFrameRate': '30',
          },
        },
      });
      _localRenderer.srcObject = _localStream;
    } catch (e) {
      debugPrint('Error initializing camera stream: $e');
    }

    try {
      await widget.client.openStreamingConnection(
        disconnectOnLostInternetConnection: true,
      );
      setState(() => _isConnected = true);

      widget.client.studio.stream.listen((message) {
        if (!mounted) return;

        if (message is OverlayConfig) {
          setState(() => _activeOverlay = message);
        } else if (message is CameraControl) {
          _applyHardwareControls(message);
        } else if (message is SignalingMessage) {
          _handleSignalingMessage(message);
        }
      });

      // Initialize WebRTC sender peer connection and send offer
      await _createOffer();
      _startHeartbeatTimer();
    } catch (e) {
      debugPrint('Error connecting to Serverpod streaming endpoint: $e');
    }
  }

  void _startHeartbeatTimer() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_isConnected) return;
      widget.client.studio.sendStreamMessage(
        StreamHeartbeat(
          streamId: widget.streamId,
          deviceId: _deviceId,
          deviceType: 'mobile_camera',
          fps: 30.0,
          resolution: '1280x720',
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  Future<void> _createOffer() async {
    final configuration = <String, dynamic>{
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    _peerConnection = await createPeerConnection(configuration);

    if (_localStream != null) {
      for (var track in _localStream!.getTracks()) {
        await _peerConnection!.addTrack(track, _localStream!);
      }
    }

    _peerConnection!.onIceCandidate = (candidate) {
      widget.client.studio.sendStreamMessage(
        SignalingMessage(
          senderId: 'mobile_camera',
          targetId: 'web_companion',
          type: 'candidate',
          candidate: candidate.candidate,
          sdpMid: candidate.sdpMid,
          sdpMLineIndex: candidate.sdpMLineIndex,
        ),
      );
    };

    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);

    await widget.client.studio.sendStreamMessage(
      SignalingMessage(
        senderId: 'mobile_camera',
        targetId: 'web_companion',
        type: 'offer',
        sdp: offer.sdp,
      ),
    );
  }

  Future<void> _handleSignalingMessage(SignalingMessage msg) async {
    if (msg.targetId != 'mobile_camera' && msg.targetId != 'all') return;

    if (msg.type == 'answer' && _peerConnection != null) {
      final description = RTCSessionDescription(msg.sdp!, 'answer');
      await _peerConnection!.setRemoteDescription(description);
    } else if (msg.type == 'candidate' && _peerConnection != null) {
      final candidate = RTCIceCandidate(
        msg.candidate,
        msg.sdpMid,
        msg.sdpMLineIndex,
      );
      await _peerConnection!.addCandidate(candidate);
    }
  }

  Future<void> _applyHardwareControls(CameraControl control) async {
    setState(() {
      _currentZoom = control.zoomLevel;
      _isTorchOn = control.torchOn;
      if (control.isMuted != null) {
        _isAudioMuted = control.isMuted!;
      }
    });

    final audioTrack = _localStream?.getAudioTracks().firstOrNull;
    if (audioTrack != null && control.isMuted != null) {
      audioTrack.enabled = !control.isMuted!;
    }

    final videoTrack = _localStream?.getVideoTracks().firstOrNull;
    if (videoTrack != null) {
      try {
        await videoTrack.setZoom(control.zoomLevel);
        await videoTrack.setTorch(control.torchOn);
      } catch (e) {
        debugPrint('Error setting hardware constraints: $e');
      }
    }

    if (control.activeCameraIndex != _activeCameraIndex) {
      _activeCameraIndex = control.activeCameraIndex;
      _switchCamera();
    }
  }

  Future<void> _switchCamera() async {
    final videoTrack = _localStream?.getVideoTracks().firstOrNull;
    if (videoTrack != null) {
      try {
        await Helper.switchCamera(videoTrack);
      } catch (e) {
        debugPrint('Error switching camera: $e');
      }
    }
  }

  Color _parseColor(String? hexString, Color fallback) {
    if (hexString == null || hexString.isEmpty) return fallback;
    try {
      final cleanHex = hexString.replaceFirst('#', '');
      if (cleanHex.length == 6) {
        return Color(int.parse('0xff$cleanHex'));
      } else if (cleanHex.length == 8) {
        return Color(int.parse('0x$cleanHex'));
      }
    } catch (_) {}
    return fallback;
  }

  Widget _buildOverlayContent(OverlayConfig overlay) {
    final bgColor = _parseColor(overlay.backgroundColor, const Color(0xffe50914));
    final textColor = _parseColor(overlay.textColor, Colors.white);

    if (overlay.position == 'top_right') {
      return Container(
        key: ValueKey('tr_${overlay.id}'),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.circle, color: Colors.white, size: 8),
            const SizedBox(width: 8),
            Text(
              overlay.title,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else if (overlay.position == 'ticker') {
      return Container(
        key: ValueKey('ticker_${overlay.id}'),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: bgColor.withValues(alpha: 0.9),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.black,
              child: Text(
                overlay.title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                overlay.subtitle,
                style: TextStyle(color: textColor, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    // Default Lower Third
    return Container(
      key: ValueKey('lt_${overlay.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            overlay.title,
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (overlay.subtitle.isNotEmpty)
            Text(
              overlay.subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedOverlay(OverlayConfig overlay) {
    final style = overlay.animationStyle ?? 'fade';

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        if (style == 'slide') {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        } else if (style == 'scale') {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        }
        return FadeTransition(opacity: animation, child: child);
      },
      child: _buildOverlayContent(overlay),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Layer: Native Camera Feed
          Positioned.fill(
            child: RTCVideoView(
              _localRenderer,
              mirror: _activeCameraIndex == 1,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),

          // Live Connection Status Badge
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isConnected ? Colors.green : Colors.red,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: _isConnected ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isConnected ? 'LIVE (ID: $_deviceId)' : 'CONNECTING...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isAudioMuted) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.mic_off, color: Colors.redAccent, size: 14),
                  ],
                ],
              ),
            ),
          ),

          // Top Layer: Live Overlay Canvas Stack
          if (_activeOverlay != null && _activeOverlay!.isVisible)
            Positioned.fill(
              child: Align(
                alignment: _activeOverlay!.position == 'top_right'
                    ? Alignment.topRight
                    : _activeOverlay!.position == 'ticker'
                        ? Alignment.bottomCenter
                        : Alignment.bottomLeft,
                child: Padding(
                  padding: _activeOverlay!.position == 'ticker'
                      ? EdgeInsets.zero
                      : const EdgeInsets.all(24.0),
                  child: _buildAnimatedOverlay(_activeOverlay!),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _heartbeatTimer?.cancel();
    _localRenderer.dispose();
    _localStream?.dispose();
    _peerConnection?.dispose();
    super.dispose();
  }
}
