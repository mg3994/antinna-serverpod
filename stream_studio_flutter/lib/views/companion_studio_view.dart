import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:stream_studio_client/stream_studio_client.dart';
import '../controllers/studio_controller.dart';

class CompanionStudioView extends StatefulWidget {
  final Client client;
  final String streamId;

  const CompanionStudioView({
    super.key,
    required this.client,
    required this.streamId,
  });

  @override
  State<CompanionStudioView> createState() => _CompanionStudioViewState();
}

class _CompanionStudioViewState extends State<CompanionStudioView> {
  late StudioController _controller;
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;

  // Connection State & Telemetry
  bool _isConnected = false;
  StreamHeartbeat? _latestHeartbeat;

  // Stream Metadata State
  final _streamTitleController = TextEditingController(text: 'Live Studio Broadcast');
  final _streamDescController = TextEditingController(text: 'Streaming via StreamStudio Serverpod engine');
  bool _isBroadcastingLive = false;

  // YouTube Live & RTMP Destination State
  final _youtubeUrlController = TextEditingController(text: 'rtmp://a.rtmp.youtube.com/live2');
  final _youtubeKeyController = TextEditingController();
  bool _isYoutubeCastingActive = false;

  // Active Scene State
  String _activeScene = 'camera'; // "camera", "color_bars", "black_slate"

  // Audio Mixer State
  double _micGain = 1.0;
  double _bgmVolume = 0.8;
  double _sfxVolume = 0.9;
  bool _isAudioMuted = false;

  // Chat & Teleprompter Cue State
  final _chatInputController = TextEditingController();

  // Lower-Third Editor Form State
  final _titleController = TextEditingController(text: 'Live Studio News');
  final _subtitleController = TextEditingController(
    text: 'Reporting live from Companion Dashboard',
  );
  String _selectedPosition = 'lower_third';
  String _backgroundColorHex = '#E50914';
  String _textColorHex = '#FFFFFF';
  String _selectedAnimationStyle = 'fade';

  // Remote Camera Controls State
  double _zoomLevel = 1.0;
  bool _torchOn = false;
  int _activeCameraIndex = 0; // 0 = Back, 1 = Front

  // Overlay Presets
  List<OverlayPreset> _presets = [];

  @override
  void initState() {
    super.initState();
    _controller = StudioController(
      client: widget.client,
      streamId: widget.streamId,
    );
    _initStudio();
  }

  Future<void> _initStudio() async {
    await _remoteRenderer.initialize();

    try {
      await widget.client.openStreamingConnection(
        disconnectOnLostInternetConnection: true,
      );
      setState(() => _isConnected = true);

      // Listen for incoming websocket messages
      widget.client.studio.stream.listen((message) {
        if (!mounted) return;

        if (message is SignalingMessage) {
          _handleSignalingMessage(message);
        } else if (message is StreamHeartbeat) {
          setState(() => _latestHeartbeat = message);
        } else if (message is SceneControl) {
          setState(() => _activeScene = message.activeScene);
        } else if (message is AudioMixerControl) {
          setState(() {
            _micGain = message.micGain;
            _bgmVolume = message.bgmVolume;
            _sfxVolume = message.sfxVolume;
            _isAudioMuted = message.isMuted;
          });
        } else if (message is OverlayConfig) {
          setState(() {
            _titleController.text = message.title;
            _subtitleController.text = message.subtitle;
            _selectedPosition = message.position;
            _backgroundColorHex = message.backgroundColor;
            _textColorHex = message.textColor;
            _selectedAnimationStyle = message.animationStyle ?? 'fade';
          });
        } else if (message is CameraControl) {
          setState(() {
            _zoomLevel = message.zoomLevel;
            _torchOn = message.torchOn;
            _activeCameraIndex = message.activeCameraIndex;
            if (message.isMuted != null) {
              _isAudioMuted = message.isMuted!;
            }
          });
        }
      });
    } catch (e) {
      debugPrint('Error opening websocket streaming connection: $e');
    }

    _loadMetadata();
    _loadRtmpDestination();
    _loadPresets();
  }

  Future<void> _loadMetadata() async {
    try {
      final meta = await _controller.getMetadata();
      if (meta != null) {
        setState(() {
          _streamTitleController.text = meta.title;
          _streamDescController.text = meta.description;
          _isBroadcastingLive = meta.isLive;
        });
      }
    } catch (e) {
      debugPrint('Error loading stream metadata: $e');
    }
  }

