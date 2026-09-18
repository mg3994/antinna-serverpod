import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/rtmp_relay_service.dart';

class RtmpDestinationEndpoint extends Endpoint {
  /// Save or update an RTMP destination for YouTube Live / Social Platforms
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

  /// Start server-side RTMP/RTMPS casting process to YouTube Live / Twitch / Facebook Live
  Future<bool> startCasting(
    Session session,
    String streamId,
  ) async {
    final destination = await getDestination(session, streamId);
    if (destination == null || destination.streamKey.isEmpty) return false;

    String fullRtmpUrl = destination.ingestionUrl.trim();
    if (!fullRtmpUrl.endsWith('/')) {
      fullRtmpUrl += '/';
    }
    fullRtmpUrl += destination.streamKey.trim();

    return await RtmpRelayService.instance.startRelay(
      streamId: streamId,
      targetRtmpUrl: fullRtmpUrl,
    );
  }

  /// Stop server-side RTMP/RTMPS casting process
  Future<bool> stopCasting(
    Session session,
    String streamId,
  ) async {
    return await RtmpRelayService.instance.stopRelay(streamId);
  }
}
