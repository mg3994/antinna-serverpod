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

abstract class StreamMetadata
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StreamMetadata._({
    this.id,
    required this.streamId,
    required this.title,
    required this.description,
    required this.isLive,
    required this.viewerCount,
    this.startedAt,
  });

  factory StreamMetadata({
    int? id,
    required String streamId,
    required String title,
    required String description,
    required bool isLive,
    required int viewerCount,
    DateTime? startedAt,
  }) = _StreamMetadataImpl;

  factory StreamMetadata.fromJson(Map<String, dynamic> jsonSerialization) {
    return StreamMetadata(
      id: jsonSerialization['id'] as int?,
      streamId: jsonSerialization['streamId'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      isLive: _i1.BoolJsonExtension.fromJson(jsonSerialization['isLive']),
      viewerCount: jsonSerialization['viewerCount'] as int,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
    );
  }

  static final t = StreamMetadataTable();

  static const db = StreamMetadataRepository._();

  @override
  int? id;

  String streamId;

  String title;

  String description;

  bool isLive;

  int viewerCount;

  DateTime? startedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StreamMetadata]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StreamMetadata copyWith({
    int? id,
    String? streamId,
    String? title,
    String? description,
    bool? isLive,
    int? viewerCount,
    DateTime? startedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StreamMetadata',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'description': description,
      'isLive': isLive,
      'viewerCount': viewerCount,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StreamMetadata',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'description': description,
      'isLive': isLive,
      'viewerCount': viewerCount,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
    };
  }

  static StreamMetadataInclude include() {
    return StreamMetadataInclude._();
  }

  static StreamMetadataIncludeList includeList({
    _i1.WhereExpressionBuilder<StreamMetadataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StreamMetadataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StreamMetadataTable>? orderByList,
    StreamMetadataInclude? include,
  }) {
    return StreamMetadataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StreamMetadata.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StreamMetadata.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StreamMetadataImpl extends StreamMetadata {
  _StreamMetadataImpl({
    int? id,
    required String streamId,
    required String title,
    required String description,
    required bool isLive,
    required int viewerCount,
    DateTime? startedAt,
  }) : super._(
         id: id,
         streamId: streamId,
         title: title,
         description: description,
         isLive: isLive,
         viewerCount: viewerCount,
         startedAt: startedAt,
       );

  /// Returns a shallow copy of this [StreamMetadata]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StreamMetadata copyWith({
    Object? id = _Undefined,
    String? streamId,
    String? title,
    String? description,
    bool? isLive,
    int? viewerCount,
    Object? startedAt = _Undefined,
  }) {
    return StreamMetadata(
      id: id is int? ? id : this.id,
      streamId: streamId ?? this.streamId,
      title: title ?? this.title,
      description: description ?? this.description,
      isLive: isLive ?? this.isLive,
      viewerCount: viewerCount ?? this.viewerCount,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
    );
  }
}

class StreamMetadataUpdateTable extends _i1.UpdateTable<StreamMetadataTable> {
  StreamMetadataUpdateTable(super.table);

  _i1.ColumnValue<String, String> streamId(String value) => _i1.ColumnValue(
    table.streamId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<bool, bool> isLive(bool value) => _i1.ColumnValue(
    table.isLive,
    value,
  );

  _i1.ColumnValue<int, int> viewerCount(int value) => _i1.ColumnValue(
    table.viewerCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );
}

class StreamMetadataTable extends _i1.Table<int?> {
  StreamMetadataTable({super.tableRelation})
    : super(tableName: 'stream_metadata') {
    updateTable = StreamMetadataUpdateTable(this);
    streamId = _i1.ColumnString(
      'streamId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    isLive = _i1.ColumnBool(
      'isLive',
      this,
    );
    viewerCount = _i1.ColumnInt(
      'viewerCount',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
  }

  late final StreamMetadataUpdateTable updateTable;

  late final _i1.ColumnString streamId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnBool isLive;

  late final _i1.ColumnInt viewerCount;

  late final _i1.ColumnDateTime startedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    streamId,
    title,
    description,
    isLive,
    viewerCount,
    startedAt,
  ];
}

class StreamMetadataInclude extends _i1.IncludeObject {
  StreamMetadataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StreamMetadata.t;
}

class StreamMetadataIncludeList extends _i1.IncludeList {
  StreamMetadataIncludeList._({
    _i1.WhereExpressionBuilder<StreamMetadataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StreamMetadata.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StreamMetadata.t;
}

class StreamMetadataRepository {
  const StreamMetadataRepository._();

  /// Returns a list of [StreamMetadata]s matching the given query parameters.
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
  Future<List<StreamMetadata>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StreamMetadataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StreamMetadataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StreamMetadataTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StreamMetadata>(
      where: where?.call(StreamMetadata.t),
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StreamMetadata] matching the given query parameters.
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
  Future<StreamMetadata?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StreamMetadataTable>? where,
    int? offset,
    _i1.OrderByBuilder<StreamMetadataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StreamMetadataTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StreamMetadata>(
      where: where?.call(StreamMetadata.t),
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StreamMetadata] by its [id] or null if no such row exists.
  Future<StreamMetadata?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StreamMetadata>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StreamMetadata]s in the list and returns the inserted rows.
  ///
  /// The returned [StreamMetadata]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StreamMetadata>> insert(
    _i1.DatabaseSession session,
    List<StreamMetadata> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StreamMetadata>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StreamMetadata] and returns the inserted row.
  ///
  /// The returned [StreamMetadata] will have its `id` field set.
  Future<StreamMetadata> insertRow(
    _i1.DatabaseSession session,
    StreamMetadata row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StreamMetadata>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StreamMetadata]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StreamMetadata>> update(
    _i1.DatabaseSession session,
    List<StreamMetadata> rows, {
    _i1.ColumnSelections<StreamMetadataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StreamMetadata>(
      rows,
      columns: columns?.call(StreamMetadata.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StreamMetadata]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StreamMetadata> updateRow(
    _i1.DatabaseSession session,
    StreamMetadata row, {
    _i1.ColumnSelections<StreamMetadataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StreamMetadata>(
      row,
      columns: columns?.call(StreamMetadata.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StreamMetadata] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StreamMetadata?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StreamMetadataUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StreamMetadata>(
      id,
      columnValues: columnValues(StreamMetadata.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StreamMetadata]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StreamMetadata>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StreamMetadataUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StreamMetadataTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StreamMetadataTable>? orderBy,
    _i1.OrderByListBuilder<StreamMetadataTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StreamMetadata>(
      columnValues: columnValues(StreamMetadata.t.updateTable),
      where: where(StreamMetadata.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StreamMetadata]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StreamMetadata>> delete(
    _i1.DatabaseSession session,
    List<StreamMetadata> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StreamMetadata>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StreamMetadata].
  Future<StreamMetadata> deleteRow(
    _i1.DatabaseSession session,
    StreamMetadata row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StreamMetadata>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StreamMetadata>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StreamMetadataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StreamMetadata>(
      where: where(StreamMetadata.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StreamMetadataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StreamMetadata>(
      where: where?.call(StreamMetadata.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StreamMetadata] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StreamMetadataTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StreamMetadata>(
      where: where(StreamMetadata.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
