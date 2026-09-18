import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StudioEndpoint extends StreamingEndpoint {
  static const String _channelPrefix = 'studio_room_';
  final Map<StreamingSession, MessageListener> _listeners = {};

  @override
  Future<void> streamOpened(StreamingSession session) async {
    final streamId = session.queryParameters['streamId'] ?? 'default_session';

    void listener(SerializableModel message) {
      sendStreamMessage(session, message);
    }

    _listeners[session] = listener;

    // Subscribe websocket connection to stream room channel
    session.messages.addListener(
      '$_channelPrefix$streamId',
      listener,
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
        message is SignalingMessage ||
        message is StreamHeartbeat ||
        message is SceneControl) {
      session.messages.postMessage(
        '$_channelPrefix$streamId',
        message,
      );
    }
  }

  @override
  Future<void> streamClosed(StreamingSession session) async {
    final streamId = session.queryParameters['streamId'] ?? 'default_session';
    final listener = _listeners.remove(session);
    if (listener != null) {
      session.messages.removeListener('$_channelPrefix$streamId', listener);
    }
  }
}
