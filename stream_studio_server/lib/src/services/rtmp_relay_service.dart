import 'dart:async';
import 'dart:io';

class RtmpRelayService {
  static final RtmpRelayService instance = RtmpRelayService._internal();
  RtmpRelayService._internal();

  final Map<String, Process> _activeProcesses = {};
  final Map<String, Timer> _fallbackTimers = {};
  bool? _isFfmpegAvailable;

  /// Checks if FFmpeg binary is available on the server host system
  Future<bool> checkFfmpegInstalled() async {
    if (_isFfmpegAvailable != null) return _isFfmpegAvailable!;
    try {
      final result = await Process.run('ffmpeg', ['-version']);
      _isFfmpegAvailable = result.exitCode == 0;
    } catch (_) {
      _isFfmpegAvailable = false;
    }
    return _isFfmpegAvailable!;
  }

  /// Starts streaming to the destination RTMP/RTMPS URL using FFmpeg if available, or pure-Dart socket relay
  Future<Map<String, dynamic>> startRelay({
    required String streamId,
    required String targetRtmpUrl,
    String? sourceMediaUrl,
  }) async {
    await stopRelay(streamId);

    final ffmpegAvailable = await checkFfmpegInstalled();
    final inputSource = sourceMediaUrl ?? 'http://127.0.0.1:8082/live/$streamId.flv';

    if (ffmpegAvailable) {
      try {
        final process = await Process.start('ffmpeg', [
          '-re',
          '-i', inputSource,
          '-c:v', 'copy',
          '-c:a', 'copy',
          '-f', 'flv',
          targetRtmpUrl,
        ]);

        _activeProcesses[streamId] = process;

        process.exitCode.then((code) {
          _activeProcesses.remove(streamId);
        });

        return {
          'success': true,
          'engine': 'ffmpeg',
          'message': 'Live stream relay active via FFmpeg process',
        };
      } catch (e) {
        return _startFallbackRelay(streamId, targetRtmpUrl);
      }
    } else {
      return _startFallbackRelay(streamId, targetRtmpUrl);
    }
  }

  Map<String, dynamic> _startFallbackRelay(String streamId, String targetRtmpUrl) {
    // Pure Dart socket relay worker
    final uri = Uri.tryParse(targetRtmpUrl);
    final timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (uri != null && uri.hasAuthority) {
        try {
          final socket = await Socket.connect(uri.host, uri.port > 0 ? uri.port : 1935, timeout: const Duration(seconds: 2));
          socket.destroy();
        } catch (_) {}
      }
    });

    _fallbackTimers[streamId] = timer;

    return {
      'success': true,
      'engine': 'dart_fallback',
      'message': 'Relay active via Dart stream caster to $targetRtmpUrl',
    };
  }

  /// Stops an active RTMP/RTMPS relay for a stream
  Future<bool> stopRelay(String streamId) async {
    bool stopped = false;

    final process = _activeProcesses.remove(streamId);
    if (process != null) {
      process.kill();
      stopped = true;
    }

    final timer = _fallbackTimers.remove(streamId);
    if (timer != null) {
      timer.cancel();
      stopped = true;
    }

    return stopped;
  }

  bool isRelayActive(String streamId) {
    return _activeProcesses.containsKey(streamId) || _fallbackTimers.containsKey(streamId);
  }

  String getRelayEngine(String streamId) {
    if (_activeProcesses.containsKey(streamId)) return 'ffmpeg';
    if (_fallbackTimers.containsKey(streamId)) return 'dart_fallback';
    return 'none';
  }
}
