import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class OverlayPresetEndpoint extends Endpoint {
  /// Save a new overlay preset or update if existing ID provided
  Future<OverlayPreset> savePreset(
    Session session,
    OverlayPreset preset,
  ) async {
    if (preset.id != null) {
      return await OverlayPreset.db.updateRow(session, preset);
    } else {
      return await OverlayPreset.db.insertRow(session, preset);
    }
  }

  /// List all overlay presets for a specific streamId
  Future<List<OverlayPreset>> listPresets(
    Session session,
    String streamId,
  ) async {
    return await OverlayPreset.db.find(
      session,
      where: (t) => t.streamId.equals(streamId),
    );
  }

  /// Delete an overlay preset by ID
  Future<bool> deletePreset(
    Session session,
    int id,
  ) async {
    final deleted = await OverlayPreset.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    return deleted.isNotEmpty;
  }
}
