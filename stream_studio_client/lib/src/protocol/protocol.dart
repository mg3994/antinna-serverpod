/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'camera_control.dart' as _i2;
import 'greetings/greeting.dart' as _i3;
import 'overlay_config.dart' as _i4;
import 'overlay_preset.dart' as _i5;
import 'rtmp_destination.dart' as _i6;
import 'scene_control.dart' as _i7;
import 'signaling_message.dart' as _i8;
import 'stream_heartbeat.dart' as _i9;
import 'stream_metadata.dart' as _i10;
import 'studio_chat_message.dart' as _i11;
import 'package:stream_studio_client/src/protocol/overlay_preset.dart' as _i12;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i13;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i14;
export 'camera_control.dart';
export 'greetings/greeting.dart';
export 'overlay_config.dart';
export 'overlay_preset.dart';
export 'rtmp_destination.dart';
export 'scene_control.dart';
export 'signaling_message.dart';
export 'stream_heartbeat.dart';
export 'stream_metadata.dart';
export 'studio_chat_message.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.CameraControl) {
      return _i2.CameraControl.fromJson(data) as T;
    }
    if (t == _i3.Greeting) {
      return _i3.Greeting.fromJson(data) as T;
    }
    if (t == _i4.OverlayConfig) {
      return _i4.OverlayConfig.fromJson(data) as T;
    }
    if (t == _i5.OverlayPreset) {
      return _i5.OverlayPreset.fromJson(data) as T;
    }
    if (t == _i6.RtmpDestination) {
      return _i6.RtmpDestination.fromJson(data) as T;
    }
    if (t == _i7.SceneControl) {
      return _i7.SceneControl.fromJson(data) as T;
    }
    if (t == _i8.SignalingMessage) {
      return _i8.SignalingMessage.fromJson(data) as T;
    }
    if (t == _i9.StreamHeartbeat) {
      return _i9.StreamHeartbeat.fromJson(data) as T;
    }
    if (t == _i10.StreamMetadata) {
      return _i10.StreamMetadata.fromJson(data) as T;
    }
    if (t == _i11.StudioChatMessage) {
      return _i11.StudioChatMessage.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.CameraControl?>()) {
      return (data != null ? _i2.CameraControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Greeting?>()) {
      return (data != null ? _i3.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.OverlayConfig?>()) {
      return (data != null ? _i4.OverlayConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.OverlayPreset?>()) {
      return (data != null ? _i5.OverlayPreset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.RtmpDestination?>()) {
      return (data != null ? _i6.RtmpDestination.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.SceneControl?>()) {
      return (data != null ? _i7.SceneControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.SignalingMessage?>()) {
      return (data != null ? _i8.SignalingMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.StreamHeartbeat?>()) {
      return (data != null ? _i9.StreamHeartbeat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.StreamMetadata?>()) {
      return (data != null ? _i10.StreamMetadata.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.StudioChatMessage?>()) {
      return (data != null ? _i11.StudioChatMessage.fromJson(data) : null) as T;
    }
    if (t == List<_i12.OverlayPreset>) {
      return (data as List)
              .map((e) => deserialize<_i12.OverlayPreset>(e))
              .toList()
          as T;
    }
    try {
      return _i13.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.CameraControl => 'CameraControl',
      _i3.Greeting => 'Greeting',
      _i4.OverlayConfig => 'OverlayConfig',
      _i5.OverlayPreset => 'OverlayPreset',
      _i6.RtmpDestination => 'RtmpDestination',
      _i7.SceneControl => 'SceneControl',
      _i8.SignalingMessage => 'SignalingMessage',
      _i9.StreamHeartbeat => 'StreamHeartbeat',
      _i10.StreamMetadata => 'StreamMetadata',
      _i11.StudioChatMessage => 'StudioChatMessage',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'stream_studio.',
        '',
      );
    }

    switch (data) {
      case _i2.CameraControl():
        return 'CameraControl';
      case _i3.Greeting():
        return 'Greeting';
      case _i4.OverlayConfig():
        return 'OverlayConfig';
      case _i5.OverlayPreset():
        return 'OverlayPreset';
      case _i6.RtmpDestination():
        return 'RtmpDestination';
      case _i7.SceneControl():
        return 'SceneControl';
      case _i8.SignalingMessage():
        return 'SignalingMessage';
      case _i9.StreamHeartbeat():
        return 'StreamHeartbeat';
      case _i10.StreamMetadata():
        return 'StreamMetadata';
      case _i11.StudioChatMessage():
        return 'StudioChatMessage';
    }
    className = _i13.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CameraControl') {
      return deserialize<_i2.CameraControl>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i3.Greeting>(data['data']);
    }
    if (dataClassName == 'OverlayConfig') {
      return deserialize<_i4.OverlayConfig>(data['data']);
    }
    if (dataClassName == 'OverlayPreset') {
      return deserialize<_i5.OverlayPreset>(data['data']);
    }
    if (dataClassName == 'RtmpDestination') {
      return deserialize<_i6.RtmpDestination>(data['data']);
    }
    if (dataClassName == 'SceneControl') {
      return deserialize<_i7.SceneControl>(data['data']);
    }
    if (dataClassName == 'SignalingMessage') {
      return deserialize<_i8.SignalingMessage>(data['data']);
    }
    if (dataClassName == 'StreamHeartbeat') {
      return deserialize<_i9.StreamHeartbeat>(data['data']);
    }
    if (dataClassName == 'StreamMetadata') {
      return deserialize<_i10.StreamMetadata>(data['data']);
    }
    if (dataClassName == 'StudioChatMessage') {
      return deserialize<_i11.StudioChatMessage>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i13.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i14.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i13.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
