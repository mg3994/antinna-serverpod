import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class RtmpDestinationEndpoint extends Endpoint {
  /// Save or update an RTMP destination for YouTube Live
  Future<RtmpDestination> saveDestination(
    Session session,
    RtmpDestination destination,
  ) async {
    if (destination.id != null) {
      return await RtmpDestination.db.updateRow(session, destination);
    } else {
      return await RtmpDestination.db.insertRow(session, destination);
    }
  }

  /// Get the active RTMP destination configuration for a streamId
  Future<RtmpDestination?> getDestination(
    Session session,
    String streamId,
  ) async {
    return await RtmpDestination.db.findFirstRow(
      session,
      where: (t) => t.streamId.equals(streamId),
    );
  }
}
