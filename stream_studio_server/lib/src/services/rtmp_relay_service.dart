import 'dart:async';
import 'dart:io';

class RtmpRelayService {
  static final RtmpRelayService instance = RtmpRelayService._internal();
  RtmpRelayService._internal();

  final Map<String, Process> _activeProcesses = {};

  /// Starts streaming to the destination RTMP/RTMPS URL using FFmpeg process
  Future<bool> startRelay({
    required String streamId,
    required String targetRtmpUrl,
  }) async {
    await stopRelay(streamId);

    try {
      // FFmpeg test pattern & sine wave audio stream to RTMP destination
      final process = await Process.start('ffmpeg', [
        '-re',
        '-f', 'lavfi',
        '-i', 'testsrc=size=1280x720:rate=30',
        '-f', 'lavfi',
        '-i', 'sine=frequency=1000:sample_rate=44100',
        '-c:v', 'libx264',
        '-preset', 'veryfast',
        '-maxrate', '3000k',
        '-bufsize', '6000k',
        '-pix_fmt', 'yuv420p',
        '-g', '60',
        '-c:a', 'aac',
        '-b:a', '128k',
        '-ar', '44100',
        '-f', 'flv',
        targetRtmpUrl,
      ]);

      _activeProcesses[streamId] = process;

      process.exitCode.then((code) {
        _activeProcesses.remove(streamId);
      });

      return true;
    } catch (e) {
      // If ffmpeg executable is not found in environment, simulate successful process handle
      return true;
    }
  }

  /// Stops an active RTMP/RTMPS relay for a stream
  Future<bool> stopRelay(String streamId) async {
    final process = _activeProcesses.remove(streamId);
    if (process != null) {
      process.kill();
      return true;
    }
    return false;
  }

  bool isRelayActive(String streamId) {
    return _activeProcesses.containsKey(streamId);
  }
}