  Future<void> _loadRtmpDestination() async {
    try {
      final rtmp = await _controller.getRtmpDestination();
      if (rtmp != null) {
        setState(() {
          _youtubeUrlController.text = rtmp.ingestionUrl;
          _youtubeKeyController.text = rtmp.streamKey;
          _isYoutubeCastingActive = rtmp.isEnabled;
        });
      }
    } catch (e) {
      debugPrint('Error loading RTMP destination: $e');
    }
  }

  Future<void> _loadPresets() async {
    try {
      final list = await _controller.listPresets();
      setState(() => _presets = list);
    } catch (e) {
      debugPrint('Error loading overlay presets: $e');
    }
  }

  Future<void> _handleSignalingMessage(SignalingMessage msg) async {
    if (msg.type == 'offer') {
      await _createAnswer(msg.sdp!);
    } else if (msg.type == 'candidate' && _peerConnection != null) {
      final candidate = RTCIceCandidate(
        msg.candidate,
        msg.sdpMid,
        msg.sdpMLineIndex,
      );
      await _peerConnection!.addCandidate(candidate);
    }
  }

  Future<void> _createAnswer(String offerSdp) async {
    final configuration = <String, dynamic>{
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    _peerConnection = await createPeerConnection(configuration);

    _peerConnection!.onIceCandidate = (candidate) {
      _controller.sendSignalingMessage(
        SignalingMessage(
          senderId: 'web_companion',
          targetId: 'mobile_camera',
          type: 'candidate',
          candidate: candidate.candidate,
          sdpMid: candidate.sdpMid,
          sdpMLineIndex: candidate.sdpMLineIndex,
        ),
      );
    };

    _peerConnection!.onTrack = (event) {
      if (event.track.kind == 'video' && event.streams.isNotEmpty) {
        setState(() {
          _remoteRenderer.srcObject = event.streams[0];
        });
      }
    };

    final description = RTCSessionDescription(offerSdp, 'offer');
    await _peerConnection!.setRemoteDescription(description);

    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    await _controller.sendSignalingMessage(
      SignalingMessage(
        senderId: 'web_companion',
        targetId: 'mobile_camera',
        type: 'answer',
        sdp: answer.sdp,
      ),
    );
  }

  void _pushOverlayLive(bool visible) {
    _controller.sendOverlay(
      title: _titleController.text,
      subtitle: _subtitleController.text,
      isVisible: visible,
      position: _selectedPosition,
      backgroundColor: _backgroundColorHex,
      textColor: _textColorHex,
      animationStyle: _selectedAnimationStyle,
    );
  }

  void _updateCameraControl() {
    _controller.updateCameraHardware(
      zoomLevel: _zoomLevel,
      torchOn: _torchOn,
      activeCameraIndex: _activeCameraIndex,
      isMuted: _isAudioMuted,
    );
  }

  void _updateAudioMixerControl() {
    _controller.updateAudioMixer(
      micGain: _micGain,
      bgmVolume: _bgmVolume,
      sfxVolume: _sfxVolume,
      isMuted: _isAudioMuted,
    );
  }

  void _switchScene(String scene) {
    setState(() => _activeScene = scene);
    _controller.sendSceneControl(activeScene: scene);
  }

  void _sendProducerChat({required bool isCue}) {
    final text = _chatInputController.text.trim();
    if (text.isEmpty) return;
    _chatInputController.clear();

    _controller.sendChatMessage(
      senderName: 'Director / Companion',
      message: text,
      isDirectorCue: isCue,
    );
  }

  void _applyQuickTemplate(String title, String subtitle, String position, String color, String anim) {
    setState(() {
      _titleController.text = title;
      _subtitleController.text = subtitle;
      _selectedPosition = position;
      _backgroundColorHex = color;
      _selectedAnimationStyle = anim;
    });
    _pushOverlayLive(true);
  }

  Widget _buildAudioVuMeter(double level) {
    final clampedLevel = level.clamp(0.0, 1.0);
    final color = clampedLevel > 0.8
        ? Colors.redAccent
        : clampedLevel > 0.5
            ? Colors.amberAccent
            : Colors.greenAccent;

    return Container(
      width: 100,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: clampedLevel,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff1e1e1e),
        title: Text('StreamStudio Dashboard (${widget.streamId})'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: _isConnected ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _isConnected ? 'LIVE STUDIO' : 'OFFLINE',
                  style: TextStyle(
                    color: _isConnected ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          return isWide
              ? Row(
                  crossAxisAlignment: CrossAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildPreviewViewport()),
                    Expanded(flex: 2, child: _buildControlPanel()),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 350, child: _buildPreviewViewport()),
                      _buildControlPanel(),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildPreviewViewport() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        children: [
          Center(
            child: _remoteRenderer.srcObject != null
                ? RTCVideoView(
                    _remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.videocam_off, size: 48, color: Colors.white38),
                      SizedBox(height: 12),
                      Text(
                        'Waiting for camera WebRTC stream...',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black80,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _isBroadcastingLive ? 'ON AIR (${_activeScene.toUpperCase()})' : 'STANDBY (${_activeScene.toUpperCase()})',
                style: TextStyle(
                  color: _isBroadcastingLive ? Colors.red : Colors.amber,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (_isYoutubeCastingActive)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.redAccent),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_circle_fill, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'YOUTUBE LIVE CASTING',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_latestHeartbeat != null)
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black80,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.speed, color: Colors.greenAccent, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      '${_latestHeartbeat!.deviceId} | ${_latestHeartbeat!.resolution} | ${_latestHeartbeat!.fps.toInt()} FPS',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                    if (_latestHeartbeat!.audioLevel != null) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.equalizer, color: Colors.amberAccent, size: 14),
                      const SizedBox(width: 4),
                      _buildAudioVuMeter(_latestHeartbeat!.audioLevel!),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAlignment: CrossAlignment.start,
        children: [
          _buildAudioMixerCard(),
          const SizedBox(height: 24),
          _buildYoutubeLiveCard(),
          const SizedBox(height: 24),
          _buildSceneSwitcherCard(),
          const SizedBox(height: 24),
          _buildTeleprompterCueCard(),
          const SizedBox(height: 24),
          _buildStreamMetadataCard(),
          const SizedBox(height: 24),
          _buildQuickStyleTemplates(),
          const SizedBox(height: 24),
          _buildLowerThirdEditor(),
          const SizedBox(height: 24),
          _buildCameraControlBar(),
          const SizedBox(height: 24),
          _buildPresetManager(),
        ],
      ),
    );
  }

  Widget _buildAudioMixerCard() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Multi-Channel Audio Mixer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      _isAudioMuted ? Icons.volume_off : Icons.volume_up,
                      color: _isAudioMuted ? Colors.redAccent : Colors.greenAccent,
                    ),
                    const SizedBox(width: 4),
                    Switch(
                      value: _isAudioMuted,
                      activeColor: Colors.red,
                      onChanged: (val) {
                        setState(() => _isAudioMuted = val);
                        _updateAudioMixerControl();
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 80, child: Text('Mic Gain', style: TextStyle(color: Colors.white))),
                Expanded(
                  child: Slider(
                    value: _micGain,
                    min: 0.0,
                    max: 2.0,
                    divisions: 20,
                    activeColor: Colors.red,
                    onChanged: (val) {
                      setState(() => _micGain = val);
                      _updateAudioMixerControl();
                    },
                  ),
                ),
                Text('${(_micGain * 100).toInt()}%', style: const TextStyle(color: Colors.white70)),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 80, child: Text('BGM Vol', style: TextStyle(color: Colors.white))),
                Expanded(
                  child: Slider(
                    value: _bgmVolume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    activeColor: Colors.blueAccent,
                    onChanged: (val) {
                      setState(() => _bgmVolume = val);
                      _updateAudioMixerControl();
                    },
                  ),
                ),
                Text('${(_bgmVolume * 100).toInt()}%', style: const TextStyle(color: Colors.white70)),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 80, child: Text('SFX Vol', style: TextStyle(color: Colors.white))),
                Expanded(
                  child: Slider(
                    value: _sfxVolume,
                    min: 0.0,
                    max: 1.0,
                    divisions: 20,
                    activeColor: Colors.amberAccent,
                    onChanged: (val) {
                      setState(() => _sfxVolume = val);
                      _updateAudioMixerControl();
                    },
                  ),
                ),
                Text('${(_sfxVolume * 100).toInt()}%', style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYoutubeLiveCard() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.play_circle_fill, color: Colors.red, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'YouTube Live & RTMP Ingestion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _youtubeUrlController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'YouTube RTMPS Ingestion Server URL',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _youtubeKeyController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'YouTube Stream Key (e.g. xxxx-xxxx-xxxx-xxxx)',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Cast to YouTube Live', style: TextStyle(color: Colors.white)),
                    Switch(
                      value: _isYoutubeCastingActive,
                      activeColor: Colors.red,
                      onChanged: (val) async {
                        setState(() => _isYoutubeCastingActive = val);
                        await _controller.saveRtmpDestination(
                          platformName: 'YouTube Live',
                          ingestionUrl: _youtubeUrlController.text,
                          streamKey: _youtubeKeyController.text,
                          isEnabled: val,
                        );
                      },
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff333333),
                  ),
                  onPressed: () async {
                    await _controller.saveRtmpDestination(
                      platformName: 'YouTube Live',
                      ingestionUrl: _youtubeUrlController.text,
                      streamKey: _youtubeKeyController.text,
                      isEnabled: _isYoutubeCastingActive,
                    );
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('YouTube Live destination saved successfully.')),
                      );
                    }
                  },
                  icon: const Icon(Icons.save, color: Colors.white, size: 16),
                  label: const Text('Save Settings', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeleprompterCueCard() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            const Text(
              'Producer Chat & Director Cue Teleprompter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _chatInputController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Enter cue message for camera operator...',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _sendProducerChat(isCue: true),
                    icon: const Icon(Icons.record_voice_over, color: Colors.white),
                    label: const Text('SEND DIRECTOR CUE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white38),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  onPressed: () => _sendProducerChat(isCue: false),
                  icon: const Icon(Icons.chat, color: Colors.white70),
                  label: const Text('CHAT ONLY', style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSceneSwitcherCard() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            const Text(
              'Scene & Source Switcher',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activeScene == 'camera' ? Colors.red : const Color(0xff333333),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _switchScene('camera'),
                    icon: const Icon(Icons.videocam, color: Colors.white),
                    label: const Text('CAMERA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activeScene == 'color_bars' ? Colors.amber[800] : const Color(0xff333333),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _switchScene('color_bars'),
                    icon: const Icon(Icons.grid_view, color: Colors.white),
                    label: const Text('COLOR BARS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _activeScene == 'black_slate' ? Colors.blueGrey[800] : const Color(0xff333333),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _switchScene('black_slate'),
                    icon: const Icon(Icons.crop_square, color: Colors.white),
                    label: const Text('BLACK SLATE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamMetadataCard() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            const Text(
              'Stream Metadata & Broadcast Status',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _streamTitleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Stream Title',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _streamDescController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      _isBroadcastingLive ? Icons.sensors : Icons.sensors_off,
                      color: _isBroadcastingLive ? Colors.red : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isBroadcastingLive ? 'BROADCAST IS LIVE' : 'BROADCAST IS OFF',
                      style: TextStyle(
                        color: _isBroadcastingLive ? Colors.red : Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isBroadcastingLive ? Colors.grey[800] : Colors.red,
                  ),
                  onPressed: () async {
                    final nextState = !_isBroadcastingLive;
                    setState(() => _isBroadcastingLive = nextState);
                    await _controller.saveMetadata(
                      title: _streamTitleController.text,
                      description: _streamDescController.text,
                      isLive: nextState,
                    );
                  },
                  icon: Icon(
                    _isBroadcastingLive ? Icons.stop : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  label: Text(
                    _isBroadcastingLive ? 'END BROADCAST' : 'GO LIVE',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStyleTemplates() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            const Text(
              'Quick Studio Templates',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionChip(
                  backgroundColor: const Color(0xffE50914),
                  label: const Text('Breaking News', style: TextStyle(color: Colors.white)),
                  onPressed: () => _applyQuickTemplate(
                    'BREAKING NEWS',
                    'Major update in live stream engine',
                    'lower_third',
                    '#E50914',
                    'slide',
                  ),
                ),
                ActionChip(
                  backgroundColor: const Color(0xff0066CC),
                  label: const Text('Top Badge', style: TextStyle(color: Colors.white)),
                  onPressed: () => _applyQuickTemplate(
                    'LIVE BROADCAST',
                    '',
                    'top_right',
                    '#0066CC',
                    'scale',
                  ),
                ),
                ActionChip(
                  backgroundColor: const Color(0xff111111),
                  label: const Text('Bottom Ticker', style: TextStyle(color: Colors.white)),
                  onPressed: () => _applyQuickTemplate(
                    'NEWS TICKER',
                    'StreamStudio engine running at 60fps with low-latency state sync',
                    'ticker',
                    '#111111',
                    'fade',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLowerThirdEditor() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            const Text(
              'Overlay & Lower-Third Editor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Title / Header',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _subtitleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Subtitle / Ticker Text',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedPosition,
                    dropdownColor: const Color(0xff2a2a2a),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Position',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'lower_third',
                        child: Text('Lower Third'),
                      ),
                      DropdownMenuItem(
                        value: 'top_right',
                        child: Text('Top Right Badge'),
                      ),
                      DropdownMenuItem(
                        value: 'ticker',
                        child: Text('Bottom Ticker'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedPosition = val);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedAnimationStyle,
                    dropdownColor: const Color(0xff2a2a2a),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Animation Effect',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'fade',
                        child: Text('Fade In/Out'),
                      ),
                      DropdownMenuItem(
                        value: 'slide',
                        child: Text('Slide Up'),
                      ),
                      DropdownMenuItem(
                        value: 'scale',
                        child: Text('Scale Up'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedAnimationStyle = val);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _backgroundColorHex,
              dropdownColor: const Color(0xff2a2a2a),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Background Color',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: '#E50914',
                  child: Text('Red (#E50914)'),
                ),
                DropdownMenuItem(
                  value: '#0066CC',
                  child: Text('Blue (#0066CC)'),
                ),
                DropdownMenuItem(
                  value: '#28A745',
                  child: Text('Green (#28A745)'),
                ),
                DropdownMenuItem(
                  value: '#111111',
                  child: Text('Dark (#111111)'),
                ),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() => _backgroundColorHex = val);
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => _pushOverlayLive(true),
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text(
                      'PUSH LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white38),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                  ),
                  onPressed: () => _pushOverlayLive(false),
                  icon: const Icon(Icons.visibility_off, color: Colors.white70),
                  label: const Text(
                    'HIDE',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraControlBar() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            const Text(
              'Remote Camera & Audio Controls',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.zoom_in, color: Colors.white70),
                const SizedBox(width: 8),
                Text(
                  'Zoom: ${_zoomLevel.toStringAsFixed(1)}x',
                  style: const TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Slider(
                    value: _zoomLevel,
                    min: 1.0,
                    max: 5.0,
                    divisions: 40,
                    activeColor: Colors.red,
                    onChanged: (val) {
                      setState(() => _zoomLevel = val);
                      _updateCameraControl();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flash_on, color: Colors.white70),
                    const SizedBox(width: 8),
                    const Text(
                      'Torch',
                      style: TextStyle(color: Colors.white),
                    ),
                    Switch(
                      value: _torchOn,
                      activeColor: Colors.red,
                      onChanged: (val) {
                        setState(() => _torchOn = val);
                        _updateCameraControl();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      _isAudioMuted ? Icons.mic_off : Icons.mic,
                      color: _isAudioMuted ? Colors.redAccent : Colors.greenAccent,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Mute Mic',
                      style: TextStyle(color: Colors.white),
                    ),
                    Switch(
                      value: _isAudioMuted,
                      activeColor: Colors.red,
                      onChanged: (val) {
                        setState(() => _isAudioMuted = val);
                        _updateCameraControl();
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff333333),
                minimumSize: const Size(double.infinity, 44),
              ),
              onPressed: () {
                setState(() {
                  _activeCameraIndex = _activeCameraIndex == 0 ? 1 : 0;
                });
                _updateCameraControl();
              },
              icon: const Icon(
                Icons.flip_camera_ios,
                color: Colors.white,
              ),
              label: Text(
                _activeCameraIndex == 0 ? 'Switch to Front Camera' : 'Switch to Back Camera',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetManager() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAlignment: CrossAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Saved Overlay Presets',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.red),
                  onPressed: () async {
                    final newPreset = OverlayPreset(
                      streamId: widget.streamId,
                      title: _titleController.text,
                      subtitle: _subtitleController.text,
                      position: _selectedPosition,
                      backgroundColor: _backgroundColorHex,
                      textColor: _textColorHex,
                    );
                    await _controller.savePreset(newPreset);
                    _loadPresets();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_presets.isEmpty)
              const Text(
                'No saved presets. Click + to save current lower-third setting.',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _presets.length,
                itemBuilder: (context, index) {
                  final preset = _presets[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      preset.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '${preset.position.toUpperCase()} • ${preset.subtitle}',
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.play_arrow, color: Colors.green),
                          onPressed: () {
                            setState(() {
                              _titleController.text = preset.title;
                              _subtitleController.text = preset.subtitle;
                              _selectedPosition = preset.position;
                              _backgroundColorHex = preset.backgroundColor;
                              _textColorHex = preset.textColor;
                            });
                            _pushOverlayLive(true);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            if (preset.id != null) {
                              await _controller.deletePreset(preset.id!);
                              _loadPresets();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _remoteRenderer.dispose();
    _peerConnection?.dispose();
    super.dispose();
  }
}
