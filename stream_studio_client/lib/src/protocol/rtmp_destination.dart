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

abstract class RtmpDestination implements _i1.SerializableModel {
  RtmpDestination._({
    this.id,
    required this.streamId,
    required this.platformName,
    required this.ingestionUrl,
    required this.streamKey,
    required this.isEnabled,
  });

  factory RtmpDestination({
    int? id,
    required String streamId,
    required String platformName,
    required String ingestionUrl,
    required String streamKey,
    required bool isEnabled,
  }) = _RtmpDestinationImpl;

  factory RtmpDestination.fromJson(Map<String, dynamic> jsonSerialization) {
    return RtmpDestination(
      id: jsonSerialization['id'] as int?,
      streamId: jsonSerialization['streamId'] as String,
      platformName: jsonSerialization['platformName'] as String,
      ingestionUrl: jsonSerialization['ingestionUrl'] as String,
      streamKey: jsonSerialization['streamKey'] as String,
      isEnabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String streamId;

  String platformName;

  String ingestionUrl;

  String streamKey;

  bool isEnabled;

  /// Returns a shallow copy of this [RtmpDestination]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RtmpDestination copyWith({
    int? id,
    String? streamId,
    String? platformName,
    String? ingestionUrl,
    String? streamKey,
    bool? isEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RtmpDestination',
      if (id != null) 'id': id,
      'streamId': streamId,
      'platformName': platformName,
      'ingestionUrl': ingestionUrl,
      'streamKey': streamKey,
      'isEnabled': isEnabled,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RtmpDestinationImpl extends RtmpDestination {
  _RtmpDestinationImpl({
    int? id,
    required String streamId,
    required String platformName,
    required String ingestionUrl,
    required String streamKey,
    required bool isEnabled,
  }) : super._(
         id: id,
         streamId: streamId,
         platformName: platformName,
         ingestionUrl: ingestionUrl,
         streamKey: streamKey,
         isEnabled: isEnabled,
       );

  /// Returns a shallow copy of this [RtmpDestination]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RtmpDestination copyWith({
    Object? id = _Undefined,
    String? streamId,
    String? platformName,
    String? ingestionUrl,
    String? streamKey,
    bool? isEnabled,
  }) {
    return RtmpDestination(
      id: id is int? ? id : this.id,
      streamId: streamId ?? this.streamId,
      platformName: platformName ?? this.platformName,
      ingestionUrl: ingestionUrl ?? this.ingestionUrl,
      streamKey: streamKey ?? this.streamKey,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
