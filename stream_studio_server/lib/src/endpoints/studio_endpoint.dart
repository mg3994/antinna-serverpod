import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StudioEndpoint extends StreamingEndpoint {
  static const String _channelPrefix = 'studio_room_';

  @override
  Future<void> streamOpened(StreamingSession session) async {
    final streamId = session.queryParameters['streamId'] ?? 'default_session';

    // Subscribe websocket connection to stream room channel
    session.messages.addListener(
      '$_channelPrefix$streamId',
      (message) {
        sendStreamMessage(session, message);
      },
    );
  }

  @override
  Future<void> handleStreamMessage(
    StreamingSession session,
    SerializableModel message,
  ) async {
    final streamId = session.queryParameters['streamId'] ?? 'default_session';

    // Intercept and broadcast recognized studio messages to room
    if (message is OverlayConfig ||
        message is CameraControl ||
        message is SignalingMessage) {
      session.messages.postMessage(
        '$_channelPrefix$streamId',
        message,
      );
    }
  }

  @override
  Future<void> streamClosed(StreamingSession session) async {
    final streamId = session.queryParameters['streamId'] ?? 'default_session';
    session.messages.removeListener('$_channelPrefix$streamId');
  }
}
