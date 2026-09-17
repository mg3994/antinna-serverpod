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
      );

      final json = config.toJson();
      expect(json['id'], equals('123'));
      expect(json['streamId'], equals('room_1'));
      expect(json['title'], equals('Breaking News'));
      expect(json['isVisible'], equals(true));

      final deserialized = OverlayConfig.fromJson(json);
      expect(deserialized.id, equals('123'));
      expect(deserialized.title, equals('Breaking News'));
      expect(deserialized.backgroundColor, equals('#FF0000'));
    });

    test('CameraControl serialization and deserialization', () {
      final control = CameraControl(
        streamId: 'room_1',
        torchOn: true,
        zoomLevel: 2.5,
        activeCameraIndex: 1,
      );

      final json = control.toJson();
      expect(json['streamId'], equals('room_1'));
      expect(json['torchOn'], equals(true));
      expect(json['zoomLevel'], equals(2.5));
      expect(json['activeCameraIndex'], equals(1));

      final deserialized = CameraControl.fromJson(json);
      expect(deserialized.streamId, equals('room_1'));
      expect(deserialized.torchOn, equals(true));
      expect(deserialized.zoomLevel, equals(2.5));
      expect(deserialized.activeCameraIndex, equals(1));
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
        timestamp: DateTime.now(),
      );

      final json = heartbeat.toJson();
      expect(json['streamId'], equals('room_1'));
      expect(json['deviceId'], equals('cam_101'));
      expect(json['fps'], equals(30.0));
      expect(json['resolution'], equals('1280x720'));

      final deserialized = StreamHeartbeat.fromJson(json);
      expect(deserialized.streamId, equals('room_1'));
      expect(deserialized.deviceId, equals('cam_101'));
      expect(deserialized.fps, equals(30.0));
      expect(deserialized.resolution, equals('1280x720'));
    });
  });
}
