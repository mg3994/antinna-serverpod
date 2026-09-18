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

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'camera_control.dart' as _i5;
import 'greetings/greeting.dart' as _i6;
import 'overlay_config.dart' as _i7;
import 'overlay_preset.dart' as _i8;
import 'scene_control.dart' as _i9;
import 'signaling_message.dart' as _i10;
import 'stream_heartbeat.dart' as _i11;
import 'stream_metadata.dart' as _i12;
import 'studio_chat_message.dart' as _i13;
import 'package:stream_studio_server/src/generated/overlay_preset.dart' as _i14;
export 'camera_control.dart';
export 'greetings/greeting.dart';
export 'overlay_config.dart';
export 'overlay_preset.dart';
export 'scene_control.dart';
export 'signaling_message.dart';
export 'stream_heartbeat.dart';
export 'stream_metadata.dart';
export 'studio_chat_message.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'overlay_preset',
      dartName: 'OverlayPreset',
      schema: 'public',
      module: 'stream_studio',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'overlay_preset_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'streamId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subtitle',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'backgroundColor',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'textColor',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'overlay_preset_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'stream_metadata',
      dartName: 'StreamMetadata',
      schema: 'public',
      module: 'stream_studio',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'stream_metadata_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'streamId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isLive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'viewerCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'stream_metadata_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

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

    if (t == _i5.CameraControl) {
      return _i5.CameraControl.fromJson(data) as T;
    }
    if (t == _i6.Greeting) {
      return _i6.Greeting.fromJson(data) as T;
    }
    if (t == _i7.OverlayConfig) {
      return _i7.OverlayConfig.fromJson(data) as T;
    }
    if (t == _i8.OverlayPreset) {
      return _i8.OverlayPreset.fromJson(data) as T;
    }
    if (t == _i9.SceneControl) {
      return _i9.SceneControl.fromJson(data) as T;
    }
    if (t == _i10.SignalingMessage) {
      return _i10.SignalingMessage.fromJson(data) as T;
    }
    if (t == _i11.StreamHeartbeat) {
      return _i11.StreamHeartbeat.fromJson(data) as T;
    }
    if (t == _i12.StreamMetadata) {
      return _i12.StreamMetadata.fromJson(data) as T;
    }
    if (t == _i13.StudioChatMessage) {
      return _i13.StudioChatMessage.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.CameraControl?>()) {
      return (data != null ? _i5.CameraControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Greeting?>()) {
      return (data != null ? _i6.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.OverlayConfig?>()) {
      return (data != null ? _i7.OverlayConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.OverlayPreset?>()) {
      return (data != null ? _i8.OverlayPreset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.SceneControl?>()) {
      return (data != null ? _i9.SceneControl.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.SignalingMessage?>()) {
      return (data != null ? _i10.SignalingMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.StreamHeartbeat?>()) {
      return (data != null ? _i11.StreamHeartbeat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.StreamMetadata?>()) {
      return (data != null ? _i12.StreamMetadata.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.StudioChatMessage?>()) {
      return (data != null ? _i13.StudioChatMessage.fromJson(data) : null) as T;
    }
    if (t == List<_i14.OverlayPreset>) {
      return (data as List)
              .map((e) => deserialize<_i14.OverlayPreset>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.CameraControl => 'CameraControl',
      _i6.Greeting => 'Greeting',
      _i7.OverlayConfig => 'OverlayConfig',
      _i8.OverlayPreset => 'OverlayPreset',
      _i9.SceneControl => 'SceneControl',
      _i10.SignalingMessage => 'SignalingMessage',
      _i11.StreamHeartbeat => 'StreamHeartbeat',
      _i12.StreamMetadata => 'StreamMetadata',
      _i13.StudioChatMessage => 'StudioChatMessage',
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
      case _i5.CameraControl():
        return 'CameraControl';
      case _i6.Greeting():
        return 'Greeting';
      case _i7.OverlayConfig():
        return 'OverlayConfig';
      case _i8.OverlayPreset():
        return 'OverlayPreset';
      case _i9.SceneControl():
        return 'SceneControl';
      case _i10.SignalingMessage():
        return 'SignalingMessage';
      case _i11.StreamHeartbeat():
        return 'StreamHeartbeat';
      case _i12.StreamMetadata():
        return 'StreamMetadata';
      case _i13.StudioChatMessage():
        return 'StudioChatMessage';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
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
      return deserialize<_i5.CameraControl>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i6.Greeting>(data['data']);
    }
    if (dataClassName == 'OverlayConfig') {
      return deserialize<_i7.OverlayConfig>(data['data']);
    }
    if (dataClassName == 'OverlayPreset') {
      return deserialize<_i8.OverlayPreset>(data['data']);
    }
    if (dataClassName == 'SceneControl') {
      return deserialize<_i9.SceneControl>(data['data']);
    }
    if (dataClassName == 'SignalingMessage') {
      return deserialize<_i10.SignalingMessage>(data['data']);
    }
    if (dataClassName == 'StreamHeartbeat') {
      return deserialize<_i11.StreamHeartbeat>(data['data']);
    }
    if (dataClassName == 'StreamMetadata') {
      return deserialize<_i12.StreamMetadata>(data['data']);
    }
    if (dataClassName == 'StudioChatMessage') {
      return deserialize<_i13.StudioChatMessage>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i8.OverlayPreset:
        return _i8.OverlayPreset.t;
      case _i12.StreamMetadata:
        return _i12.StreamMetadata.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'stream_studio';

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
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
