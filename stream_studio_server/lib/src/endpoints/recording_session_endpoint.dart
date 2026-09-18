import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class RecordingSessionEndpoint extends Endpoint {
  /// Start an MP4 recording session on the server
  Future<RecordingSession> startRecording(
    Session session,
    String streamId,
  ) async {
    final now = DateTime.now();
    final fileName = 'recording_${streamId}_${now.millisecondsSinceEpoch}.mp4';
    final filePath = '/var/stream_studio/recordings/$streamId/$fileName';

    final recording = RecordingSession(
      streamId: streamId,
      fileName: fileName,
      filePath: filePath,
      fileSizeBytes: 0,
      status: 'recording',
      recordedAt: now,
    );

    return await RecordingSession.db.insertRow(session, recording);
  }

  /// Stop an active MP4 recording session on the server
  Future<RecordingSession?> stopRecording(
    Session session,
    int recordingId,
  ) async {
    final recording = await RecordingSession.db.findById(session, recordingId);
    if (recording == null) return null;

    final updated = recording.copyWith(
      status: 'completed',
      fileSizeBytes: 1024 * 1024 * 125, // Simulated 125 MB recorded file size
    );

    return await RecordingSession.db.updateRow(session, updated);
  }

  /// List saved MP4 recordings for a stream
  Future<List<RecordingSession>> listRecordings(
    Session session,
    String streamId,
  ) async {
    return await RecordingSession.db.find(
      session,
      where: (t) => t.streamId.equals(streamId),
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
    );
  }
}
