// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WorkspacesTable extends Workspaces
    with TableInfo<$WorkspacesTable, WorkspaceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkspacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, code, description, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workspaces';
  @override
  VerificationContext validateIntegrity(Insertable<WorkspaceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkspaceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkspaceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WorkspacesTable createAlias(String alias) {
    return $WorkspacesTable(attachedDatabase, alias);
  }
}

class WorkspaceData extends DataClass implements Insertable<WorkspaceData> {
  final String id;
  final String name;
  final String? code;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkspaceData(
      {required this.id,
      required this.name,
      this.code,
      this.description,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkspacesCompanion toCompanion(bool nullToAbsent) {
    return WorkspacesCompanion(
      id: Value(id),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkspaceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkspaceData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkspaceData copyWith(
          {String? id,
          String? name,
          Value<String?> code = const Value.absent(),
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WorkspaceData(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WorkspaceData copyWithCompanion(WorkspacesCompanion data) {
    return WorkspaceData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkspaceData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, code, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkspaceData &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkspacesCompanion extends UpdateCompanion<WorkspaceData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> code;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WorkspacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkspacesCompanion.insert({
    required String id,
    required String name,
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<WorkspaceData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkspacesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? code,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return WorkspacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkspacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, LocationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workspaceIdMeta =
      const VerificationMeta('workspaceId');
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
      'workspace_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workspaceId,
        name,
        code,
        description,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(Insertable<LocationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
          _workspaceIdMeta,
          workspaceId.isAcceptableOrUnknown(
              data['workspace_id']!, _workspaceIdMeta));
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workspaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workspace_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class LocationData extends DataClass implements Insertable<LocationData> {
  final String id;
  final String workspaceId;
  final String name;
  final String? code;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const LocationData(
      {required this.id,
      required this.workspaceId,
      required this.name,
      this.code,
      this.description,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory LocationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationData(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  LocationData copyWith(
          {String? id,
          String? workspaceId,
          String? name,
          Value<String?> code = const Value.absent(),
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      LocationData(
        id: id ?? this.id,
        workspaceId: workspaceId ?? this.workspaceId,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  LocationData copyWithCompanion(LocationsCompanion data) {
    return LocationData(
      id: data.id.present ? data.id.value : this.id,
      workspaceId:
          data.workspaceId.present ? data.workspaceId.value : this.workspaceId,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationData(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workspaceId, name, code, description,
      createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationData &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.name == this.name &&
          other.code == this.code &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class LocationsCompanion extends UpdateCompanion<LocationData> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> name;
  final Value<String?> code;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required String id,
    required String workspaceId,
    required String name,
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workspaceId = Value(workspaceId),
        name = Value(name);
  static Insertable<LocationData> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workspaceId,
      Value<String>? name,
      Value<String?>? code,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return LocationsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BinsTable extends Bins with TableInfo<$BinsTable, BinData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workspaceIdMeta =
      const VerificationMeta('workspaceId');
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
      'workspace_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workspaceId,
        locationId,
        code,
        description,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bins';
  @override
  VerificationContext validateIntegrity(Insertable<BinData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
          _workspaceIdMeta,
          workspaceId.isAcceptableOrUnknown(
              data['workspace_id']!, _workspaceIdMeta));
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BinData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BinData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workspaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workspace_id'])!,
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $BinsTable createAlias(String alias) {
    return $BinsTable(attachedDatabase, alias);
  }
}

class BinData extends DataClass implements Insertable<BinData> {
  final String id;
  final String workspaceId;
  final String locationId;
  final String code;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const BinData(
      {required this.id,
      required this.workspaceId,
      required this.locationId,
      required this.code,
      this.description,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['location_id'] = Variable<String>(locationId);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  BinsCompanion toCompanion(bool nullToAbsent) {
    return BinsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      locationId: Value(locationId),
      code: Value(code),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory BinData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BinData(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      code: serializer.fromJson<String>(json['code']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'locationId': serializer.toJson<String>(locationId),
      'code': serializer.toJson<String>(code),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  BinData copyWith(
          {String? id,
          String? workspaceId,
          String? locationId,
          String? code,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      BinData(
        id: id ?? this.id,
        workspaceId: workspaceId ?? this.workspaceId,
        locationId: locationId ?? this.locationId,
        code: code ?? this.code,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  BinData copyWithCompanion(BinsCompanion data) {
    return BinData(
      id: data.id.present ? data.id.value : this.id,
      workspaceId:
          data.workspaceId.present ? data.workspaceId.value : this.workspaceId,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      code: data.code.present ? data.code.value : this.code,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BinData(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('locationId: $locationId, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workspaceId, locationId, code,
      description, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BinData &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.locationId == this.locationId &&
          other.code == this.code &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class BinsCompanion extends UpdateCompanion<BinData> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> locationId;
  final Value<String> code;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const BinsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BinsCompanion.insert({
    required String id,
    required String workspaceId,
    required String locationId,
    required String code,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workspaceId = Value(workspaceId),
        locationId = Value(locationId),
        code = Value(code);
  static Insertable<BinData> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? locationId,
    Expression<String>? code,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (locationId != null) 'location_id': locationId,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BinsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workspaceId,
      Value<String>? locationId,
      Value<String>? code,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return BinsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      locationId: locationId ?? this.locationId,
      code: code ?? this.code,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BinsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('locationId: $locationId, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, ItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workspaceIdMeta =
      const VerificationMeta('workspaceId');
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
      'workspace_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('stored'));
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _binIdMeta = const VerificationMeta('binId');
  @override
  late final GeneratedColumn<String> binId = GeneratedColumn<String>(
      'bin_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _costMinorUnitsMeta =
      const VerificationMeta('costMinorUnits');
  @override
  late final GeneratedColumn<int> costMinorUnits = GeneratedColumn<int>(
      'cost_minor_units', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('USD'));
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
      'size', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _conditionMeta =
      const VerificationMeta('condition');
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
      'condition', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceDateMeta =
      const VerificationMeta('sourceDate');
  @override
  late final GeneratedColumn<DateTime> sourceDate = GeneratedColumn<DateTime>(
      'source_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _soldAtMeta = const VerificationMeta('soldAt');
  @override
  late final GeneratedColumn<DateTime> soldAt = GeneratedColumn<DateTime>(
      'sold_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _salePriceMinorUnitsMeta =
      const VerificationMeta('salePriceMinorUnits');
  @override
  late final GeneratedColumn<int> salePriceMinorUnits = GeneratedColumn<int>(
      'sale_price_minor_units', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _marketplaceOrderRefMeta =
      const VerificationMeta('marketplaceOrderRef');
  @override
  late final GeneratedColumn<String> marketplaceOrderRef =
      GeneratedColumn<String>('marketplace_order_ref', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _revisionMeta =
      const VerificationMeta('revision');
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
      'revision', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workspaceId,
        sku,
        title,
        description,
        status,
        locationId,
        binId,
        costMinorUnits,
        currency,
        brand,
        category,
        size,
        color,
        condition,
        source,
        sourceDate,
        soldAt,
        salePriceMinorUnits,
        marketplaceOrderRef,
        createdAt,
        updatedAt,
        deletedAt,
        revision
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(Insertable<ItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
          _workspaceIdMeta,
          workspaceId.isAcceptableOrUnknown(
              data['workspace_id']!, _workspaceIdMeta));
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    }
    if (data.containsKey('bin_id')) {
      context.handle(
          _binIdMeta, binId.isAcceptableOrUnknown(data['bin_id']!, _binIdMeta));
    }
    if (data.containsKey('cost_minor_units')) {
      context.handle(
          _costMinorUnitsMeta,
          costMinorUnits.isAcceptableOrUnknown(
              data['cost_minor_units']!, _costMinorUnitsMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('condition')) {
      context.handle(_conditionMeta,
          condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('source_date')) {
      context.handle(
          _sourceDateMeta,
          sourceDate.isAcceptableOrUnknown(
              data['source_date']!, _sourceDateMeta));
    }
    if (data.containsKey('sold_at')) {
      context.handle(_soldAtMeta,
          soldAt.isAcceptableOrUnknown(data['sold_at']!, _soldAtMeta));
    }
    if (data.containsKey('sale_price_minor_units')) {
      context.handle(
          _salePriceMinorUnitsMeta,
          salePriceMinorUnits.isAcceptableOrUnknown(
              data['sale_price_minor_units']!, _salePriceMinorUnitsMeta));
    }
    if (data.containsKey('marketplace_order_ref')) {
      context.handle(
          _marketplaceOrderRefMeta,
          marketplaceOrderRef.isAcceptableOrUnknown(
              data['marketplace_order_ref']!, _marketplaceOrderRefMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('revision')) {
      context.handle(_revisionMeta,
          revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workspaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workspace_id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id']),
      binId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bin_id']),
      costMinorUnits: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cost_minor_units']),
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}size']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      condition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}condition']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
      sourceDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}source_date']),
      soldAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sold_at']),
      salePriceMinorUnits: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}sale_price_minor_units']),
      marketplaceOrderRef: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}marketplace_order_ref']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      revision: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}revision'])!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class ItemData extends DataClass implements Insertable<ItemData> {
  final String id;
  final String workspaceId;
  final String sku;
  final String title;
  final String? description;
  final String status;
  final String? locationId;
  final String? binId;
  final int? costMinorUnits;
  final String currency;
  final String? brand;
  final String? category;
  final String? size;
  final String? color;
  final String? condition;
  final String? source;
  final DateTime? sourceDate;
  final DateTime? soldAt;
  final int? salePriceMinorUnits;
  final String? marketplaceOrderRef;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;
  const ItemData(
      {required this.id,
      required this.workspaceId,
      required this.sku,
      required this.title,
      this.description,
      required this.status,
      this.locationId,
      this.binId,
      this.costMinorUnits,
      required this.currency,
      this.brand,
      this.category,
      this.size,
      this.color,
      this.condition,
      this.source,
      this.sourceDate,
      this.soldAt,
      this.salePriceMinorUnits,
      this.marketplaceOrderRef,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.revision});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['sku'] = Variable<String>(sku);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || locationId != null) {
      map['location_id'] = Variable<String>(locationId);
    }
    if (!nullToAbsent || binId != null) {
      map['bin_id'] = Variable<String>(binId);
    }
    if (!nullToAbsent || costMinorUnits != null) {
      map['cost_minor_units'] = Variable<int>(costMinorUnits);
    }
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String>(condition);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || sourceDate != null) {
      map['source_date'] = Variable<DateTime>(sourceDate);
    }
    if (!nullToAbsent || soldAt != null) {
      map['sold_at'] = Variable<DateTime>(soldAt);
    }
    if (!nullToAbsent || salePriceMinorUnits != null) {
      map['sale_price_minor_units'] = Variable<int>(salePriceMinorUnits);
    }
    if (!nullToAbsent || marketplaceOrderRef != null) {
      map['marketplace_order_ref'] = Variable<String>(marketplaceOrderRef);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['revision'] = Variable<int>(revision);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      sku: Value(sku),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      locationId: locationId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationId),
      binId:
          binId == null && nullToAbsent ? const Value.absent() : Value(binId),
      costMinorUnits: costMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(costMinorUnits),
      currency: Value(currency),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      condition: condition == null && nullToAbsent
          ? const Value.absent()
          : Value(condition),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
      sourceDate: sourceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceDate),
      soldAt:
          soldAt == null && nullToAbsent ? const Value.absent() : Value(soldAt),
      salePriceMinorUnits: salePriceMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(salePriceMinorUnits),
      marketplaceOrderRef: marketplaceOrderRef == null && nullToAbsent
          ? const Value.absent()
          : Value(marketplaceOrderRef),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      revision: Value(revision),
    );
  }

  factory ItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemData(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      sku: serializer.fromJson<String>(json['sku']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      locationId: serializer.fromJson<String?>(json['locationId']),
      binId: serializer.fromJson<String?>(json['binId']),
      costMinorUnits: serializer.fromJson<int?>(json['costMinorUnits']),
      currency: serializer.fromJson<String>(json['currency']),
      brand: serializer.fromJson<String?>(json['brand']),
      category: serializer.fromJson<String?>(json['category']),
      size: serializer.fromJson<String?>(json['size']),
      color: serializer.fromJson<String?>(json['color']),
      condition: serializer.fromJson<String?>(json['condition']),
      source: serializer.fromJson<String?>(json['source']),
      sourceDate: serializer.fromJson<DateTime?>(json['sourceDate']),
      soldAt: serializer.fromJson<DateTime?>(json['soldAt']),
      salePriceMinorUnits:
          serializer.fromJson<int?>(json['salePriceMinorUnits']),
      marketplaceOrderRef:
          serializer.fromJson<String?>(json['marketplaceOrderRef']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      revision: serializer.fromJson<int>(json['revision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'sku': serializer.toJson<String>(sku),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
      'locationId': serializer.toJson<String?>(locationId),
      'binId': serializer.toJson<String?>(binId),
      'costMinorUnits': serializer.toJson<int?>(costMinorUnits),
      'currency': serializer.toJson<String>(currency),
      'brand': serializer.toJson<String?>(brand),
      'category': serializer.toJson<String?>(category),
      'size': serializer.toJson<String?>(size),
      'color': serializer.toJson<String?>(color),
      'condition': serializer.toJson<String?>(condition),
      'source': serializer.toJson<String?>(source),
      'sourceDate': serializer.toJson<DateTime?>(sourceDate),
      'soldAt': serializer.toJson<DateTime?>(soldAt),
      'salePriceMinorUnits': serializer.toJson<int?>(salePriceMinorUnits),
      'marketplaceOrderRef': serializer.toJson<String?>(marketplaceOrderRef),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'revision': serializer.toJson<int>(revision),
    };
  }

  ItemData copyWith(
          {String? id,
          String? workspaceId,
          String? sku,
          String? title,
          Value<String?> description = const Value.absent(),
          String? status,
          Value<String?> locationId = const Value.absent(),
          Value<String?> binId = const Value.absent(),
          Value<int?> costMinorUnits = const Value.absent(),
          String? currency,
          Value<String?> brand = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<String?> size = const Value.absent(),
          Value<String?> color = const Value.absent(),
          Value<String?> condition = const Value.absent(),
          Value<String?> source = const Value.absent(),
          Value<DateTime?> sourceDate = const Value.absent(),
          Value<DateTime?> soldAt = const Value.absent(),
          Value<int?> salePriceMinorUnits = const Value.absent(),
          Value<String?> marketplaceOrderRef = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          int? revision}) =>
      ItemData(
        id: id ?? this.id,
        workspaceId: workspaceId ?? this.workspaceId,
        sku: sku ?? this.sku,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        status: status ?? this.status,
        locationId: locationId.present ? locationId.value : this.locationId,
        binId: binId.present ? binId.value : this.binId,
        costMinorUnits:
            costMinorUnits.present ? costMinorUnits.value : this.costMinorUnits,
        currency: currency ?? this.currency,
        brand: brand.present ? brand.value : this.brand,
        category: category.present ? category.value : this.category,
        size: size.present ? size.value : this.size,
        color: color.present ? color.value : this.color,
        condition: condition.present ? condition.value : this.condition,
        source: source.present ? source.value : this.source,
        sourceDate: sourceDate.present ? sourceDate.value : this.sourceDate,
        soldAt: soldAt.present ? soldAt.value : this.soldAt,
        salePriceMinorUnits: salePriceMinorUnits.present
            ? salePriceMinorUnits.value
            : this.salePriceMinorUnits,
        marketplaceOrderRef: marketplaceOrderRef.present
            ? marketplaceOrderRef.value
            : this.marketplaceOrderRef,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        revision: revision ?? this.revision,
      );
  ItemData copyWithCompanion(ItemsCompanion data) {
    return ItemData(
      id: data.id.present ? data.id.value : this.id,
      workspaceId:
          data.workspaceId.present ? data.workspaceId.value : this.workspaceId,
      sku: data.sku.present ? data.sku.value : this.sku,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      binId: data.binId.present ? data.binId.value : this.binId,
      costMinorUnits: data.costMinorUnits.present
          ? data.costMinorUnits.value
          : this.costMinorUnits,
      currency: data.currency.present ? data.currency.value : this.currency,
      brand: data.brand.present ? data.brand.value : this.brand,
      category: data.category.present ? data.category.value : this.category,
      size: data.size.present ? data.size.value : this.size,
      color: data.color.present ? data.color.value : this.color,
      condition: data.condition.present ? data.condition.value : this.condition,
      source: data.source.present ? data.source.value : this.source,
      sourceDate:
          data.sourceDate.present ? data.sourceDate.value : this.sourceDate,
      soldAt: data.soldAt.present ? data.soldAt.value : this.soldAt,
      salePriceMinorUnits: data.salePriceMinorUnits.present
          ? data.salePriceMinorUnits.value
          : this.salePriceMinorUnits,
      marketplaceOrderRef: data.marketplaceOrderRef.present
          ? data.marketplaceOrderRef.value
          : this.marketplaceOrderRef,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      revision: data.revision.present ? data.revision.value : this.revision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemData(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('sku: $sku, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('locationId: $locationId, ')
          ..write('binId: $binId, ')
          ..write('costMinorUnits: $costMinorUnits, ')
          ..write('currency: $currency, ')
          ..write('brand: $brand, ')
          ..write('category: $category, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('condition: $condition, ')
          ..write('source: $source, ')
          ..write('sourceDate: $sourceDate, ')
          ..write('soldAt: $soldAt, ')
          ..write('salePriceMinorUnits: $salePriceMinorUnits, ')
          ..write('marketplaceOrderRef: $marketplaceOrderRef, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        workspaceId,
        sku,
        title,
        description,
        status,
        locationId,
        binId,
        costMinorUnits,
        currency,
        brand,
        category,
        size,
        color,
        condition,
        source,
        sourceDate,
        soldAt,
        salePriceMinorUnits,
        marketplaceOrderRef,
        createdAt,
        updatedAt,
        deletedAt,
        revision
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemData &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.sku == this.sku &&
          other.title == this.title &&
          other.description == this.description &&
          other.status == this.status &&
          other.locationId == this.locationId &&
          other.binId == this.binId &&
          other.costMinorUnits == this.costMinorUnits &&
          other.currency == this.currency &&
          other.brand == this.brand &&
          other.category == this.category &&
          other.size == this.size &&
          other.color == this.color &&
          other.condition == this.condition &&
          other.source == this.source &&
          other.sourceDate == this.sourceDate &&
          other.soldAt == this.soldAt &&
          other.salePriceMinorUnits == this.salePriceMinorUnits &&
          other.marketplaceOrderRef == this.marketplaceOrderRef &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.revision == this.revision);
}

class ItemsCompanion extends UpdateCompanion<ItemData> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> sku;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> status;
  final Value<String?> locationId;
  final Value<String?> binId;
  final Value<int?> costMinorUnits;
  final Value<String> currency;
  final Value<String?> brand;
  final Value<String?> category;
  final Value<String?> size;
  final Value<String?> color;
  final Value<String?> condition;
  final Value<String?> source;
  final Value<DateTime?> sourceDate;
  final Value<DateTime?> soldAt;
  final Value<int?> salePriceMinorUnits;
  final Value<String?> marketplaceOrderRef;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> revision;
  final Value<int> rowid;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.sku = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.locationId = const Value.absent(),
    this.binId = const Value.absent(),
    this.costMinorUnits = const Value.absent(),
    this.currency = const Value.absent(),
    this.brand = const Value.absent(),
    this.category = const Value.absent(),
    this.size = const Value.absent(),
    this.color = const Value.absent(),
    this.condition = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceDate = const Value.absent(),
    this.soldAt = const Value.absent(),
    this.salePriceMinorUnits = const Value.absent(),
    this.marketplaceOrderRef = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsCompanion.insert({
    required String id,
    required String workspaceId,
    required String sku,
    required String title,
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.locationId = const Value.absent(),
    this.binId = const Value.absent(),
    this.costMinorUnits = const Value.absent(),
    this.currency = const Value.absent(),
    this.brand = const Value.absent(),
    this.category = const Value.absent(),
    this.size = const Value.absent(),
    this.color = const Value.absent(),
    this.condition = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceDate = const Value.absent(),
    this.soldAt = const Value.absent(),
    this.salePriceMinorUnits = const Value.absent(),
    this.marketplaceOrderRef = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.revision = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workspaceId = Value(workspaceId),
        sku = Value(sku),
        title = Value(title);
  static Insertable<ItemData> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? sku,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? status,
    Expression<String>? locationId,
    Expression<String>? binId,
    Expression<int>? costMinorUnits,
    Expression<String>? currency,
    Expression<String>? brand,
    Expression<String>? category,
    Expression<String>? size,
    Expression<String>? color,
    Expression<String>? condition,
    Expression<String>? source,
    Expression<DateTime>? sourceDate,
    Expression<DateTime>? soldAt,
    Expression<int>? salePriceMinorUnits,
    Expression<String>? marketplaceOrderRef,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? revision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (sku != null) 'sku': sku,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (locationId != null) 'location_id': locationId,
      if (binId != null) 'bin_id': binId,
      if (costMinorUnits != null) 'cost_minor_units': costMinorUnits,
      if (currency != null) 'currency': currency,
      if (brand != null) 'brand': brand,
      if (category != null) 'category': category,
      if (size != null) 'size': size,
      if (color != null) 'color': color,
      if (condition != null) 'condition': condition,
      if (source != null) 'source': source,
      if (sourceDate != null) 'source_date': sourceDate,
      if (soldAt != null) 'sold_at': soldAt,
      if (salePriceMinorUnits != null)
        'sale_price_minor_units': salePriceMinorUnits,
      if (marketplaceOrderRef != null)
        'marketplace_order_ref': marketplaceOrderRef,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (revision != null) 'revision': revision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workspaceId,
      Value<String>? sku,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? status,
      Value<String?>? locationId,
      Value<String?>? binId,
      Value<int?>? costMinorUnits,
      Value<String>? currency,
      Value<String?>? brand,
      Value<String?>? category,
      Value<String?>? size,
      Value<String?>? color,
      Value<String?>? condition,
      Value<String?>? source,
      Value<DateTime?>? sourceDate,
      Value<DateTime?>? soldAt,
      Value<int?>? salePriceMinorUnits,
      Value<String?>? marketplaceOrderRef,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? revision,
      Value<int>? rowid}) {
    return ItemsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      sku: sku ?? this.sku,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      locationId: locationId ?? this.locationId,
      binId: binId ?? this.binId,
      costMinorUnits: costMinorUnits ?? this.costMinorUnits,
      currency: currency ?? this.currency,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      size: size ?? this.size,
      color: color ?? this.color,
      condition: condition ?? this.condition,
      source: source ?? this.source,
      sourceDate: sourceDate ?? this.sourceDate,
      soldAt: soldAt ?? this.soldAt,
      salePriceMinorUnits: salePriceMinorUnits ?? this.salePriceMinorUnits,
      marketplaceOrderRef: marketplaceOrderRef ?? this.marketplaceOrderRef,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (binId.present) {
      map['bin_id'] = Variable<String>(binId.value);
    }
    if (costMinorUnits.present) {
      map['cost_minor_units'] = Variable<int>(costMinorUnits.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (sourceDate.present) {
      map['source_date'] = Variable<DateTime>(sourceDate.value);
    }
    if (soldAt.present) {
      map['sold_at'] = Variable<DateTime>(soldAt.value);
    }
    if (salePriceMinorUnits.present) {
      map['sale_price_minor_units'] = Variable<int>(salePriceMinorUnits.value);
    }
    if (marketplaceOrderRef.present) {
      map['marketplace_order_ref'] =
          Variable<String>(marketplaceOrderRef.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('sku: $sku, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('locationId: $locationId, ')
          ..write('binId: $binId, ')
          ..write('costMinorUnits: $costMinorUnits, ')
          ..write('currency: $currency, ')
          ..write('brand: $brand, ')
          ..write('category: $category, ')
          ..write('size: $size, ')
          ..write('color: $color, ')
          ..write('condition: $condition, ')
          ..write('source: $source, ')
          ..write('sourceDate: $sourceDate, ')
          ..write('soldAt: $soldAt, ')
          ..write('salePriceMinorUnits: $salePriceMinorUnits, ')
          ..write('marketplaceOrderRef: $marketplaceOrderRef, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('revision: $revision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemPhotosTable extends ItemPhotos
    with TableInfo<$ItemPhotosTable, ItemPhotoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _remoteUrlMeta =
      const VerificationMeta('remoteUrl');
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
      'remote_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _uploadStatusMeta =
      const VerificationMeta('uploadStatus');
  @override
  late final GeneratedColumn<String> uploadStatus = GeneratedColumn<String>(
      'upload_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, itemId, localPath, remoteUrl, position, uploadStatus, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_photos';
  @override
  VerificationContext validateIntegrity(Insertable<ItemPhotoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    }
    if (data.containsKey('remote_url')) {
      context.handle(_remoteUrlMeta,
          remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    }
    if (data.containsKey('upload_status')) {
      context.handle(
          _uploadStatusMeta,
          uploadStatus.isAcceptableOrUnknown(
              data['upload_status']!, _uploadStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemPhotoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemPhotoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path']),
      remoteUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_url']),
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      uploadStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}upload_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ItemPhotosTable createAlias(String alias) {
    return $ItemPhotosTable(attachedDatabase, alias);
  }
}

class ItemPhotoData extends DataClass implements Insertable<ItemPhotoData> {
  final String id;
  final String itemId;
  final String? localPath;
  final String? remoteUrl;
  final int position;
  final String uploadStatus;
  final DateTime createdAt;
  const ItemPhotoData(
      {required this.id,
      required this.itemId,
      this.localPath,
      this.remoteUrl,
      required this.position,
      required this.uploadStatus,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_id'] = Variable<String>(itemId);
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    map['position'] = Variable<int>(position);
    map['upload_status'] = Variable<String>(uploadStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ItemPhotosCompanion toCompanion(bool nullToAbsent) {
    return ItemPhotosCompanion(
      id: Value(id),
      itemId: Value(itemId),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      remoteUrl: remoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUrl),
      position: Value(position),
      uploadStatus: Value(uploadStatus),
      createdAt: Value(createdAt),
    );
  }

  factory ItemPhotoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemPhotoData(
      id: serializer.fromJson<String>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      position: serializer.fromJson<int>(json['position']),
      uploadStatus: serializer.fromJson<String>(json['uploadStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemId': serializer.toJson<String>(itemId),
      'localPath': serializer.toJson<String?>(localPath),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'position': serializer.toJson<int>(position),
      'uploadStatus': serializer.toJson<String>(uploadStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ItemPhotoData copyWith(
          {String? id,
          String? itemId,
          Value<String?> localPath = const Value.absent(),
          Value<String?> remoteUrl = const Value.absent(),
          int? position,
          String? uploadStatus,
          DateTime? createdAt}) =>
      ItemPhotoData(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        localPath: localPath.present ? localPath.value : this.localPath,
        remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
        position: position ?? this.position,
        uploadStatus: uploadStatus ?? this.uploadStatus,
        createdAt: createdAt ?? this.createdAt,
      );
  ItemPhotoData copyWithCompanion(ItemPhotosCompanion data) {
    return ItemPhotoData(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      position: data.position.present ? data.position.value : this.position,
      uploadStatus: data.uploadStatus.present
          ? data.uploadStatus.value
          : this.uploadStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemPhotoData(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('position: $position, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, itemId, localPath, remoteUrl, position, uploadStatus, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemPhotoData &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.localPath == this.localPath &&
          other.remoteUrl == this.remoteUrl &&
          other.position == this.position &&
          other.uploadStatus == this.uploadStatus &&
          other.createdAt == this.createdAt);
}

class ItemPhotosCompanion extends UpdateCompanion<ItemPhotoData> {
  final Value<String> id;
  final Value<String> itemId;
  final Value<String?> localPath;
  final Value<String?> remoteUrl;
  final Value<int> position;
  final Value<String> uploadStatus;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ItemPhotosCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.position = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemPhotosCompanion.insert({
    required String id,
    required String itemId,
    this.localPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.position = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        itemId = Value(itemId);
  static Insertable<ItemPhotoData> custom({
    Expression<String>? id,
    Expression<String>? itemId,
    Expression<String>? localPath,
    Expression<String>? remoteUrl,
    Expression<int>? position,
    Expression<String>? uploadStatus,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (localPath != null) 'local_path': localPath,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (position != null) 'position': position,
      if (uploadStatus != null) 'upload_status': uploadStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemPhotosCompanion copyWith(
      {Value<String>? id,
      Value<String>? itemId,
      Value<String?>? localPath,
      Value<String?>? remoteUrl,
      Value<int>? position,
      Value<String>? uploadStatus,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ItemPhotosCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      position: position ?? this.position,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (uploadStatus.present) {
      map['upload_status'] = Variable<String>(uploadStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemPhotosCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('position: $position, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryEventsTable extends InventoryEvents
    with TableInfo<$InventoryEventsTable, InventoryEventData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workspaceIdMeta =
      const VerificationMeta('workspaceId');
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
      'workspace_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fromLocationIdMeta =
      const VerificationMeta('fromLocationId');
  @override
  late final GeneratedColumn<String> fromLocationId = GeneratedColumn<String>(
      'from_location_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fromBinIdMeta =
      const VerificationMeta('fromBinId');
  @override
  late final GeneratedColumn<String> fromBinId = GeneratedColumn<String>(
      'from_bin_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _toLocationIdMeta =
      const VerificationMeta('toLocationId');
  @override
  late final GeneratedColumn<String> toLocationId = GeneratedColumn<String>(
      'to_location_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _toBinIdMeta =
      const VerificationMeta('toBinId');
  @override
  late final GeneratedColumn<String> toBinId = GeneratedColumn<String>(
      'to_bin_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _occurredAtMeta =
      const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
      'occurred_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workspaceId,
        itemId,
        type,
        fromLocationId,
        fromBinId,
        toLocationId,
        toBinId,
        note,
        occurredAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_events';
  @override
  VerificationContext validateIntegrity(Insertable<InventoryEventData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
          _workspaceIdMeta,
          workspaceId.isAcceptableOrUnknown(
              data['workspace_id']!, _workspaceIdMeta));
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('from_location_id')) {
      context.handle(
          _fromLocationIdMeta,
          fromLocationId.isAcceptableOrUnknown(
              data['from_location_id']!, _fromLocationIdMeta));
    }
    if (data.containsKey('from_bin_id')) {
      context.handle(
          _fromBinIdMeta,
          fromBinId.isAcceptableOrUnknown(
              data['from_bin_id']!, _fromBinIdMeta));
    }
    if (data.containsKey('to_location_id')) {
      context.handle(
          _toLocationIdMeta,
          toLocationId.isAcceptableOrUnknown(
              data['to_location_id']!, _toLocationIdMeta));
    }
    if (data.containsKey('to_bin_id')) {
      context.handle(_toBinIdMeta,
          toBinId.isAcceptableOrUnknown(data['to_bin_id']!, _toBinIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
          _occurredAtMeta,
          occurredAt.isAcceptableOrUnknown(
              data['occurred_at']!, _occurredAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryEventData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryEventData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workspaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workspace_id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      fromLocationId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}from_location_id']),
      fromBinId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_bin_id']),
      toLocationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_location_id']),
      toBinId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_bin_id']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      occurredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $InventoryEventsTable createAlias(String alias) {
    return $InventoryEventsTable(attachedDatabase, alias);
  }
}

class InventoryEventData extends DataClass
    implements Insertable<InventoryEventData> {
  final String id;
  final String workspaceId;
  final String itemId;
  final String type;
  final String? fromLocationId;
  final String? fromBinId;
  final String? toLocationId;
  final String? toBinId;
  final String? note;
  final DateTime occurredAt;
  final bool synced;
  const InventoryEventData(
      {required this.id,
      required this.workspaceId,
      required this.itemId,
      required this.type,
      this.fromLocationId,
      this.fromBinId,
      this.toLocationId,
      this.toBinId,
      this.note,
      required this.occurredAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['item_id'] = Variable<String>(itemId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || fromLocationId != null) {
      map['from_location_id'] = Variable<String>(fromLocationId);
    }
    if (!nullToAbsent || fromBinId != null) {
      map['from_bin_id'] = Variable<String>(fromBinId);
    }
    if (!nullToAbsent || toLocationId != null) {
      map['to_location_id'] = Variable<String>(toLocationId);
    }
    if (!nullToAbsent || toBinId != null) {
      map['to_bin_id'] = Variable<String>(toBinId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  InventoryEventsCompanion toCompanion(bool nullToAbsent) {
    return InventoryEventsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      itemId: Value(itemId),
      type: Value(type),
      fromLocationId: fromLocationId == null && nullToAbsent
          ? const Value.absent()
          : Value(fromLocationId),
      fromBinId: fromBinId == null && nullToAbsent
          ? const Value.absent()
          : Value(fromBinId),
      toLocationId: toLocationId == null && nullToAbsent
          ? const Value.absent()
          : Value(toLocationId),
      toBinId: toBinId == null && nullToAbsent
          ? const Value.absent()
          : Value(toBinId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      occurredAt: Value(occurredAt),
      synced: Value(synced),
    );
  }

  factory InventoryEventData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryEventData(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      itemId: serializer.fromJson<String>(json['itemId']),
      type: serializer.fromJson<String>(json['type']),
      fromLocationId: serializer.fromJson<String?>(json['fromLocationId']),
      fromBinId: serializer.fromJson<String?>(json['fromBinId']),
      toLocationId: serializer.fromJson<String?>(json['toLocationId']),
      toBinId: serializer.fromJson<String?>(json['toBinId']),
      note: serializer.fromJson<String?>(json['note']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'itemId': serializer.toJson<String>(itemId),
      'type': serializer.toJson<String>(type),
      'fromLocationId': serializer.toJson<String?>(fromLocationId),
      'fromBinId': serializer.toJson<String?>(fromBinId),
      'toLocationId': serializer.toJson<String?>(toLocationId),
      'toBinId': serializer.toJson<String?>(toBinId),
      'note': serializer.toJson<String?>(note),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  InventoryEventData copyWith(
          {String? id,
          String? workspaceId,
          String? itemId,
          String? type,
          Value<String?> fromLocationId = const Value.absent(),
          Value<String?> fromBinId = const Value.absent(),
          Value<String?> toLocationId = const Value.absent(),
          Value<String?> toBinId = const Value.absent(),
          Value<String?> note = const Value.absent(),
          DateTime? occurredAt,
          bool? synced}) =>
      InventoryEventData(
        id: id ?? this.id,
        workspaceId: workspaceId ?? this.workspaceId,
        itemId: itemId ?? this.itemId,
        type: type ?? this.type,
        fromLocationId:
            fromLocationId.present ? fromLocationId.value : this.fromLocationId,
        fromBinId: fromBinId.present ? fromBinId.value : this.fromBinId,
        toLocationId:
            toLocationId.present ? toLocationId.value : this.toLocationId,
        toBinId: toBinId.present ? toBinId.value : this.toBinId,
        note: note.present ? note.value : this.note,
        occurredAt: occurredAt ?? this.occurredAt,
        synced: synced ?? this.synced,
      );
  InventoryEventData copyWithCompanion(InventoryEventsCompanion data) {
    return InventoryEventData(
      id: data.id.present ? data.id.value : this.id,
      workspaceId:
          data.workspaceId.present ? data.workspaceId.value : this.workspaceId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      type: data.type.present ? data.type.value : this.type,
      fromLocationId: data.fromLocationId.present
          ? data.fromLocationId.value
          : this.fromLocationId,
      fromBinId: data.fromBinId.present ? data.fromBinId.value : this.fromBinId,
      toLocationId: data.toLocationId.present
          ? data.toLocationId.value
          : this.toLocationId,
      toBinId: data.toBinId.present ? data.toBinId.value : this.toBinId,
      note: data.note.present ? data.note.value : this.note,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryEventData(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('itemId: $itemId, ')
          ..write('type: $type, ')
          ..write('fromLocationId: $fromLocationId, ')
          ..write('fromBinId: $fromBinId, ')
          ..write('toLocationId: $toLocationId, ')
          ..write('toBinId: $toBinId, ')
          ..write('note: $note, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workspaceId, itemId, type, fromLocationId,
      fromBinId, toLocationId, toBinId, note, occurredAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryEventData &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.itemId == this.itemId &&
          other.type == this.type &&
          other.fromLocationId == this.fromLocationId &&
          other.fromBinId == this.fromBinId &&
          other.toLocationId == this.toLocationId &&
          other.toBinId == this.toBinId &&
          other.note == this.note &&
          other.occurredAt == this.occurredAt &&
          other.synced == this.synced);
}

class InventoryEventsCompanion extends UpdateCompanion<InventoryEventData> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> itemId;
  final Value<String> type;
  final Value<String?> fromLocationId;
  final Value<String?> fromBinId;
  final Value<String?> toLocationId;
  final Value<String?> toBinId;
  final Value<String?> note;
  final Value<DateTime> occurredAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const InventoryEventsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.type = const Value.absent(),
    this.fromLocationId = const Value.absent(),
    this.fromBinId = const Value.absent(),
    this.toLocationId = const Value.absent(),
    this.toBinId = const Value.absent(),
    this.note = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryEventsCompanion.insert({
    required String id,
    required String workspaceId,
    required String itemId,
    required String type,
    this.fromLocationId = const Value.absent(),
    this.fromBinId = const Value.absent(),
    this.toLocationId = const Value.absent(),
    this.toBinId = const Value.absent(),
    this.note = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workspaceId = Value(workspaceId),
        itemId = Value(itemId),
        type = Value(type);
  static Insertable<InventoryEventData> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? itemId,
    Expression<String>? type,
    Expression<String>? fromLocationId,
    Expression<String>? fromBinId,
    Expression<String>? toLocationId,
    Expression<String>? toBinId,
    Expression<String>? note,
    Expression<DateTime>? occurredAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (itemId != null) 'item_id': itemId,
      if (type != null) 'type': type,
      if (fromLocationId != null) 'from_location_id': fromLocationId,
      if (fromBinId != null) 'from_bin_id': fromBinId,
      if (toLocationId != null) 'to_location_id': toLocationId,
      if (toBinId != null) 'to_bin_id': toBinId,
      if (note != null) 'note': note,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workspaceId,
      Value<String>? itemId,
      Value<String>? type,
      Value<String?>? fromLocationId,
      Value<String?>? fromBinId,
      Value<String?>? toLocationId,
      Value<String?>? toBinId,
      Value<String?>? note,
      Value<DateTime>? occurredAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return InventoryEventsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      itemId: itemId ?? this.itemId,
      type: type ?? this.type,
      fromLocationId: fromLocationId ?? this.fromLocationId,
      fromBinId: fromBinId ?? this.fromBinId,
      toLocationId: toLocationId ?? this.toLocationId,
      toBinId: toBinId ?? this.toBinId,
      note: note ?? this.note,
      occurredAt: occurredAt ?? this.occurredAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (fromLocationId.present) {
      map['from_location_id'] = Variable<String>(fromLocationId.value);
    }
    if (fromBinId.present) {
      map['from_bin_id'] = Variable<String>(fromBinId.value);
    }
    if (toLocationId.present) {
      map['to_location_id'] = Variable<String>(toLocationId.value);
    }
    if (toBinId.present) {
      map['to_bin_id'] = Variable<String>(toBinId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryEventsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('itemId: $itemId, ')
          ..write('type: $type, ')
          ..write('fromLocationId: $fromLocationId, ')
          ..write('fromBinId: $fromBinId, ')
          ..write('toLocationId: $toLocationId, ')
          ..write('toBinId: $toBinId, ')
          ..write('note: $note, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MarketplaceReferencesTable extends MarketplaceReferences
    with TableInfo<$MarketplaceReferencesTable, MarketplaceReferenceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MarketplaceReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _platformMeta =
      const VerificationMeta('platform');
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
      'platform', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _externalIdMeta =
      const VerificationMeta('externalId');
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
      'external_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _listingUrlMeta =
      const VerificationMeta('listingUrl');
  @override
  late final GeneratedColumn<String> listingUrl = GeneratedColumn<String>(
      'listing_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _listedAtMeta =
      const VerificationMeta('listedAt');
  @override
  late final GeneratedColumn<DateTime> listedAt = GeneratedColumn<DateTime>(
      'listed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _soldAtMeta = const VerificationMeta('soldAt');
  @override
  late final GeneratedColumn<DateTime> soldAt = GeneratedColumn<DateTime>(
      'sold_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _priceMinorUnitsMeta =
      const VerificationMeta('priceMinorUnits');
  @override
  late final GeneratedColumn<int> priceMinorUnits = GeneratedColumn<int>(
      'price_minor_units', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('USD'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        itemId,
        platform,
        externalId,
        listingUrl,
        status,
        listedAt,
        soldAt,
        priceMinorUnits,
        currency
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'marketplace_references';
  @override
  VerificationContext validateIntegrity(
      Insertable<MarketplaceReferenceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(_platformMeta,
          platform.isAcceptableOrUnknown(data['platform']!, _platformMeta));
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('external_id')) {
      context.handle(
          _externalIdMeta,
          externalId.isAcceptableOrUnknown(
              data['external_id']!, _externalIdMeta));
    } else if (isInserting) {
      context.missing(_externalIdMeta);
    }
    if (data.containsKey('listing_url')) {
      context.handle(
          _listingUrlMeta,
          listingUrl.isAcceptableOrUnknown(
              data['listing_url']!, _listingUrlMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('listed_at')) {
      context.handle(_listedAtMeta,
          listedAt.isAcceptableOrUnknown(data['listed_at']!, _listedAtMeta));
    }
    if (data.containsKey('sold_at')) {
      context.handle(_soldAtMeta,
          soldAt.isAcceptableOrUnknown(data['sold_at']!, _soldAtMeta));
    }
    if (data.containsKey('price_minor_units')) {
      context.handle(
          _priceMinorUnitsMeta,
          priceMinorUnits.isAcceptableOrUnknown(
              data['price_minor_units']!, _priceMinorUnitsMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MarketplaceReferenceData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MarketplaceReferenceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      platform: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platform'])!,
      externalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}external_id'])!,
      listingUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}listing_url']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      listedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}listed_at']),
      soldAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sold_at']),
      priceMinorUnits: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price_minor_units']),
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
    );
  }

  @override
  $MarketplaceReferencesTable createAlias(String alias) {
    return $MarketplaceReferencesTable(attachedDatabase, alias);
  }
}

class MarketplaceReferenceData extends DataClass
    implements Insertable<MarketplaceReferenceData> {
  final String id;
  final String itemId;
  final String platform;
  final String externalId;
  final String? listingUrl;
  final String? status;
  final DateTime? listedAt;
  final DateTime? soldAt;
  final int? priceMinorUnits;
  final String currency;
  const MarketplaceReferenceData(
      {required this.id,
      required this.itemId,
      required this.platform,
      required this.externalId,
      this.listingUrl,
      this.status,
      this.listedAt,
      this.soldAt,
      this.priceMinorUnits,
      required this.currency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_id'] = Variable<String>(itemId);
    map['platform'] = Variable<String>(platform);
    map['external_id'] = Variable<String>(externalId);
    if (!nullToAbsent || listingUrl != null) {
      map['listing_url'] = Variable<String>(listingUrl);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || listedAt != null) {
      map['listed_at'] = Variable<DateTime>(listedAt);
    }
    if (!nullToAbsent || soldAt != null) {
      map['sold_at'] = Variable<DateTime>(soldAt);
    }
    if (!nullToAbsent || priceMinorUnits != null) {
      map['price_minor_units'] = Variable<int>(priceMinorUnits);
    }
    map['currency'] = Variable<String>(currency);
    return map;
  }

  MarketplaceReferencesCompanion toCompanion(bool nullToAbsent) {
    return MarketplaceReferencesCompanion(
      id: Value(id),
      itemId: Value(itemId),
      platform: Value(platform),
      externalId: Value(externalId),
      listingUrl: listingUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(listingUrl),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      listedAt: listedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(listedAt),
      soldAt:
          soldAt == null && nullToAbsent ? const Value.absent() : Value(soldAt),
      priceMinorUnits: priceMinorUnits == null && nullToAbsent
          ? const Value.absent()
          : Value(priceMinorUnits),
      currency: Value(currency),
    );
  }

  factory MarketplaceReferenceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MarketplaceReferenceData(
      id: serializer.fromJson<String>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      platform: serializer.fromJson<String>(json['platform']),
      externalId: serializer.fromJson<String>(json['externalId']),
      listingUrl: serializer.fromJson<String?>(json['listingUrl']),
      status: serializer.fromJson<String?>(json['status']),
      listedAt: serializer.fromJson<DateTime?>(json['listedAt']),
      soldAt: serializer.fromJson<DateTime?>(json['soldAt']),
      priceMinorUnits: serializer.fromJson<int?>(json['priceMinorUnits']),
      currency: serializer.fromJson<String>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemId': serializer.toJson<String>(itemId),
      'platform': serializer.toJson<String>(platform),
      'externalId': serializer.toJson<String>(externalId),
      'listingUrl': serializer.toJson<String?>(listingUrl),
      'status': serializer.toJson<String?>(status),
      'listedAt': serializer.toJson<DateTime?>(listedAt),
      'soldAt': serializer.toJson<DateTime?>(soldAt),
      'priceMinorUnits': serializer.toJson<int?>(priceMinorUnits),
      'currency': serializer.toJson<String>(currency),
    };
  }

  MarketplaceReferenceData copyWith(
          {String? id,
          String? itemId,
          String? platform,
          String? externalId,
          Value<String?> listingUrl = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<DateTime?> listedAt = const Value.absent(),
          Value<DateTime?> soldAt = const Value.absent(),
          Value<int?> priceMinorUnits = const Value.absent(),
          String? currency}) =>
      MarketplaceReferenceData(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        platform: platform ?? this.platform,
        externalId: externalId ?? this.externalId,
        listingUrl: listingUrl.present ? listingUrl.value : this.listingUrl,
        status: status.present ? status.value : this.status,
        listedAt: listedAt.present ? listedAt.value : this.listedAt,
        soldAt: soldAt.present ? soldAt.value : this.soldAt,
        priceMinorUnits: priceMinorUnits.present
            ? priceMinorUnits.value
            : this.priceMinorUnits,
        currency: currency ?? this.currency,
      );
  MarketplaceReferenceData copyWithCompanion(
      MarketplaceReferencesCompanion data) {
    return MarketplaceReferenceData(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      platform: data.platform.present ? data.platform.value : this.platform,
      externalId:
          data.externalId.present ? data.externalId.value : this.externalId,
      listingUrl:
          data.listingUrl.present ? data.listingUrl.value : this.listingUrl,
      status: data.status.present ? data.status.value : this.status,
      listedAt: data.listedAt.present ? data.listedAt.value : this.listedAt,
      soldAt: data.soldAt.present ? data.soldAt.value : this.soldAt,
      priceMinorUnits: data.priceMinorUnits.present
          ? data.priceMinorUnits.value
          : this.priceMinorUnits,
      currency: data.currency.present ? data.currency.value : this.currency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MarketplaceReferenceData(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('platform: $platform, ')
          ..write('externalId: $externalId, ')
          ..write('listingUrl: $listingUrl, ')
          ..write('status: $status, ')
          ..write('listedAt: $listedAt, ')
          ..write('soldAt: $soldAt, ')
          ..write('priceMinorUnits: $priceMinorUnits, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemId, platform, externalId, listingUrl,
      status, listedAt, soldAt, priceMinorUnits, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MarketplaceReferenceData &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.platform == this.platform &&
          other.externalId == this.externalId &&
          other.listingUrl == this.listingUrl &&
          other.status == this.status &&
          other.listedAt == this.listedAt &&
          other.soldAt == this.soldAt &&
          other.priceMinorUnits == this.priceMinorUnits &&
          other.currency == this.currency);
}

class MarketplaceReferencesCompanion
    extends UpdateCompanion<MarketplaceReferenceData> {
  final Value<String> id;
  final Value<String> itemId;
  final Value<String> platform;
  final Value<String> externalId;
  final Value<String?> listingUrl;
  final Value<String?> status;
  final Value<DateTime?> listedAt;
  final Value<DateTime?> soldAt;
  final Value<int?> priceMinorUnits;
  final Value<String> currency;
  final Value<int> rowid;
  const MarketplaceReferencesCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.platform = const Value.absent(),
    this.externalId = const Value.absent(),
    this.listingUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.listedAt = const Value.absent(),
    this.soldAt = const Value.absent(),
    this.priceMinorUnits = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MarketplaceReferencesCompanion.insert({
    required String id,
    required String itemId,
    required String platform,
    required String externalId,
    this.listingUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.listedAt = const Value.absent(),
    this.soldAt = const Value.absent(),
    this.priceMinorUnits = const Value.absent(),
    this.currency = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        itemId = Value(itemId),
        platform = Value(platform),
        externalId = Value(externalId);
  static Insertable<MarketplaceReferenceData> custom({
    Expression<String>? id,
    Expression<String>? itemId,
    Expression<String>? platform,
    Expression<String>? externalId,
    Expression<String>? listingUrl,
    Expression<String>? status,
    Expression<DateTime>? listedAt,
    Expression<DateTime>? soldAt,
    Expression<int>? priceMinorUnits,
    Expression<String>? currency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (platform != null) 'platform': platform,
      if (externalId != null) 'external_id': externalId,
      if (listingUrl != null) 'listing_url': listingUrl,
      if (status != null) 'status': status,
      if (listedAt != null) 'listed_at': listedAt,
      if (soldAt != null) 'sold_at': soldAt,
      if (priceMinorUnits != null) 'price_minor_units': priceMinorUnits,
      if (currency != null) 'currency': currency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MarketplaceReferencesCompanion copyWith(
      {Value<String>? id,
      Value<String>? itemId,
      Value<String>? platform,
      Value<String>? externalId,
      Value<String?>? listingUrl,
      Value<String?>? status,
      Value<DateTime?>? listedAt,
      Value<DateTime?>? soldAt,
      Value<int?>? priceMinorUnits,
      Value<String>? currency,
      Value<int>? rowid}) {
    return MarketplaceReferencesCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      platform: platform ?? this.platform,
      externalId: externalId ?? this.externalId,
      listingUrl: listingUrl ?? this.listingUrl,
      status: status ?? this.status,
      listedAt: listedAt ?? this.listedAt,
      soldAt: soldAt ?? this.soldAt,
      priceMinorUnits: priceMinorUnits ?? this.priceMinorUnits,
      currency: currency ?? this.currency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (listingUrl.present) {
      map['listing_url'] = Variable<String>(listingUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (listedAt.present) {
      map['listed_at'] = Variable<DateTime>(listedAt.value);
    }
    if (soldAt.present) {
      map['sold_at'] = Variable<DateTime>(soldAt.value);
    }
    if (priceMinorUnits.present) {
      map['price_minor_units'] = Variable<int>(priceMinorUnits.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MarketplaceReferencesCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('platform: $platform, ')
          ..write('externalId: $externalId, ')
          ..write('listingUrl: $listingUrl, ')
          ..write('status: $status, ')
          ..write('listedAt: $listedAt, ')
          ..write('soldAt: $soldAt, ')
          ..write('priceMinorUnits: $priceMinorUnits, ')
          ..write('currency: $currency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOperationsTable extends SyncOperations
    with TableInfo<$SyncOperationsTable, SyncOperationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOperationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workspaceIdMeta =
      const VerificationMeta('workspaceId');
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
      'workspace_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationTypeMeta =
      const VerificationMeta('operationType');
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
      'operation_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workspaceId,
        entityType,
        entityId,
        operationType,
        payload,
        status,
        retryCount,
        createdAt,
        syncedAt,
        errorMessage
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_operations';
  @override
  VerificationContext validateIntegrity(Insertable<SyncOperationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
          _workspaceIdMeta,
          workspaceId.isAcceptableOrUnknown(
              data['workspace_id']!, _workspaceIdMeta));
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation_type')) {
      context.handle(
          _operationTypeMeta,
          operationType.isAcceptableOrUnknown(
              data['operation_type']!, _operationTypeMeta));
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncOperationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncOperationData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workspaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workspace_id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      operationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation_type'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
    );
  }

  @override
  $SyncOperationsTable createAlias(String alias) {
    return $SyncOperationsTable(attachedDatabase, alias);
  }
}

class SyncOperationData extends DataClass
    implements Insertable<SyncOperationData> {
  final String id;
  final String workspaceId;
  final String entityType;
  final String entityId;
  final String operationType;
  final String payload;
  final String status;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? syncedAt;
  final String? errorMessage;
  const SyncOperationData(
      {required this.id,
      required this.workspaceId,
      required this.entityType,
      required this.entityId,
      required this.operationType,
      required this.payload,
      required this.status,
      required this.retryCount,
      required this.createdAt,
      this.syncedAt,
      this.errorMessage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation_type'] = Variable<String>(operationType);
    map['payload'] = Variable<String>(payload);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  SyncOperationsCompanion toCompanion(bool nullToAbsent) {
    return SyncOperationsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operationType: Value(operationType),
      payload: Value(payload),
      status: Value(status),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory SyncOperationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncOperationData(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operationType: serializer.fromJson<String>(json['operationType']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operationType': serializer.toJson<String>(operationType),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  SyncOperationData copyWith(
          {String? id,
          String? workspaceId,
          String? entityType,
          String? entityId,
          String? operationType,
          String? payload,
          String? status,
          int? retryCount,
          DateTime? createdAt,
          Value<DateTime?> syncedAt = const Value.absent(),
          Value<String?> errorMessage = const Value.absent()}) =>
      SyncOperationData(
        id: id ?? this.id,
        workspaceId: workspaceId ?? this.workspaceId,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operationType: operationType ?? this.operationType,
        payload: payload ?? this.payload,
        status: status ?? this.status,
        retryCount: retryCount ?? this.retryCount,
        createdAt: createdAt ?? this.createdAt,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
      );
  SyncOperationData copyWithCompanion(SyncOperationsCompanion data) {
    return SyncOperationData(
      id: data.id.present ? data.id.value : this.id,
      workspaceId:
          data.workspaceId.present ? data.workspaceId.value : this.workspaceId,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncOperationData(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operationType: $operationType, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      workspaceId,
      entityType,
      entityId,
      operationType,
      payload,
      status,
      retryCount,
      createdAt,
      syncedAt,
      errorMessage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncOperationData &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operationType == this.operationType &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.syncedAt == this.syncedAt &&
          other.errorMessage == this.errorMessage);
}

class SyncOperationsCompanion extends UpdateCompanion<SyncOperationData> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operationType;
  final Value<String> payload;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> syncedAt;
  final Value<String?> errorMessage;
  final Value<int> rowid;
  const SyncOperationsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operationType = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOperationsCompanion.insert({
    required String id,
    required String workspaceId,
    required String entityType,
    required String entityId,
    required String operationType,
    required String payload,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workspaceId = Value(workspaceId),
        entityType = Value(entityType),
        entityId = Value(entityId),
        operationType = Value(operationType),
        payload = Value(payload);
  static Insertable<SyncOperationData> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operationType,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? syncedAt,
    Expression<String>? errorMessage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operationType != null) 'operation_type': operationType,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (errorMessage != null) 'error_message': errorMessage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOperationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workspaceId,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? operationType,
      Value<String>? payload,
      Value<String>? status,
      Value<int>? retryCount,
      Value<DateTime>? createdAt,
      Value<DateTime?>? syncedAt,
      Value<String?>? errorMessage,
      Value<int>? rowid}) {
    return SyncOperationsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operationType: operationType ?? this.operationType,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
      errorMessage: errorMessage ?? this.errorMessage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOperationsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operationType: $operationType, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, DeviceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _workspaceIdMeta =
      const VerificationMeta('workspaceId');
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
      'workspace_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _platformMeta =
      const VerificationMeta('platform');
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
      'platform', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSeenAtMeta =
      const VerificationMeta('lastSeenAt');
  @override
  late final GeneratedColumn<DateTime> lastSeenAt = GeneratedColumn<DateTime>(
      'last_seen_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workspaceId, name, platform, lastSeenAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'devices';
  @override
  VerificationContext validateIntegrity(Insertable<DeviceData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
          _workspaceIdMeta,
          workspaceId.isAcceptableOrUnknown(
              data['workspace_id']!, _workspaceIdMeta));
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(_platformMeta,
          platform.isAcceptableOrUnknown(data['platform']!, _platformMeta));
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
          _lastSeenAtMeta,
          lastSeenAt.isAcceptableOrUnknown(
              data['last_seen_at']!, _lastSeenAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      workspaceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workspace_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      platform: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platform'])!,
      lastSeenAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_seen_at'])!,
    );
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

class DeviceData extends DataClass implements Insertable<DeviceData> {
  final String id;
  final String workspaceId;
  final String name;
  final String platform;
  final DateTime lastSeenAt;
  const DeviceData(
      {required this.id,
      required this.workspaceId,
      required this.name,
      required this.platform,
      required this.lastSeenAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workspace_id'] = Variable<String>(workspaceId);
    map['name'] = Variable<String>(name);
    map['platform'] = Variable<String>(platform);
    map['last_seen_at'] = Variable<DateTime>(lastSeenAt);
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      name: Value(name),
      platform: Value(platform),
      lastSeenAt: Value(lastSeenAt),
    );
  }

  factory DeviceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceData(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      name: serializer.fromJson<String>(json['name']),
      platform: serializer.fromJson<String>(json['platform']),
      lastSeenAt: serializer.fromJson<DateTime>(json['lastSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'name': serializer.toJson<String>(name),
      'platform': serializer.toJson<String>(platform),
      'lastSeenAt': serializer.toJson<DateTime>(lastSeenAt),
    };
  }

  DeviceData copyWith(
          {String? id,
          String? workspaceId,
          String? name,
          String? platform,
          DateTime? lastSeenAt}) =>
      DeviceData(
        id: id ?? this.id,
        workspaceId: workspaceId ?? this.workspaceId,
        name: name ?? this.name,
        platform: platform ?? this.platform,
        lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      );
  DeviceData copyWithCompanion(DevicesCompanion data) {
    return DeviceData(
      id: data.id.present ? data.id.value : this.id,
      workspaceId:
          data.workspaceId.present ? data.workspaceId.value : this.workspaceId,
      name: data.name.present ? data.name.value : this.name,
      platform: data.platform.present ? data.platform.value : this.platform,
      lastSeenAt:
          data.lastSeenAt.present ? data.lastSeenAt.value : this.lastSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceData(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('name: $name, ')
          ..write('platform: $platform, ')
          ..write('lastSeenAt: $lastSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workspaceId, name, platform, lastSeenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceData &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.name == this.name &&
          other.platform == this.platform &&
          other.lastSeenAt == this.lastSeenAt);
}

class DevicesCompanion extends UpdateCompanion<DeviceData> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> name;
  final Value<String> platform;
  final Value<DateTime> lastSeenAt;
  final Value<int> rowid;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.name = const Value.absent(),
    this.platform = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DevicesCompanion.insert({
    required String id,
    required String workspaceId,
    required String name,
    required String platform,
    this.lastSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workspaceId = Value(workspaceId),
        name = Value(name),
        platform = Value(platform);
  static Insertable<DeviceData> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? name,
    Expression<String>? platform,
    Expression<DateTime>? lastSeenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (name != null) 'name': name,
      if (platform != null) 'platform': platform,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DevicesCompanion copyWith(
      {Value<String>? id,
      Value<String>? workspaceId,
      Value<String>? name,
      Value<String>? platform,
      Value<DateTime>? lastSeenAt,
      Value<int>? rowid}) {
    return DevicesCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      platform: platform ?? this.platform,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workspaceId.present) {
      map['workspace_id'] = Variable<String>(workspaceId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('name: $name, ')
          ..write('platform: $platform, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorkspacesTable workspaces = $WorkspacesTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $BinsTable bins = $BinsTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $ItemPhotosTable itemPhotos = $ItemPhotosTable(this);
  late final $InventoryEventsTable inventoryEvents =
      $InventoryEventsTable(this);
  late final $MarketplaceReferencesTable marketplaceReferences =
      $MarketplaceReferencesTable(this);
  late final $SyncOperationsTable syncOperations = $SyncOperationsTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  late final Index binsLocationCodeIdx = Index('bins_location_code_idx',
      'CREATE UNIQUE INDEX bins_location_code_idx ON bins (location_id, code)');
  late final Index itemsWorkspaceSkuIdx = Index('items_workspace_sku_idx',
      'CREATE UNIQUE INDEX items_workspace_sku_idx ON items (workspace_id, sku)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        workspaces,
        locations,
        bins,
        items,
        itemPhotos,
        inventoryEvents,
        marketplaceReferences,
        syncOperations,
        devices,
        binsLocationCodeIdx,
        itemsWorkspaceSkuIdx
      ];
}

typedef $$WorkspacesTableCreateCompanionBuilder = WorkspacesCompanion Function({
  required String id,
  required String name,
  Value<String?> code,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$WorkspacesTableUpdateCompanionBuilder = WorkspacesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> code,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$WorkspacesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$WorkspacesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WorkspacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WorkspacesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkspacesTable,
    WorkspaceData,
    $$WorkspacesTableFilterComposer,
    $$WorkspacesTableOrderingComposer,
    $$WorkspacesTableAnnotationComposer,
    $$WorkspacesTableCreateCompanionBuilder,
    $$WorkspacesTableUpdateCompanionBuilder,
    (
      WorkspaceData,
      BaseReferences<_$AppDatabase, $WorkspacesTable, WorkspaceData>
    ),
    WorkspaceData,
    PrefetchHooks Function()> {
  $$WorkspacesTableTableManager(_$AppDatabase db, $WorkspacesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkspacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkspacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkspacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkspacesCompanion(
            id: id,
            name: name,
            code: code,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> code = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkspacesCompanion.insert(
            id: id,
            name: name,
            code: code,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkspacesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkspacesTable,
    WorkspaceData,
    $$WorkspacesTableFilterComposer,
    $$WorkspacesTableOrderingComposer,
    $$WorkspacesTableAnnotationComposer,
    $$WorkspacesTableCreateCompanionBuilder,
    $$WorkspacesTableUpdateCompanionBuilder,
    (
      WorkspaceData,
      BaseReferences<_$AppDatabase, $WorkspacesTable, WorkspaceData>
    ),
    WorkspaceData,
    PrefetchHooks Function()>;
typedef $$LocationsTableCreateCompanionBuilder = LocationsCompanion Function({
  required String id,
  required String workspaceId,
  required String name,
  Value<String?> code,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$LocationsTableUpdateCompanionBuilder = LocationsCompanion Function({
  Value<String> id,
  Value<String> workspaceId,
  Value<String> name,
  Value<String?> code,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$LocationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocationsTable,
    LocationData,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (
      LocationData,
      BaseReferences<_$AppDatabase, $LocationsTable, LocationData>
    ),
    LocationData,
    PrefetchHooks Function()> {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workspaceId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocationsCompanion(
            id: id,
            workspaceId: workspaceId,
            name: name,
            code: code,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workspaceId,
            required String name,
            Value<String?> code = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocationsCompanion.insert(
            id: id,
            workspaceId: workspaceId,
            name: name,
            code: code,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocationsTable,
    LocationData,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (
      LocationData,
      BaseReferences<_$AppDatabase, $LocationsTable, LocationData>
    ),
    LocationData,
    PrefetchHooks Function()>;
typedef $$BinsTableCreateCompanionBuilder = BinsCompanion Function({
  required String id,
  required String workspaceId,
  required String locationId,
  required String code,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$BinsTableUpdateCompanionBuilder = BinsCompanion Function({
  Value<String> id,
  Value<String> workspaceId,
  Value<String> locationId,
  Value<String> code,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

class $$BinsTableFilterComposer extends Composer<_$AppDatabase, $BinsTable> {
  $$BinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$BinsTableOrderingComposer extends Composer<_$AppDatabase, $BinsTable> {
  $$BinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$BinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BinsTable> {
  $$BinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$BinsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BinsTable,
    BinData,
    $$BinsTableFilterComposer,
    $$BinsTableOrderingComposer,
    $$BinsTableAnnotationComposer,
    $$BinsTableCreateCompanionBuilder,
    $$BinsTableUpdateCompanionBuilder,
    (BinData, BaseReferences<_$AppDatabase, $BinsTable, BinData>),
    BinData,
    PrefetchHooks Function()> {
  $$BinsTableTableManager(_$AppDatabase db, $BinsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workspaceId = const Value.absent(),
            Value<String> locationId = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BinsCompanion(
            id: id,
            workspaceId: workspaceId,
            locationId: locationId,
            code: code,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workspaceId,
            required String locationId,
            required String code,
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BinsCompanion.insert(
            id: id,
            workspaceId: workspaceId,
            locationId: locationId,
            code: code,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BinsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BinsTable,
    BinData,
    $$BinsTableFilterComposer,
    $$BinsTableOrderingComposer,
    $$BinsTableAnnotationComposer,
    $$BinsTableCreateCompanionBuilder,
    $$BinsTableUpdateCompanionBuilder,
    (BinData, BaseReferences<_$AppDatabase, $BinsTable, BinData>),
    BinData,
    PrefetchHooks Function()>;
typedef $$ItemsTableCreateCompanionBuilder = ItemsCompanion Function({
  required String id,
  required String workspaceId,
  required String sku,
  required String title,
  Value<String?> description,
  Value<String> status,
  Value<String?> locationId,
  Value<String?> binId,
  Value<int?> costMinorUnits,
  Value<String> currency,
  Value<String?> brand,
  Value<String?> category,
  Value<String?> size,
  Value<String?> color,
  Value<String?> condition,
  Value<String?> source,
  Value<DateTime?> sourceDate,
  Value<DateTime?> soldAt,
  Value<int?> salePriceMinorUnits,
  Value<String?> marketplaceOrderRef,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> revision,
  Value<int> rowid,
});
typedef $$ItemsTableUpdateCompanionBuilder = ItemsCompanion Function({
  Value<String> id,
  Value<String> workspaceId,
  Value<String> sku,
  Value<String> title,
  Value<String?> description,
  Value<String> status,
  Value<String?> locationId,
  Value<String?> binId,
  Value<int?> costMinorUnits,
  Value<String> currency,
  Value<String?> brand,
  Value<String?> category,
  Value<String?> size,
  Value<String?> color,
  Value<String?> condition,
  Value<String?> source,
  Value<DateTime?> sourceDate,
  Value<DateTime?> soldAt,
  Value<int?> salePriceMinorUnits,
  Value<String?> marketplaceOrderRef,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> revision,
  Value<int> rowid,
});

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get binId => $composableBuilder(
      column: $table.binId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get costMinorUnits => $composableBuilder(
      column: $table.costMinorUnits,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get condition => $composableBuilder(
      column: $table.condition, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sourceDate => $composableBuilder(
      column: $table.sourceDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get soldAt => $composableBuilder(
      column: $table.soldAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get salePriceMinorUnits => $composableBuilder(
      column: $table.salePriceMinorUnits,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get marketplaceOrderRef => $composableBuilder(
      column: $table.marketplaceOrderRef,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get revision => $composableBuilder(
      column: $table.revision, builder: (column) => ColumnFilters(column));
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get binId => $composableBuilder(
      column: $table.binId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get costMinorUnits => $composableBuilder(
      column: $table.costMinorUnits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get condition => $composableBuilder(
      column: $table.condition, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sourceDate => $composableBuilder(
      column: $table.sourceDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get soldAt => $composableBuilder(
      column: $table.soldAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get salePriceMinorUnits => $composableBuilder(
      column: $table.salePriceMinorUnits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get marketplaceOrderRef => $composableBuilder(
      column: $table.marketplaceOrderRef,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get revision => $composableBuilder(
      column: $table.revision, builder: (column) => ColumnOrderings(column));
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => column);

  GeneratedColumn<String> get binId =>
      $composableBuilder(column: $table.binId, builder: (column) => column);

  GeneratedColumn<int> get costMinorUnits => $composableBuilder(
      column: $table.costMinorUnits, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get sourceDate => $composableBuilder(
      column: $table.sourceDate, builder: (column) => column);

  GeneratedColumn<DateTime> get soldAt =>
      $composableBuilder(column: $table.soldAt, builder: (column) => column);

  GeneratedColumn<int> get salePriceMinorUnits => $composableBuilder(
      column: $table.salePriceMinorUnits, builder: (column) => column);

  GeneratedColumn<String> get marketplaceOrderRef => $composableBuilder(
      column: $table.marketplaceOrderRef, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);
}

class $$ItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemsTable,
    ItemData,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableAnnotationComposer,
    $$ItemsTableCreateCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder,
    (ItemData, BaseReferences<_$AppDatabase, $ItemsTable, ItemData>),
    ItemData,
    PrefetchHooks Function()> {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workspaceId = const Value.absent(),
            Value<String> sku = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> locationId = const Value.absent(),
            Value<String?> binId = const Value.absent(),
            Value<int?> costMinorUnits = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String?> brand = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> size = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<String?> condition = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<DateTime?> sourceDate = const Value.absent(),
            Value<DateTime?> soldAt = const Value.absent(),
            Value<int?> salePriceMinorUnits = const Value.absent(),
            Value<String?> marketplaceOrderRef = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> revision = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemsCompanion(
            id: id,
            workspaceId: workspaceId,
            sku: sku,
            title: title,
            description: description,
            status: status,
            locationId: locationId,
            binId: binId,
            costMinorUnits: costMinorUnits,
            currency: currency,
            brand: brand,
            category: category,
            size: size,
            color: color,
            condition: condition,
            source: source,
            sourceDate: sourceDate,
            soldAt: soldAt,
            salePriceMinorUnits: salePriceMinorUnits,
            marketplaceOrderRef: marketplaceOrderRef,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            revision: revision,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workspaceId,
            required String sku,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> locationId = const Value.absent(),
            Value<String?> binId = const Value.absent(),
            Value<int?> costMinorUnits = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String?> brand = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> size = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<String?> condition = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<DateTime?> sourceDate = const Value.absent(),
            Value<DateTime?> soldAt = const Value.absent(),
            Value<int?> salePriceMinorUnits = const Value.absent(),
            Value<String?> marketplaceOrderRef = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> revision = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemsCompanion.insert(
            id: id,
            workspaceId: workspaceId,
            sku: sku,
            title: title,
            description: description,
            status: status,
            locationId: locationId,
            binId: binId,
            costMinorUnits: costMinorUnits,
            currency: currency,
            brand: brand,
            category: category,
            size: size,
            color: color,
            condition: condition,
            source: source,
            sourceDate: sourceDate,
            soldAt: soldAt,
            salePriceMinorUnits: salePriceMinorUnits,
            marketplaceOrderRef: marketplaceOrderRef,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            revision: revision,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemsTable,
    ItemData,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableAnnotationComposer,
    $$ItemsTableCreateCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder,
    (ItemData, BaseReferences<_$AppDatabase, $ItemsTable, ItemData>),
    ItemData,
    PrefetchHooks Function()>;
typedef $$ItemPhotosTableCreateCompanionBuilder = ItemPhotosCompanion Function({
  required String id,
  required String itemId,
  Value<String?> localPath,
  Value<String?> remoteUrl,
  Value<int> position,
  Value<String> uploadStatus,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ItemPhotosTableUpdateCompanionBuilder = ItemPhotosCompanion Function({
  Value<String> id,
  Value<String> itemId,
  Value<String?> localPath,
  Value<String?> remoteUrl,
  Value<int> position,
  Value<String> uploadStatus,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$ItemPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $ItemPhotosTable> {
  $$ItemPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteUrl => $composableBuilder(
      column: $table.remoteUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uploadStatus => $composableBuilder(
      column: $table.uploadStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ItemPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemPhotosTable> {
  $$ItemPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
      column: $table.remoteUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uploadStatus => $composableBuilder(
      column: $table.uploadStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ItemPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemPhotosTable> {
  $$ItemPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get uploadStatus => $composableBuilder(
      column: $table.uploadStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ItemPhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemPhotosTable,
    ItemPhotoData,
    $$ItemPhotosTableFilterComposer,
    $$ItemPhotosTableOrderingComposer,
    $$ItemPhotosTableAnnotationComposer,
    $$ItemPhotosTableCreateCompanionBuilder,
    $$ItemPhotosTableUpdateCompanionBuilder,
    (
      ItemPhotoData,
      BaseReferences<_$AppDatabase, $ItemPhotosTable, ItemPhotoData>
    ),
    ItemPhotoData,
    PrefetchHooks Function()> {
  $$ItemPhotosTableTableManager(_$AppDatabase db, $ItemPhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<String?> remoteUrl = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<String> uploadStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemPhotosCompanion(
            id: id,
            itemId: itemId,
            localPath: localPath,
            remoteUrl: remoteUrl,
            position: position,
            uploadStatus: uploadStatus,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String itemId,
            Value<String?> localPath = const Value.absent(),
            Value<String?> remoteUrl = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<String> uploadStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ItemPhotosCompanion.insert(
            id: id,
            itemId: itemId,
            localPath: localPath,
            remoteUrl: remoteUrl,
            position: position,
            uploadStatus: uploadStatus,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ItemPhotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemPhotosTable,
    ItemPhotoData,
    $$ItemPhotosTableFilterComposer,
    $$ItemPhotosTableOrderingComposer,
    $$ItemPhotosTableAnnotationComposer,
    $$ItemPhotosTableCreateCompanionBuilder,
    $$ItemPhotosTableUpdateCompanionBuilder,
    (
      ItemPhotoData,
      BaseReferences<_$AppDatabase, $ItemPhotosTable, ItemPhotoData>
    ),
    ItemPhotoData,
    PrefetchHooks Function()>;
typedef $$InventoryEventsTableCreateCompanionBuilder = InventoryEventsCompanion
    Function({
  required String id,
  required String workspaceId,
  required String itemId,
  required String type,
  Value<String?> fromLocationId,
  Value<String?> fromBinId,
  Value<String?> toLocationId,
  Value<String?> toBinId,
  Value<String?> note,
  Value<DateTime> occurredAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$InventoryEventsTableUpdateCompanionBuilder = InventoryEventsCompanion
    Function({
  Value<String> id,
  Value<String> workspaceId,
  Value<String> itemId,
  Value<String> type,
  Value<String?> fromLocationId,
  Value<String?> fromBinId,
  Value<String?> toLocationId,
  Value<String?> toBinId,
  Value<String?> note,
  Value<DateTime> occurredAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$InventoryEventsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryEventsTable> {
  $$InventoryEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fromLocationId => $composableBuilder(
      column: $table.fromLocationId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fromBinId => $composableBuilder(
      column: $table.fromBinId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get toLocationId => $composableBuilder(
      column: $table.toLocationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get toBinId => $composableBuilder(
      column: $table.toBinId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));
}

class $$InventoryEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryEventsTable> {
  $$InventoryEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fromLocationId => $composableBuilder(
      column: $table.fromLocationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fromBinId => $composableBuilder(
      column: $table.fromBinId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get toLocationId => $composableBuilder(
      column: $table.toLocationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get toBinId => $composableBuilder(
      column: $table.toBinId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));
}

class $$InventoryEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryEventsTable> {
  $$InventoryEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get fromLocationId => $composableBuilder(
      column: $table.fromLocationId, builder: (column) => column);

  GeneratedColumn<String> get fromBinId =>
      $composableBuilder(column: $table.fromBinId, builder: (column) => column);

  GeneratedColumn<String> get toLocationId => $composableBuilder(
      column: $table.toLocationId, builder: (column) => column);

  GeneratedColumn<String> get toBinId =>
      $composableBuilder(column: $table.toBinId, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$InventoryEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InventoryEventsTable,
    InventoryEventData,
    $$InventoryEventsTableFilterComposer,
    $$InventoryEventsTableOrderingComposer,
    $$InventoryEventsTableAnnotationComposer,
    $$InventoryEventsTableCreateCompanionBuilder,
    $$InventoryEventsTableUpdateCompanionBuilder,
    (
      InventoryEventData,
      BaseReferences<_$AppDatabase, $InventoryEventsTable, InventoryEventData>
    ),
    InventoryEventData,
    PrefetchHooks Function()> {
  $$InventoryEventsTableTableManager(
      _$AppDatabase db, $InventoryEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workspaceId = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> fromLocationId = const Value.absent(),
            Value<String?> fromBinId = const Value.absent(),
            Value<String?> toLocationId = const Value.absent(),
            Value<String?> toBinId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventoryEventsCompanion(
            id: id,
            workspaceId: workspaceId,
            itemId: itemId,
            type: type,
            fromLocationId: fromLocationId,
            fromBinId: fromBinId,
            toLocationId: toLocationId,
            toBinId: toBinId,
            note: note,
            occurredAt: occurredAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workspaceId,
            required String itemId,
            required String type,
            Value<String?> fromLocationId = const Value.absent(),
            Value<String?> fromBinId = const Value.absent(),
            Value<String?> toLocationId = const Value.absent(),
            Value<String?> toBinId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InventoryEventsCompanion.insert(
            id: id,
            workspaceId: workspaceId,
            itemId: itemId,
            type: type,
            fromLocationId: fromLocationId,
            fromBinId: fromBinId,
            toLocationId: toLocationId,
            toBinId: toBinId,
            note: note,
            occurredAt: occurredAt,
            synced: synced,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InventoryEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InventoryEventsTable,
    InventoryEventData,
    $$InventoryEventsTableFilterComposer,
    $$InventoryEventsTableOrderingComposer,
    $$InventoryEventsTableAnnotationComposer,
    $$InventoryEventsTableCreateCompanionBuilder,
    $$InventoryEventsTableUpdateCompanionBuilder,
    (
      InventoryEventData,
      BaseReferences<_$AppDatabase, $InventoryEventsTable, InventoryEventData>
    ),
    InventoryEventData,
    PrefetchHooks Function()>;
typedef $$MarketplaceReferencesTableCreateCompanionBuilder
    = MarketplaceReferencesCompanion Function({
  required String id,
  required String itemId,
  required String platform,
  required String externalId,
  Value<String?> listingUrl,
  Value<String?> status,
  Value<DateTime?> listedAt,
  Value<DateTime?> soldAt,
  Value<int?> priceMinorUnits,
  Value<String> currency,
  Value<int> rowid,
});
typedef $$MarketplaceReferencesTableUpdateCompanionBuilder
    = MarketplaceReferencesCompanion Function({
  Value<String> id,
  Value<String> itemId,
  Value<String> platform,
  Value<String> externalId,
  Value<String?> listingUrl,
  Value<String?> status,
  Value<DateTime?> listedAt,
  Value<DateTime?> soldAt,
  Value<int?> priceMinorUnits,
  Value<String> currency,
  Value<int> rowid,
});

class $$MarketplaceReferencesTableFilterComposer
    extends Composer<_$AppDatabase, $MarketplaceReferencesTable> {
  $$MarketplaceReferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get listingUrl => $composableBuilder(
      column: $table.listingUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get listedAt => $composableBuilder(
      column: $table.listedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get soldAt => $composableBuilder(
      column: $table.soldAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceMinorUnits => $composableBuilder(
      column: $table.priceMinorUnits,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));
}

class $$MarketplaceReferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $MarketplaceReferencesTable> {
  $$MarketplaceReferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get listingUrl => $composableBuilder(
      column: $table.listingUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get listedAt => $composableBuilder(
      column: $table.listedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get soldAt => $composableBuilder(
      column: $table.soldAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceMinorUnits => $composableBuilder(
      column: $table.priceMinorUnits,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));
}

class $$MarketplaceReferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MarketplaceReferencesTable> {
  $$MarketplaceReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => column);

  GeneratedColumn<String> get listingUrl => $composableBuilder(
      column: $table.listingUrl, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get listedAt =>
      $composableBuilder(column: $table.listedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get soldAt =>
      $composableBuilder(column: $table.soldAt, builder: (column) => column);

  GeneratedColumn<int> get priceMinorUnits => $composableBuilder(
      column: $table.priceMinorUnits, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);
}

class $$MarketplaceReferencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MarketplaceReferencesTable,
    MarketplaceReferenceData,
    $$MarketplaceReferencesTableFilterComposer,
    $$MarketplaceReferencesTableOrderingComposer,
    $$MarketplaceReferencesTableAnnotationComposer,
    $$MarketplaceReferencesTableCreateCompanionBuilder,
    $$MarketplaceReferencesTableUpdateCompanionBuilder,
    (
      MarketplaceReferenceData,
      BaseReferences<_$AppDatabase, $MarketplaceReferencesTable,
          MarketplaceReferenceData>
    ),
    MarketplaceReferenceData,
    PrefetchHooks Function()> {
  $$MarketplaceReferencesTableTableManager(
      _$AppDatabase db, $MarketplaceReferencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MarketplaceReferencesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$MarketplaceReferencesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MarketplaceReferencesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String> platform = const Value.absent(),
            Value<String> externalId = const Value.absent(),
            Value<String?> listingUrl = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<DateTime?> listedAt = const Value.absent(),
            Value<DateTime?> soldAt = const Value.absent(),
            Value<int?> priceMinorUnits = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MarketplaceReferencesCompanion(
            id: id,
            itemId: itemId,
            platform: platform,
            externalId: externalId,
            listingUrl: listingUrl,
            status: status,
            listedAt: listedAt,
            soldAt: soldAt,
            priceMinorUnits: priceMinorUnits,
            currency: currency,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String itemId,
            required String platform,
            required String externalId,
            Value<String?> listingUrl = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<DateTime?> listedAt = const Value.absent(),
            Value<DateTime?> soldAt = const Value.absent(),
            Value<int?> priceMinorUnits = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MarketplaceReferencesCompanion.insert(
            id: id,
            itemId: itemId,
            platform: platform,
            externalId: externalId,
            listingUrl: listingUrl,
            status: status,
            listedAt: listedAt,
            soldAt: soldAt,
            priceMinorUnits: priceMinorUnits,
            currency: currency,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MarketplaceReferencesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $MarketplaceReferencesTable,
        MarketplaceReferenceData,
        $$MarketplaceReferencesTableFilterComposer,
        $$MarketplaceReferencesTableOrderingComposer,
        $$MarketplaceReferencesTableAnnotationComposer,
        $$MarketplaceReferencesTableCreateCompanionBuilder,
        $$MarketplaceReferencesTableUpdateCompanionBuilder,
        (
          MarketplaceReferenceData,
          BaseReferences<_$AppDatabase, $MarketplaceReferencesTable,
              MarketplaceReferenceData>
        ),
        MarketplaceReferenceData,
        PrefetchHooks Function()>;
typedef $$SyncOperationsTableCreateCompanionBuilder = SyncOperationsCompanion
    Function({
  required String id,
  required String workspaceId,
  required String entityType,
  required String entityId,
  required String operationType,
  required String payload,
  Value<String> status,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<DateTime?> syncedAt,
  Value<String?> errorMessage,
  Value<int> rowid,
});
typedef $$SyncOperationsTableUpdateCompanionBuilder = SyncOperationsCompanion
    Function({
  Value<String> id,
  Value<String> workspaceId,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> operationType,
  Value<String> payload,
  Value<String> status,
  Value<int> retryCount,
  Value<DateTime> createdAt,
  Value<DateTime?> syncedAt,
  Value<String?> errorMessage,
  Value<int> rowid,
});

class $$SyncOperationsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOperationsTable> {
  $$SyncOperationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operationType => $composableBuilder(
      column: $table.operationType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));
}

class $$SyncOperationsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOperationsTable> {
  $$SyncOperationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operationType => $composableBuilder(
      column: $table.operationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncOperationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOperationsTable> {
  $$SyncOperationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operationType => $composableBuilder(
      column: $table.operationType, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);
}

class $$SyncOperationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncOperationsTable,
    SyncOperationData,
    $$SyncOperationsTableFilterComposer,
    $$SyncOperationsTableOrderingComposer,
    $$SyncOperationsTableAnnotationComposer,
    $$SyncOperationsTableCreateCompanionBuilder,
    $$SyncOperationsTableUpdateCompanionBuilder,
    (
      SyncOperationData,
      BaseReferences<_$AppDatabase, $SyncOperationsTable, SyncOperationData>
    ),
    SyncOperationData,
    PrefetchHooks Function()> {
  $$SyncOperationsTableTableManager(
      _$AppDatabase db, $SyncOperationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOperationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOperationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOperationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workspaceId = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> operationType = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncOperationsCompanion(
            id: id,
            workspaceId: workspaceId,
            entityType: entityType,
            entityId: entityId,
            operationType: operationType,
            payload: payload,
            status: status,
            retryCount: retryCount,
            createdAt: createdAt,
            syncedAt: syncedAt,
            errorMessage: errorMessage,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workspaceId,
            required String entityType,
            required String entityId,
            required String operationType,
            required String payload,
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncOperationsCompanion.insert(
            id: id,
            workspaceId: workspaceId,
            entityType: entityType,
            entityId: entityId,
            operationType: operationType,
            payload: payload,
            status: status,
            retryCount: retryCount,
            createdAt: createdAt,
            syncedAt: syncedAt,
            errorMessage: errorMessage,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncOperationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncOperationsTable,
    SyncOperationData,
    $$SyncOperationsTableFilterComposer,
    $$SyncOperationsTableOrderingComposer,
    $$SyncOperationsTableAnnotationComposer,
    $$SyncOperationsTableCreateCompanionBuilder,
    $$SyncOperationsTableUpdateCompanionBuilder,
    (
      SyncOperationData,
      BaseReferences<_$AppDatabase, $SyncOperationsTable, SyncOperationData>
    ),
    SyncOperationData,
    PrefetchHooks Function()>;
typedef $$DevicesTableCreateCompanionBuilder = DevicesCompanion Function({
  required String id,
  required String workspaceId,
  required String name,
  required String platform,
  Value<DateTime> lastSeenAt,
  Value<int> rowid,
});
typedef $$DevicesTableUpdateCompanionBuilder = DevicesCompanion Function({
  Value<String> id,
  Value<String> workspaceId,
  Value<String> name,
  Value<String> platform,
  Value<DateTime> lastSeenAt,
  Value<int> rowid,
});

class $$DevicesTableFilterComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => ColumnFilters(column));
}

class $$DevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => ColumnOrderings(column));
}

class $$DevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DevicesTable> {
  $$DevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workspaceId => $composableBuilder(
      column: $table.workspaceId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeenAt => $composableBuilder(
      column: $table.lastSeenAt, builder: (column) => column);
}

class $$DevicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DevicesTable,
    DeviceData,
    $$DevicesTableFilterComposer,
    $$DevicesTableOrderingComposer,
    $$DevicesTableAnnotationComposer,
    $$DevicesTableCreateCompanionBuilder,
    $$DevicesTableUpdateCompanionBuilder,
    (DeviceData, BaseReferences<_$AppDatabase, $DevicesTable, DeviceData>),
    DeviceData,
    PrefetchHooks Function()> {
  $$DevicesTableTableManager(_$AppDatabase db, $DevicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> workspaceId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> platform = const Value.absent(),
            Value<DateTime> lastSeenAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DevicesCompanion(
            id: id,
            workspaceId: workspaceId,
            name: name,
            platform: platform,
            lastSeenAt: lastSeenAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String workspaceId,
            required String name,
            required String platform,
            Value<DateTime> lastSeenAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DevicesCompanion.insert(
            id: id,
            workspaceId: workspaceId,
            name: name,
            platform: platform,
            lastSeenAt: lastSeenAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DevicesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DevicesTable,
    DeviceData,
    $$DevicesTableFilterComposer,
    $$DevicesTableOrderingComposer,
    $$DevicesTableAnnotationComposer,
    $$DevicesTableCreateCompanionBuilder,
    $$DevicesTableUpdateCompanionBuilder,
    (DeviceData, BaseReferences<_$AppDatabase, $DevicesTable, DeviceData>),
    DeviceData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorkspacesTableTableManager get workspaces =>
      $$WorkspacesTableTableManager(_db, _db.workspaces);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$BinsTableTableManager get bins => $$BinsTableTableManager(_db, _db.bins);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$ItemPhotosTableTableManager get itemPhotos =>
      $$ItemPhotosTableTableManager(_db, _db.itemPhotos);
  $$InventoryEventsTableTableManager get inventoryEvents =>
      $$InventoryEventsTableTableManager(_db, _db.inventoryEvents);
  $$MarketplaceReferencesTableTableManager get marketplaceReferences =>
      $$MarketplaceReferencesTableTableManager(_db, _db.marketplaceReferences);
  $$SyncOperationsTableTableManager get syncOperations =>
      $$SyncOperationsTableTableManager(_db, _db.syncOperations);
  $$DevicesTableTableManager get devices =>
      $$DevicesTableTableManager(_db, _db.devices);
}
