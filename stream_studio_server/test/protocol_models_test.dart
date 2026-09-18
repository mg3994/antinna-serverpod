import 'package:test/test.dart';
import 'package:stream_studio_server/src/generated/protocol.dart';

void main() {
  group('StreamStudio Protocol Models Tests', () {
    test('OverlayConfig serialization and deserialization', () {
      final config = OverlayConfig(
        id: '123',
        streamId: 'room_1',
        title: 'Breaking News',
        subtitle: 'Live Stream Test',
        position: 'lower_third',
        isVisible: true,
        backgroundColor: '#FF0000',
        textColor: '#FFFFFF',
        animationStyle: 'slide',
      );

      final json = config.toJson();
      expect(json['id'], equals('123'));
      expect(json['streamId'], equals('room_1'));
      expect(json['title'], equals('Breaking News'));
      expect(json['isVisible'], equals(true));
      expect(json['animationStyle'], equals('slide'));

      final deserialized = OverlayConfig.fromJson(json);
      expect(deserialized.id, equals('123'));
      expect(deserialized.title, equals('Breaking News'));
      expect(deserialized.backgroundColor, equals('#FF0000'));
      expect(deserialized.animationStyle, equals('slide'));
    });

    test('CameraControl serialization and deserialization', () {
      final control = CameraControl(
        streamId: 'room_1',
        torchOn: true,
        zoomLevel: 2.5,
        activeCameraIndex: 1,
        isMuted: true,
      );

      final json = control.toJson();
      expect(json['streamId'], equals('room_1'));
      expect(json['torchOn'], equals(true));
      expect(json['zoomLevel'], equals(2.5));
      expect(json['activeCameraIndex'], equals(1));
      expect(json['isMuted'], equals(true));

      final deserialized = CameraControl.fromJson(json);
      expect(deserialized.streamId, equals('room_1'));
      expect(deserialized.torchOn, equals(true));
      expect(deserialized.zoomLevel, equals(2.5));
      expect(deserialized.activeCameraIndex, equals(1));
      expect(deserialized.isMuted, equals(true));
    });

    test('SignalingMessage serialization and deserialization', () {
      final signal = SignalingMessage(
        senderId: 'mobile_camera',
        targetId: 'web_companion',
        type: 'offer',
        sdp: 'v=0\r\no=- 12345 2 IN IP4 127.0.0.1\r\n',
      );

      final json = signal.toJson();
      expect(json['senderId'], equals('mobile_camera'));
      expect(json['targetId'], equals('web_companion'));
      expect(json['type'], equals('offer'));
      expect(json['sdp'], contains('v=0'));

      final deserialized = SignalingMessage.fromJson(json);
      expect(deserialized.senderId, equals('mobile_camera'));
      expect(deserialized.type, equals('offer'));
    });

    test('OverlayPreset serialization and deserialization', () {
      final preset = OverlayPreset(
        id: 1,
        streamId: 'room_1',
        title: 'Anchor Name',
        subtitle: 'Lead Host',
        position: 'lower_third',
        backgroundColor: '#E50914',
        textColor: '#FFFFFF',
      );

      final json = preset.toJson();
      expect(json['id'], equals(1));
      expect(json['title'], equals('Anchor Name'));

      final deserialized = OverlayPreset.fromJson(json);
      expect(deserialized.id, equals(1));
      expect(deserialized.title, equals('Anchor Name'));
    });

    test('StreamHeartbeat serialization and deserialization', () {
      final heartbeat = StreamHeartbeat(
        streamId: 'room_1',
        deviceId: 'cam_101',
        deviceType: 'mobile_camera',
        fps: 30.0,
        resolution: '1280x720',
        audioLevel: 0.85,
        timestamp: DateTime.now(),
      );

      final json = heartbeat.toJson();
      expect(json['streamId'], equals('room_1'));
      expect(json['deviceId'], equals('cam_101'));
      expect(json['fps'], equals(30.0));
      expect(json['resolution'], equals('1280x720'));
      expect(json['audioLevel'], equals(0.85));

      final deserialized = StreamHeartbeat.fromJson(json);
      expect(deserialized.streamId, equals('room_1'));
      expect(deserialized.deviceId, equals('cam_101'));
      expect(deserialized.fps, equals(30.0));
      expect(deserialized.resolution, equals('1280x720'));
      expect(deserialized.audioLevel, equals(0.85));
    });

    test('StreamMetadata serialization and deserialization', () {
      final metadata = StreamMetadata(
        id: 10,
        streamId: 'room_1',
        title: 'Keynote Broadcast',
        description: 'Live presentation',
        isLive: true,
        viewerCount: 150,
        startedAt: DateTime.now(),
      );

      final json = metadata.toJson();
      expect(json['id'], equals(10));
      expect(json['streamId'], equals('room_1'));
      expect(json['title'], equals('Keynote Broadcast'));
      expect(json['isLive'], equals(true));
      expect(json['viewerCount'], equals(150));

      final deserialized = StreamMetadata.fromJson(json);
      expect(deserialized.id, equals(10));
      expect(deserialized.streamId, equals('room_1'));
      expect(deserialized.title, equals('Keynote Broadcast'));
      expect(deserialized.isLive, equals(true));
      expect(deserialized.viewerCount, equals(150));
    });

    test('SceneControl serialization and deserialization', () {
      final scene = SceneControl(
        streamId: 'room_1',
        activeScene: 'color_bars',
        transitionType: 'fade',
      );

      final json = scene.toJson();
      expect(json['streamId'], equals('room_1'));
      expect(json['activeScene'], equals('color_bars'));
      expect(json['transitionType'], equals('fade'));

      final deserialized = SceneControl.fromJson(json);
      expect(deserialized.streamId, equals('room_1'));
      expect(deserialized.activeScene, equals('color_bars'));
      expect(deserialized.transitionType, equals('fade'));
    });

    test('StudioChatMessage serialization and deserialization', () {
      final chat = StudioChatMessage(
        streamId: 'room_1',
        senderName: 'Director',
        message: 'Wrap up presentation in 30 seconds',
        timestamp: DateTime.now(),
        isDirectorCue: true,
      );

      final json = chat.toJson();
      expect(json['streamId'], equals('room_1'));
      expect(json['senderName'], equals('Director'));
      expect(json['message'], equals('Wrap up presentation in 30 seconds'));
      expect(json['isDirectorCue'], equals(true));

      final deserialized = StudioChatMessage.fromJson(json);
      expect(deserialized.streamId, equals('room_1'));
      expect(deserialized.senderName, equals('Director'));
      expect(deserialized.message, equals('Wrap up presentation in 30 seconds'));
      expect(deserialized.isDirectorCue, equals(true));
    });

    test('RtmpDestination serialization and deserialization', () {
      final rtmp = RtmpDestination(
        id: 5,
        streamId: 'room_1',
        platformName: 'YouTube Live',
        ingestionUrl: 'rtmp://a.rtmp.youtube.com/live2',
        streamKey: 'abcd-efgh-ijkl-mnop',
        isEnabled: true,
      );

      final json = rtmp.toJson();
      expect(json['id'], equals(5));
      expect(json['streamId'], equals('room_1'));
      expect(json['platformName'], equals('YouTube Live'));
      expect(json['ingestionUrl'], equals('rtmp://a.rtmp.youtube.com/live2'));
      expect(json['streamKey'], equals('abcd-efgh-ijkl-mnop'));
      expect(json['isEnabled'], equals(true));

      final deserialized = RtmpDestination.fromJson(json);
      expect(deserialized.id, equals(5));
      expect(deserialized.platformName, equals('YouTube Live'));
      expect(deserialized.ingestionUrl, equals('rtmp://a.rtmp.youtube.com/live2'));
      expect(deserialized.isEnabled, equals(true));
    });
  });
}
