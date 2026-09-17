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
    );

    await client.studio.sendStreamMessage(overlay);
  }

  /// Sends remote camera adjustments (Zoom, Torch toggle, camera switcher)
  Future<void> updateCameraHardware({
    required double zoomLevel,
    required bool torchOn,
    int activeCameraIndex = 0,
  }) async {
    final control = CameraControl(
      streamId: streamId,
      torchOn: torchOn,
      zoomLevel: zoomLevel,
      activeCameraIndex: activeCameraIndex,
    );

    await client.studio.sendStreamMessage(control);
  }

  /// Sends a WebRTC signaling message
  Future<void> sendSignalingMessage(SignalingMessage signalingMessage) async {
    await client.studio.sendStreamMessage(signalingMessage);
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
