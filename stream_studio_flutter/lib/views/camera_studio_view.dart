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
  int _activeCameraIndex = 0; // 0 = Back, 1 = Front

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
    } catch (e) {
      debugPrint('Error connecting to Serverpod streaming endpoint: $e');
    }
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
    });

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

  Alignment _getAlignment(String? position) {
    switch (position) {
      case 'top_right':
        return Alignment.topRight;
      case 'ticker':
        return Alignment.bottomCenter;
      case 'lower_third':
      default:
        return Alignment.bottomLeft;
    }
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
                    _isConnected ? 'LIVE (Camera Connected)' : 'CONNECTING...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Layer: Live Lower-Third Burn-In Text Stack
          if (_activeOverlay != null && _activeOverlay!.isVisible)
            Positioned.fill(
              child: Align(
                alignment: _getAlignment(_activeOverlay!.position),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Container(
                      key: ValueKey(_activeOverlay!.id),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: _parseColor(
                          _activeOverlay!.backgroundColor,
                          const Color(0xffe50914),
                        ),
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
                            _activeOverlay!.title,
                            style: TextStyle(
                              color: _parseColor(
                                _activeOverlay!.textColor,
                                Colors.white,
                              ),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (_activeOverlay!.subtitle.isNotEmpty)
                            Text(
                              _activeOverlay!.subtitle,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _localStream?.dispose();
    _peerConnection?.dispose();
    super.dispose();
  }
}
