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

abstract class OverlayPreset
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OverlayPreset._({
    this.id,
    required this.streamId,
    required this.title,
    required this.subtitle,
    required this.position,
    required this.backgroundColor,
    required this.textColor,
  });

  factory OverlayPreset({
    int? id,
    required String streamId,
    required String title,
    required String subtitle,
    required String position,
    required String backgroundColor,
    required String textColor,
  }) = _OverlayPresetImpl;

  factory OverlayPreset.fromJson(Map<String, dynamic> jsonSerialization) {
    return OverlayPreset(
      id: jsonSerialization['id'] as int?,
      streamId: jsonSerialization['streamId'] as String,
      title: jsonSerialization['title'] as String,
      subtitle: jsonSerialization['subtitle'] as String,
      position: jsonSerialization['position'] as String,
      backgroundColor: jsonSerialization['backgroundColor'] as String,
      textColor: jsonSerialization['textColor'] as String,
    );
  }

  static final t = OverlayPresetTable();

  static const db = OverlayPresetRepository._();

  @override
  int? id;

  String streamId;

  String title;

  String subtitle;

  String position;

  String backgroundColor;

  String textColor;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OverlayPreset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OverlayPreset copyWith({
    int? id,
    String? streamId,
    String? title,
    String? subtitle,
    String? position,
    String? backgroundColor,
    String? textColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OverlayPreset',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'subtitle': subtitle,
      'position': position,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OverlayPreset',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'subtitle': subtitle,
      'position': position,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  static OverlayPresetInclude include() {
    return OverlayPresetInclude._();
  }

  static OverlayPresetIncludeList includeList({
    _i1.WhereExpressionBuilder<OverlayPresetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OverlayPresetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OverlayPresetTable>? orderByList,
    OverlayPresetInclude? include,
  }) {
    return OverlayPresetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OverlayPreset.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OverlayPreset.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OverlayPresetImpl extends OverlayPreset {
  _OverlayPresetImpl({
    int? id,
    required String streamId,
    required String title,
    required String subtitle,
    required String position,
    required String backgroundColor,
    required String textColor,
  }) : super._(
         id: id,
         streamId: streamId,
         title: title,
         subtitle: subtitle,
         position: position,
         backgroundColor: backgroundColor,
         textColor: textColor,
       );

  /// Returns a shallow copy of this [OverlayPreset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OverlayPreset copyWith({
    Object? id = _Undefined,
    String? streamId,
    String? title,
    String? subtitle,
    String? position,
    String? backgroundColor,
    String? textColor,
  }) {
    return OverlayPreset(
      id: id is int? ? id : this.id,
      streamId: streamId ?? this.streamId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      position: position ?? this.position,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }
}

class OverlayPresetUpdateTable extends _i1.UpdateTable<OverlayPresetTable> {
  OverlayPresetUpdateTable(super.table);

  _i1.ColumnValue<String, String> streamId(String value) => _i1.ColumnValue(
    table.streamId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> subtitle(String value) => _i1.ColumnValue(
    table.subtitle,
    value,
  );

  _i1.ColumnValue<String, String> position(String value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<String, String> backgroundColor(String value) =>
      _i1.ColumnValue(
        table.backgroundColor,
        value,
      );

  _i1.ColumnValue<String, String> textColor(String value) => _i1.ColumnValue(
    table.textColor,
    value,
  );
}

class OverlayPresetTable extends _i1.Table<int?> {
  OverlayPresetTable({super.tableRelation})
    : super(tableName: 'overlay_preset') {
    updateTable = OverlayPresetUpdateTable(this);
    streamId = _i1.ColumnString(
      'streamId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    subtitle = _i1.ColumnString(
      'subtitle',
      this,
    );
    position = _i1.ColumnString(
      'position',
      this,
    );
    backgroundColor = _i1.ColumnString(
      'backgroundColor',
      this,
    );
    textColor = _i1.ColumnString(
      'textColor',
      this,
    );
  }

  late final OverlayPresetUpdateTable updateTable;

  late final _i1.ColumnString streamId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString subtitle;

  late final _i1.ColumnString position;

  late final _i1.ColumnString backgroundColor;

  late final _i1.ColumnString textColor;

  @override
  List<_i1.Column> get columns => [
    id,
    streamId,
    title,
    subtitle,
    position,
    backgroundColor,
    textColor,
  ];
}

class OverlayPresetInclude extends _i1.IncludeObject {
  OverlayPresetInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OverlayPreset.t;
}

class OverlayPresetIncludeList extends _i1.IncludeList {
  OverlayPresetIncludeList._({
    _i1.WhereExpressionBuilder<OverlayPresetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OverlayPreset.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OverlayPreset.t;
}

class OverlayPresetRepository {
  const OverlayPresetRepository._();

  /// Returns a list of [OverlayPreset]s matching the given query parameters.
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
  Future<List<OverlayPreset>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OverlayPresetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OverlayPresetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OverlayPresetTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OverlayPreset>(
      where: where?.call(OverlayPreset.t),
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OverlayPreset] matching the given query parameters.
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
  Future<OverlayPreset?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OverlayPresetTable>? where,
    int? offset,
    _i1.OrderByBuilder<OverlayPresetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OverlayPresetTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OverlayPreset>(
      where: where?.call(OverlayPreset.t),
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OverlayPreset] by its [id] or null if no such row exists.
  Future<OverlayPreset?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OverlayPreset>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OverlayPreset]s in the list and returns the inserted rows.
  ///
  /// The returned [OverlayPreset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OverlayPreset>> insert(
    _i1.DatabaseSession session,
    List<OverlayPreset> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OverlayPreset>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OverlayPreset] and returns the inserted row.
  ///
  /// The returned [OverlayPreset] will have its `id` field set.
  Future<OverlayPreset> insertRow(
    _i1.DatabaseSession session,
    OverlayPreset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OverlayPreset>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OverlayPreset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OverlayPreset>> update(
    _i1.DatabaseSession session,
    List<OverlayPreset> rows, {
    _i1.ColumnSelections<OverlayPresetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OverlayPreset>(
      rows,
      columns: columns?.call(OverlayPreset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OverlayPreset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OverlayPreset> updateRow(
    _i1.DatabaseSession session,
    OverlayPreset row, {
    _i1.ColumnSelections<OverlayPresetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OverlayPreset>(
      row,
      columns: columns?.call(OverlayPreset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OverlayPreset] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OverlayPreset?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OverlayPresetUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OverlayPreset>(
      id,
      columnValues: columnValues(OverlayPreset.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OverlayPreset]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OverlayPreset>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OverlayPresetUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OverlayPresetTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OverlayPresetTable>? orderBy,
    _i1.OrderByListBuilder<OverlayPresetTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OverlayPreset>(
      columnValues: columnValues(OverlayPreset.t.updateTable),
      where: where(OverlayPreset.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OverlayPreset]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OverlayPreset>> delete(
    _i1.DatabaseSession session,
    List<OverlayPreset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OverlayPreset>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OverlayPreset].
  Future<OverlayPreset> deleteRow(
    _i1.DatabaseSession session,
    OverlayPreset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OverlayPreset>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OverlayPreset>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OverlayPresetTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OverlayPreset>(
      where: where(OverlayPreset.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OverlayPresetTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OverlayPreset>(
      where: where?.call(OverlayPreset.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OverlayPreset] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OverlayPresetTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OverlayPreset>(
      where: where(OverlayPreset.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
