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

abstract class RecordingSession implements _i1.SerializableModel {
  RecordingSession._({
    this.id,
    required this.streamId,
    required this.fileName,
    required this.filePath,
    required this.fileSizeBytes,
    required this.status,
    required this.recordedAt,
  });

  factory RecordingSession({
    int? id,
    required String streamId,
    required String fileName,
    required String filePath,
    required int fileSizeBytes,
    required String status,
    required DateTime recordedAt,
  }) = _RecordingSessionImpl;

  factory RecordingSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return RecordingSession(
      id: jsonSerialization['id'] as int?,
      streamId: jsonSerialization['streamId'] as String,
      fileName: jsonSerialization['fileName'] as String,
      filePath: jsonSerialization['filePath'] as String,
      fileSizeBytes: jsonSerialization['fileSizeBytes'] as int,
      status: jsonSerialization['status'] as String,
      recordedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String streamId;

  String fileName;

  String filePath;

  int fileSizeBytes;

  String status;

  DateTime recordedAt;

  /// Returns a shallow copy of this [RecordingSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RecordingSession copyWith({
    int? id,
    String? streamId,
    String? fileName,
    String? filePath,
    int? fileSizeBytes,
    String? status,
    DateTime? recordedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RecordingSession',
      if (id != null) 'id': id,
      'streamId': streamId,
      'fileName': fileName,
      'filePath': filePath,
      'fileSizeBytes': fileSizeBytes,
      'status': status,
      'recordedAt': recordedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RecordingSessionImpl extends RecordingSession {
  _RecordingSessionImpl({
    int? id,
    required String streamId,
    required String fileName,
    required String filePath,
    required int fileSizeBytes,
    required String status,
    required DateTime recordedAt,
  }) : super._(
         id: id,
         streamId: streamId,
         fileName: fileName,
         filePath: filePath,
         fileSizeBytes: fileSizeBytes,
         status: status,
         recordedAt: recordedAt,
       );

  /// Returns a shallow copy of this [RecordingSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RecordingSession copyWith({
    Object? id = _Undefined,
    String? streamId,
    String? fileName,
    String? filePath,
    int? fileSizeBytes,
    String? status,
    DateTime? recordedAt,
  }) {
    return RecordingSession(
      id: id is int? ? id : this.id,
      streamId: streamId ?? this.streamId,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      status: status ?? this.status,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}
