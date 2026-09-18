import 'package:stream_studio_client/stream_studio_client.dart';

class StudioController {
  final Client client;
  final String streamId;

  StudioController({required this.client, required this.streamId});

  /// Broadcasts lower-third overlay changes to connected camera feeds
  Future<void> sendOverlay({
    required String title,
    required String subtitle,
    required bool isVisible,
    String position = 'lower_third',
    String backgroundColor = '#E50914',
    String textColor = '#FFFFFF',
    String animationStyle = 'fade',
  }) async {
    final overlay = OverlayConfig(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      streamId: streamId,
      title: title,
      subtitle: subtitle,
      position: position,
      isVisible: isVisible,
      backgroundColor: backgroundColor,
      textColor: textColor,
      animationStyle: animationStyle,
    );

    await client.studio.sendStreamMessage(overlay);
  }

  /// Sends remote camera adjustments (Zoom, Torch toggle, camera switcher, mic mute)
  Future<void> updateCameraHardware({
    required double zoomLevel,
    required bool torchOn,
    int activeCameraIndex = 0,
    bool isMuted = false,
  }) async {
    final control = CameraControl(
      streamId: streamId,
      torchOn: torchOn,
      zoomLevel: zoomLevel,
      activeCameraIndex: activeCameraIndex,
      isMuted: isMuted,
    );

    await client.studio.sendStreamMessage(control);
  }

  /// Sends multi-channel audio mixer controls (Mic Gain, BGM, SFX)
  Future<void> updateAudioMixer({
    required double micGain,
    required double bgmVolume,
    required double sfxVolume,
    required bool isMuted,
  }) async {
    final mixer = AudioMixerControl(
      streamId: streamId,
      micGain: micGain,
      bgmVolume: bgmVolume,
      sfxVolume: sfxVolume,
      isMuted: isMuted,
    );

    await client.studio.sendStreamMessage(mixer);
  }

  /// Sends scene switching commands (Camera, Color Bars, Black Slate)
  Future<void> sendSceneControl({
    required String activeScene,
    String transitionType = 'fade',
  }) async {
    final scene = SceneControl(
      streamId: streamId,
      activeScene: activeScene,
      transitionType: transitionType,
    );

    await client.studio.sendStreamMessage(scene);
  }

  /// Sends producer chat / teleprompter cue messages
  Future<void> sendChatMessage({
    required String senderName,
    required String message,
    bool isDirectorCue = false,
  }) async {
    final chatMsg = StudioChatMessage(
      streamId: streamId,
      senderName: senderName,
      message: message,
      timestamp: DateTime.now(),
      isDirectorCue: isDirectorCue,
    );

    await client.studio.sendStreamMessage(chatMsg);
  }

  /// Sends a WebRTC signaling message
  Future<void> sendSignalingMessage(SignalingMessage signalingMessage) async {
    await client.studio.sendStreamMessage(signalingMessage);
  }

  /// Stream metadata operations
  Future<StreamMetadata?> getMetadata() async {
    return await client.streamMetadata.getMetadata(streamId);
  }

  Future<StreamMetadata> saveMetadata({
    required String title,
    required String description,
    required bool isLive,
  }) async {
    final existing = await getMetadata();
    final metadata = StreamMetadata(
      id: existing?.id,
      streamId: streamId,
      title: title,
      description: description,
      isLive: isLive,
      viewerCount: existing?.viewerCount ?? 1,
      startedAt: isLive ? (existing?.startedAt ?? DateTime.now()) : null,
    );
    return await client.streamMetadata.saveMetadata(metadata);
  }

  /// YouTube Live, Facebook Live, Twitch & Custom RTMP Destination operations
  Future<RtmpDestination?> getRtmpDestination() async {
    return await client.rtmpDestination.getDestination(streamId);
  }

  Future<RtmpDestination> saveRtmpDestination({
    required String platformName,
    required String ingestionUrl,
    required String streamKey,
    required bool isEnabled,
  }) async {
    final existing = await getRtmpDestination();
    final destination = RtmpDestination(
      id: existing?.id,
      streamId: streamId,
      platformName: platformName,
      ingestionUrl: ingestionUrl,
      streamKey: streamKey,
      isEnabled: isEnabled,
    );
    return await client.rtmpDestination.saveDestination(destination);
  }

  Future<bool> startCasting() async {
    return await client.rtmpDestination.startCasting(streamId);
  }

  Future<bool> stopCasting() async {
    return await client.rtmpDestination.stopCasting(streamId);
  }

  Future<String> getRelayStatus() async {
    return await client.rtmpDestination.getRelayStatus(streamId);
  }

  /// Server-side MP4 recording operations
  Future<RecordingSession> startRecording() async {
    return await client.recordingSession.startRecording(streamId);
  }

  Future<RecordingSession?> stopRecording(int recordingId) async {
    return await client.recordingSession.stopRecording(recordingId);
  }

  Future<List<RecordingSession>> listRecordings() async {
    return await client.recordingSession.listRecordings(streamId);
  }

  /// Preset operations using PostgreSQL ORM endpoint
  Future<OverlayPreset> savePreset(OverlayPreset preset) async {
    return await client.overlayPreset.savePreset(preset);
  }

  Future<List<OverlayPreset>> listPresets() async {
    return await client.overlayPreset.listPresets(streamId);
  }

  Future<bool> deletePreset(int id) async {
    return await client.overlayPreset.deletePreset(id);
  }
}
