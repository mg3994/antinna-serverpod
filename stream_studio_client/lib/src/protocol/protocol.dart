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
import 'audio_mixer_control.dart' as _i2;
import 'camera_control.dart' as _i3;
import 'greetings/greeting.dart' as _i4;
import 'overlay_config.dart' as _i5;
import 'overlay_preset.dart' as _i6;
import 'rtmp_destination.dart' as _i7;
import 'scene_control.dart' as _i8;
import 'signaling_message.dart' as _i9;
import 'stream_heartbeat.dart' as _i10;
import 'stream_metadata.dart' as _i11;
import 'studio_chat_message.dart' as _i12;
import 'package:stream_studio_client/src/protocol/overlay_preset.dart' as _i13;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
export 'audio_mixer_control.dart';
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

    if (t == _i2.AudioMixerControl) {
      return _i2.AudioMixerControl.fromJson(data) as T;
    }
    if (t == _i3.CameraControl) {
      return _i3.CameraControl.fromJson(data) as T;
    }
    if (t == _i4.Greeting) {
      return _i4.Greeting.fromJson(data) as T;
    }
    if (t == _i5.OverlayConfig) {
      return _i5.OverlayConfig.fromJson(data) as T;
    }
    if (t == _i6.OverlayPreset) {
      return _i6.OverlayPreset.fromJson(data) as T;
    }
    if (t == _i7.RtmpDestination) {
      return _i7.RtmpDestination.fromJson(data) as T;
    }
    if (t == _i8.SceneControl) {
      return _i8.SceneControl.fromJson(data) as T;
    }
    if (t == _i9.SignalingMessage) {
      return _i9.SignalingMessage.fromJson(data) as T;
    }
    if (t == _i10.StreamHeartbeat) {
      return _i10.StreamHeartbeat.fromJson(data) as T;
    }
    if (t == _i11.StreamMetadata) {
      return _i11.StreamMetadata.fromJson(data) as T;
    }
    if (t == _i12.StudioChatMessage) {
      return _i12.StudioChatMessage.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AudioMixerControl?>()) {
      return (data != null ? _i2.AudioMixerControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.CameraControl?>()) {
      return (data != null ? _i3.CameraControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Greeting?>()) {
      return (data != null ? _i4.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.OverlayConfig?>()) {
      return (data != null ? _i5.OverlayConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.OverlayPreset?>()) {
      return (data != null ? _i6.OverlayPreset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.RtmpDestination?>()) {
      return (data != null ? _i7.RtmpDestination.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.SceneControl?>()) {
      return (data != null ? _i8.SceneControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.SignalingMessage?>()) {
      return (data != null ? _i9.SignalingMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.StreamHeartbeat?>()) {
      return (data != null ? _i10.StreamHeartbeat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.StreamMetadata?>()) {
      return (data != null ? _i11.StreamMetadata.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.StudioChatMessage?>()) {
      return (data != null ? _i12.StudioChatMessage.fromJson(data) : null) as T;
    }
    if (t == List<_i13.OverlayPreset>) {
      return (data as List)
              .map((e) => deserialize<_i13.OverlayPreset>(e))
              .toList()
          as T;
    }
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AudioMixerControl => 'AudioMixerControl',
      _i3.CameraControl => 'CameraControl',
      _i4.Greeting => 'Greeting',
      _i5.OverlayConfig => 'OverlayConfig',
      _i6.OverlayPreset => 'OverlayPreset',
      _i7.RtmpDestination => 'RtmpDestination',
      _i8.SceneControl => 'SceneControl',
      _i9.SignalingMessage => 'SignalingMessage',
      _i10.StreamHeartbeat => 'StreamHeartbeat',
      _i11.StreamMetadata => 'StreamMetadata',
      _i12.StudioChatMessage => 'StudioChatMessage',
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
      case _i2.AudioMixerControl():
        return 'AudioMixerControl';
      case _i3.CameraControl():
        return 'CameraControl';
      case _i4.Greeting():
        return 'Greeting';
      case _i5.OverlayConfig():
        return 'OverlayConfig';
      case _i6.OverlayPreset():
        return 'OverlayPreset';
      case _i7.RtmpDestination():
        return 'RtmpDestination';
      case _i8.SceneControl():
        return 'SceneControl';
      case _i9.SignalingMessage():
        return 'SignalingMessage';
      case _i10.StreamHeartbeat():
        return 'StreamHeartbeat';
      case _i11.StreamMetadata():
        return 'StreamMetadata';
      case _i12.StudioChatMessage():
        return 'StudioChatMessage';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i15.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AudioMixerControl') {
      return deserialize<_i2.AudioMixerControl>(data['data']);
    }
    if (dataClassName == 'CameraControl') {
      return deserialize<_i3.CameraControl>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i4.Greeting>(data['data']);
    }
    if (dataClassName == 'OverlayConfig') {
      return deserialize<_i5.OverlayConfig>(data['data']);
    }
    if (dataClassName == 'OverlayPreset') {
      return deserialize<_i6.OverlayPreset>(data['data']);
    }
    if (dataClassName == 'RtmpDestination') {
      return deserialize<_i7.RtmpDestination>(data['data']);
    }
    if (dataClassName == 'SceneControl') {
      return deserialize<_i8.SceneControl>(data['data']);
    }
    if (dataClassName == 'SignalingMessage') {
      return deserialize<_i9.SignalingMessage>(data['data']);
    }
    if (dataClassName == 'StreamHeartbeat') {
      return deserialize<_i10.StreamHeartbeat>(data['data']);
    }
    if (dataClassName == 'StreamMetadata') {
      return deserialize<_i11.StreamMetadata>(data['data']);
    }
    if (dataClassName == 'StudioChatMessage') {
      return deserialize<_i12.StudioChatMessage>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i14.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i15.Protocol().deserializeByClassName(data);
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
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i15.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
