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
