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

abstract class RecordingSession
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = RecordingSessionTable();

  static const db = RecordingSessionRepository._();

  @override
  int? id;

  String streamId;

  String fileName;

  String filePath;

  int fileSizeBytes;

  String status;

  DateTime recordedAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static RecordingSessionInclude include() {
    return RecordingSessionInclude._();
  }

  static RecordingSessionIncludeList includeList({
    _i1.WhereExpressionBuilder<RecordingSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RecordingSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RecordingSessionTable>? orderByList,
    RecordingSessionInclude? include,
  }) {
    return RecordingSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RecordingSession.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RecordingSession.t),
      include: include,
    );
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

class RecordingSessionUpdateTable
    extends _i1.UpdateTable<RecordingSessionTable> {
  RecordingSessionUpdateTable(super.table);

  _i1.ColumnValue<String, String> streamId(String value) => _i1.ColumnValue(
    table.streamId,
    value,
  );

  _i1.ColumnValue<String, String> fileName(String value) => _i1.ColumnValue(
    table.fileName,
    value,
  );

  _i1.ColumnValue<String, String> filePath(String value) => _i1.ColumnValue(
    table.filePath,
    value,
  );

  _i1.ColumnValue<int, int> fileSizeBytes(int value) => _i1.ColumnValue(
    table.fileSizeBytes,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> recordedAt(DateTime value) =>
      _i1.ColumnValue(
        table.recordedAt,
        value,
      );
}

class RecordingSessionTable extends _i1.Table<int?> {
  RecordingSessionTable({super.tableRelation})
    : super(tableName: 'recording_session') {
    updateTable = RecordingSessionUpdateTable(this);
    streamId = _i1.ColumnString(
      'streamId',
      this,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    filePath = _i1.ColumnString(
      'filePath',
      this,
    );
    fileSizeBytes = _i1.ColumnInt(
      'fileSizeBytes',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    recordedAt = _i1.ColumnDateTime(
      'recordedAt',
      this,
    );
  }

  late final RecordingSessionUpdateTable updateTable;

  late final _i1.ColumnString streamId;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnString filePath;

  late final _i1.ColumnInt fileSizeBytes;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime recordedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    streamId,
    fileName,
    filePath,
    fileSizeBytes,
    status,
    recordedAt,
  ];
}

class RecordingSessionInclude extends _i1.IncludeObject {
  RecordingSessionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RecordingSession.t;
}

class RecordingSessionIncludeList extends _i1.IncludeList {
  RecordingSessionIncludeList._({
    _i1.WhereExpressionBuilder<RecordingSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RecordingSession.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RecordingSession.t;
}

class RecordingSessionRepository {
  const RecordingSessionRepository._();

  /// Returns a list of [RecordingSession]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<RecordingSession>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RecordingSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RecordingSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RecordingSessionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RecordingSession>(
      where: where?.call(RecordingSession.t),
      orderBy: orderBy?.call(RecordingSession.t),
      orderByList: orderByList?.call(RecordingSession.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RecordingSession] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<RecordingSession?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RecordingSessionTable>? where,
    int? offset,
    _i1.OrderByBuilder<RecordingSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RecordingSessionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RecordingSession>(
      where: where?.call(RecordingSession.t),
      orderBy: orderBy?.call(RecordingSession.t),
      orderByList: orderByList?.call(RecordingSession.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RecordingSession] by its [id] or null if no such row exists.
  Future<RecordingSession?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RecordingSession>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RecordingSession]s in the list and returns the inserted rows.
  ///
  /// The returned [RecordingSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RecordingSession>> insert(
    _i1.DatabaseSession session,
    List<RecordingSession> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RecordingSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RecordingSession] and returns the inserted row.
  ///
  /// The returned [RecordingSession] will have its `id` field set.
  Future<RecordingSession> insertRow(
    _i1.DatabaseSession session,
    RecordingSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RecordingSession>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RecordingSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RecordingSession>> update(
    _i1.DatabaseSession session,
    List<RecordingSession> rows, {
    _i1.ColumnSelections<RecordingSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RecordingSession>(
      rows,
      columns: columns?.call(RecordingSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RecordingSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RecordingSession> updateRow(
    _i1.DatabaseSession session,
    RecordingSession row, {
    _i1.ColumnSelections<RecordingSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RecordingSession>(
      row,
      columns: columns?.call(RecordingSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RecordingSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RecordingSession?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RecordingSessionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RecordingSession>(
      id,
      columnValues: columnValues(RecordingSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RecordingSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RecordingSession>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RecordingSessionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<RecordingSessionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RecordingSessionTable>? orderBy,
    _i1.OrderByListBuilder<RecordingSessionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RecordingSession>(
      columnValues: columnValues(RecordingSession.t.updateTable),
      where: where(RecordingSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RecordingSession.t),
      orderByList: orderByList?.call(RecordingSession.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RecordingSession]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RecordingSession>> delete(
    _i1.DatabaseSession session,
    List<RecordingSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RecordingSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RecordingSession].
  Future<RecordingSession> deleteRow(
    _i1.DatabaseSession session,
    RecordingSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RecordingSession>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RecordingSession>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RecordingSessionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RecordingSession>(
      where: where(RecordingSession.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RecordingSessionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RecordingSession>(
      where: where?.call(RecordingSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RecordingSession] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RecordingSessionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RecordingSession>(
      where: where(RecordingSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
