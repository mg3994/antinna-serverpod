import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StreamMetadataEndpoint extends Endpoint {
  /// Save or update stream metadata
  Future<StreamMetadata> saveMetadata(
    Session session,
    StreamMetadata metadata,
  ) async {
    if (metadata.id != null) {
      return await StreamMetadata.db.updateRow(session, metadata);
    } else {
      return await StreamMetadata.db.insertRow(session, metadata);
    }
  }

  /// Get metadata for a specific streamId
  Future<StreamMetadata?> getMetadata(
    Session session,
    String streamId,
  ) async {
    return await StreamMetadata.db.findFirstRow(
      session,
      where: (t) => t.streamId.equals(streamId),
    );
  }
}
