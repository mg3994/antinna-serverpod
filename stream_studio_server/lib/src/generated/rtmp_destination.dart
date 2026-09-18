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

abstract class RtmpDestination
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = RtmpDestinationTable();

  static const db = RtmpDestinationRepository._();

  @override
  int? id;

  String streamId;

  String platformName;

  String ingestionUrl;

  String streamKey;

  bool isEnabled;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static RtmpDestinationInclude include() {
    return RtmpDestinationInclude._();
  }

  static RtmpDestinationIncludeList includeList({
    _i1.WhereExpressionBuilder<RtmpDestinationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RtmpDestinationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    RtmpDestinationInclude? include,
  }) {
    return RtmpDestinationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RtmpDestination.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RtmpDestination.t),
      include: include,
    );
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

class RtmpDestinationUpdateTable extends _i1.UpdateTable<RtmpDestinationTable> {
  RtmpDestinationUpdateTable(super.table);

  _i1.ColumnValue<String, String> streamId(String value) => _i1.ColumnValue(
    table.streamId,
    value,
  );

  _i1.ColumnValue<String, String> platformName(String value) => _i1.ColumnValue(
    table.platformName,
    value,
  );

  _i1.ColumnValue<String, String> ingestionUrl(String value) => _i1.ColumnValue(
    table.ingestionUrl,
    value,
  );

  _i1.ColumnValue<String, String> streamKey(String value) => _i1.ColumnValue(
    table.streamKey,
    value,
  );

  _i1.ColumnValue<bool, bool> isEnabled(bool value) => _i1.ColumnValue(
    table.isEnabled,
    value,
  );
}

class RtmpDestinationTable extends _i1.Table<int?> {
  RtmpDestinationTable({super.tableRelation})
    : super(tableName: 'rtmp_destination') {
    updateTable = RtmpDestinationUpdateTable(this);
    streamId = _i1.ColumnString(
      'streamId',
      this,
    );
    platformName = _i1.ColumnString(
      'platformName',
      this,
    );
    ingestionUrl = _i1.ColumnString(
      'ingestionUrl',
      this,
    );
    streamKey = _i1.ColumnString(
      'streamKey',
      this,
    );
    isEnabled = _i1.ColumnBool(
      'isEnabled',
      this,
    );
  }

  late final RtmpDestinationUpdateTable updateTable;

  late final _i1.ColumnString streamId;

  late final _i1.ColumnString platformName;

  late final _i1.ColumnString ingestionUrl;

  late final _i1.ColumnString streamKey;

  late final _i1.ColumnBool isEnabled;

  @override
  List<_i1.Column> get columns => [
    id,
    streamId,
    platformName,
    ingestionUrl,
    streamKey,
    isEnabled,
  ];
}

class RtmpDestinationInclude extends _i1.IncludeObject {
  RtmpDestinationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RtmpDestination.t;
}

class RtmpDestinationIncludeList extends _i1.IncludeList {
  RtmpDestinationIncludeList._({
    _i1.WhereExpressionBuilder<RtmpDestinationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RtmpDestination.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RtmpDestination.t;
}

class RtmpDestinationRepository {
  const RtmpDestinationRepository._();

  /// Returns a list of [RtmpDestination]s matching the given query parameters.
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
  Future<List<RtmpDestination>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RtmpDestinationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RtmpDestinationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RtmpDestination>(
      where: where?.call(RtmpDestination.t),
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RtmpDestination] matching the given query parameters.
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
  Future<RtmpDestination?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RtmpDestinationTable>? where,
    int? offset,
    _i1.OrderByBuilder<RtmpDestinationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RtmpDestination>(
      where: where?.call(RtmpDestination.t),
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RtmpDestination] by its [id] or null if no such row exists.
  Future<RtmpDestination?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RtmpDestination>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RtmpDestination]s in the list and returns the inserted rows.
  ///
  /// The returned [RtmpDestination]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RtmpDestination>> insert(
    _i1.DatabaseSession session,
    List<RtmpDestination> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RtmpDestination>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RtmpDestination] and returns the inserted row.
  ///
  /// The returned [RtmpDestination] will have its `id` field set.
  Future<RtmpDestination> insertRow(
    _i1.DatabaseSession session,
    RtmpDestination row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RtmpDestination>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RtmpDestination]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RtmpDestination>> update(
    _i1.DatabaseSession session,
    List<RtmpDestination> rows, {
    _i1.ColumnSelections<RtmpDestinationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RtmpDestination>(
      rows,
      columns: columns?.call(RtmpDestination.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RtmpDestination]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RtmpDestination> updateRow(
    _i1.DatabaseSession session,
    RtmpDestination row, {
    _i1.ColumnSelections<RtmpDestinationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RtmpDestination>(
      row,
      columns: columns?.call(RtmpDestination.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RtmpDestination] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RtmpDestination?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RtmpDestinationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RtmpDestination>(
      id,
      columnValues: columnValues(RtmpDestination.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RtmpDestination]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RtmpDestination>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RtmpDestinationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<RtmpDestinationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RtmpDestinationTable>? orderBy,
    _i1.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RtmpDestination>(
      columnValues: columnValues(RtmpDestination.t.updateTable),
      where: where(RtmpDestination.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RtmpDestination]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RtmpDestination>> delete(
    _i1.DatabaseSession session,
    List<RtmpDestination> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RtmpDestination>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RtmpDestination].
  Future<RtmpDestination> deleteRow(
    _i1.DatabaseSession session,
    RtmpDestination row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RtmpDestination>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RtmpDestination>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RtmpDestinationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RtmpDestination>(
      where: where(RtmpDestination.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RtmpDestinationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RtmpDestination>(
      where: where?.call(RtmpDestination.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RtmpDestination] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RtmpDestinationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RtmpDestination>(
      where: where(RtmpDestination.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
