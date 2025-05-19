// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutCollection on Isar {
  IsarCollection<Workout> get workouts => this.collection();
}

const WorkoutSchema = CollectionSchema(
  name: r'Workout',
  id: 1535508263686820971,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'createdAtIndex': PropertySchema(
      id: 1,
      name: r'createdAtIndex',
      type: IsarType.dateTime,
    ),
    r'reps': PropertySchema(
      id: 2,
      name: r'reps',
      type: IsarType.objectList,
      target: r'WorkoutRep',
    ),
    r'routineId': PropertySchema(
      id: 3,
      name: r'routineId',
      type: IsarType.long,
    ),
    r'routineIdIndex': PropertySchema(
      id: 4,
      name: r'routineIdIndex',
      type: IsarType.long,
    ),
    r'routineName': PropertySchema(
      id: 5,
      name: r'routineName',
      type: IsarType.string,
    ),
    r'routineType': PropertySchema(
      id: 6,
      name: r'routineType',
      type: IsarType.string,
      enumMap: _WorkoutroutineTypeEnumValueMap,
    )
  },
  estimateSize: _workoutEstimateSize,
  serialize: _workoutSerialize,
  deserialize: _workoutDeserialize,
  deserializeProp: _workoutDeserializeProp,
  idName: r'id',
  indexes: {
    r'createdAtIndex': IndexSchema(
      id: -7100342901358937067,
      name: r'createdAtIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAtIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'routineIdIndex': IndexSchema(
      id: 3527703578169671617,
      name: r'routineIdIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'routineIdIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'WorkoutRep': WorkoutRepSchema},
  getId: _workoutGetId,
  getLinks: _workoutGetLinks,
  attach: _workoutAttach,
  version: '3.1.0+1',
);

int _workoutEstimateSize(
  Workout object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.reps.length * 3;
  {
    final offsets = allOffsets[WorkoutRep]!;
    for (var i = 0; i < object.reps.length; i++) {
      final value = object.reps[i];
      bytesCount += WorkoutRepSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.routineName.length * 3;
  bytesCount += 3 + object.routineType.name.length * 3;
  return bytesCount;
}

void _workoutSerialize(
  Workout object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.createdAtIndex);
  writer.writeObjectList<WorkoutRep>(
    offsets[2],
    allOffsets,
    WorkoutRepSchema.serialize,
    object.reps,
  );
  writer.writeLong(offsets[3], object.routineId);
  writer.writeLong(offsets[4], object.routineIdIndex);
  writer.writeString(offsets[5], object.routineName);
  writer.writeString(offsets[6], object.routineType.name);
}

Workout _workoutDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Workout();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.reps = reader.readObjectList<WorkoutRep>(
        offsets[2],
        WorkoutRepSchema.deserialize,
        allOffsets,
        WorkoutRep(),
      ) ??
      [];
  object.routineId = reader.readLong(offsets[3]);
  object.routineName = reader.readString(offsets[5]);
  object.routineType =
      _WorkoutroutineTypeValueEnumMap[reader.readStringOrNull(offsets[6])] ??
          RoutineType.acceleration;
  return object;
}

P _workoutDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readObjectList<WorkoutRep>(
            offset,
            WorkoutRepSchema.deserialize,
            allOffsets,
            WorkoutRep(),
          ) ??
          []) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (_WorkoutroutineTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          RoutineType.acceleration) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _WorkoutroutineTypeEnumValueMap = {
  r'acceleration': r'acceleration',
  r'maxVelocity': r'maxVelocity',
  r'speedEndurance': r'speedEndurance',
  r'specialEndurance': r'specialEndurance',
  r'technicalDrills': r'technicalDrills',
  r'tempo': r'tempo',
};
const _WorkoutroutineTypeValueEnumMap = {
  r'acceleration': RoutineType.acceleration,
  r'maxVelocity': RoutineType.maxVelocity,
  r'speedEndurance': RoutineType.speedEndurance,
  r'specialEndurance': RoutineType.specialEndurance,
  r'technicalDrills': RoutineType.technicalDrills,
  r'tempo': RoutineType.tempo,
};

Id _workoutGetId(Workout object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutGetLinks(Workout object) {
  return [];
}

void _workoutAttach(IsarCollection<dynamic> col, Id id, Workout object) {
  object.id = id;
}

extension WorkoutQueryWhereSort on QueryBuilder<Workout, Workout, QWhere> {
  QueryBuilder<Workout, Workout, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhere> anyCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAtIndex'),
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhere> anyRoutineIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'routineIdIndex'),
      );
    });
  }
}

extension WorkoutQueryWhere on QueryBuilder<Workout, Workout, QWhereClause> {
  QueryBuilder<Workout, Workout, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> createdAtIndexEqualTo(
      DateTime createdAtIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAtIndex',
        value: [createdAtIndex],
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> createdAtIndexNotEqualTo(
      DateTime createdAtIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [],
              upper: [createdAtIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [createdAtIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [createdAtIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAtIndex',
              lower: [],
              upper: [createdAtIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> createdAtIndexGreaterThan(
    DateTime createdAtIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [createdAtIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> createdAtIndexLessThan(
    DateTime createdAtIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [],
        upper: [createdAtIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> createdAtIndexBetween(
    DateTime lowerCreatedAtIndex,
    DateTime upperCreatedAtIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAtIndex',
        lower: [lowerCreatedAtIndex],
        includeLower: includeLower,
        upper: [upperCreatedAtIndex],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> routineIdIndexEqualTo(
      int routineIdIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'routineIdIndex',
        value: [routineIdIndex],
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> routineIdIndexNotEqualTo(
      int routineIdIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'routineIdIndex',
              lower: [],
              upper: [routineIdIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'routineIdIndex',
              lower: [routineIdIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'routineIdIndex',
              lower: [routineIdIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'routineIdIndex',
              lower: [],
              upper: [routineIdIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> routineIdIndexGreaterThan(
    int routineIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'routineIdIndex',
        lower: [routineIdIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> routineIdIndexLessThan(
    int routineIdIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'routineIdIndex',
        lower: [],
        upper: [routineIdIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterWhereClause> routineIdIndexBetween(
    int lowerRoutineIdIndex,
    int upperRoutineIdIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'routineIdIndex',
        lower: [lowerRoutineIdIndex],
        includeLower: includeLower,
        upper: [upperRoutineIdIndex],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WorkoutQueryFilter
    on QueryBuilder<Workout, Workout, QFilterCondition> {
  QueryBuilder<Workout, Workout, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> createdAtIndexEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition>
      createdAtIndexGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> createdAtIndexLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> createdAtIndexBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> repsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> repsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> repsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> repsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> repsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> repsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'reps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineId',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routineId',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routineId',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routineId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineIdIndexEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition>
      routineIdIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routineIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineIdIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routineIdIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineIdIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routineIdIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routineName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routineName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routineName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineName',
        value: '',
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition>
      routineNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routineName',
        value: '',
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeEqualTo(
    RoutineType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeGreaterThan(
    RoutineType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeLessThan(
    RoutineType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeBetween(
    RoutineType lower,
    RoutineType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routineType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'routineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'routineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'routineType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'routineType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition> routineTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineType',
        value: '',
      ));
    });
  }

  QueryBuilder<Workout, Workout, QAfterFilterCondition>
      routineTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'routineType',
        value: '',
      ));
    });
  }
}

extension WorkoutQueryObject
    on QueryBuilder<Workout, Workout, QFilterCondition> {
  QueryBuilder<Workout, Workout, QAfterFilterCondition> repsElement(
      FilterQuery<WorkoutRep> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'reps');
    });
  }
}

extension WorkoutQueryLinks
    on QueryBuilder<Workout, Workout, QFilterCondition> {}

extension WorkoutQuerySortBy on QueryBuilder<Workout, Workout, QSortBy> {
  QueryBuilder<Workout, Workout, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByCreatedAtIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByRoutineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineId', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByRoutineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineId', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByRoutineIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineIdIndex', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByRoutineIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineIdIndex', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByRoutineName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineName', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByRoutineNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineName', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByRoutineType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineType', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> sortByRoutineTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineType', Sort.desc);
    });
  }
}

extension WorkoutQuerySortThenBy
    on QueryBuilder<Workout, Workout, QSortThenBy> {
  QueryBuilder<Workout, Workout, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByCreatedAtIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtIndex', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByRoutineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineId', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByRoutineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineId', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByRoutineIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineIdIndex', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByRoutineIdIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineIdIndex', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByRoutineName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineName', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByRoutineNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineName', Sort.desc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByRoutineType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineType', Sort.asc);
    });
  }

  QueryBuilder<Workout, Workout, QAfterSortBy> thenByRoutineTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineType', Sort.desc);
    });
  }
}

extension WorkoutQueryWhereDistinct
    on QueryBuilder<Workout, Workout, QDistinct> {
  QueryBuilder<Workout, Workout, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Workout, Workout, QDistinct> distinctByCreatedAtIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtIndex');
    });
  }

  QueryBuilder<Workout, Workout, QDistinct> distinctByRoutineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineId');
    });
  }

  QueryBuilder<Workout, Workout, QDistinct> distinctByRoutineIdIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineIdIndex');
    });
  }

  QueryBuilder<Workout, Workout, QDistinct> distinctByRoutineName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Workout, Workout, QDistinct> distinctByRoutineType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineType', caseSensitive: caseSensitive);
    });
  }
}

extension WorkoutQueryProperty
    on QueryBuilder<Workout, Workout, QQueryProperty> {
  QueryBuilder<Workout, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Workout, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Workout, DateTime, QQueryOperations> createdAtIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtIndex');
    });
  }

  QueryBuilder<Workout, List<WorkoutRep>, QQueryOperations> repsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reps');
    });
  }

  QueryBuilder<Workout, int, QQueryOperations> routineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineId');
    });
  }

  QueryBuilder<Workout, int, QQueryOperations> routineIdIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineIdIndex');
    });
  }

  QueryBuilder<Workout, String, QQueryOperations> routineNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineName');
    });
  }

  QueryBuilder<Workout, RoutineType, QQueryOperations> routineTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineType');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const WorkoutRepSchema = Schema(
  name: r'WorkoutRep',
  id: 8059033879384015871,
  properties: {
    r'completionTime': PropertySchema(
      id: 0,
      name: r'completionTime',
      type: IsarType.double,
    ),
    r'distanceInMeters': PropertySchema(
      id: 1,
      name: r'distanceInMeters',
      type: IsarType.long,
    ),
    r'effort': PropertySchema(
      id: 2,
      name: r'effort',
      type: IsarType.double,
    ),
    r'exerciseName': PropertySchema(
      id: 3,
      name: r'exerciseName',
      type: IsarType.string,
    ),
    r'exerciseUuid': PropertySchema(
      id: 4,
      name: r'exerciseUuid',
      type: IsarType.string,
    ),
    r'repNumber': PropertySchema(
      id: 5,
      name: r'repNumber',
      type: IsarType.long,
    ),
    r'startingPosition': PropertySchema(
      id: 6,
      name: r'startingPosition',
      type: IsarType.string,
    )
  },
  estimateSize: _workoutRepEstimateSize,
  serialize: _workoutRepSerialize,
  deserialize: _workoutRepDeserialize,
  deserializeProp: _workoutRepDeserializeProp,
);

int _workoutRepEstimateSize(
  WorkoutRep object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.exerciseName.length * 3;
  bytesCount += 3 + object.exerciseUuid.length * 3;
  bytesCount += 3 + object.startingPosition.length * 3;
  return bytesCount;
}

void _workoutRepSerialize(
  WorkoutRep object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.completionTime);
  writer.writeLong(offsets[1], object.distanceInMeters);
  writer.writeDouble(offsets[2], object.effort);
  writer.writeString(offsets[3], object.exerciseName);
  writer.writeString(offsets[4], object.exerciseUuid);
  writer.writeLong(offsets[5], object.repNumber);
  writer.writeString(offsets[6], object.startingPosition);
}

WorkoutRep _workoutRepDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutRep();
  object.completionTime = reader.readDouble(offsets[0]);
  object.distanceInMeters = reader.readLong(offsets[1]);
  object.effort = reader.readDouble(offsets[2]);
  object.exerciseName = reader.readString(offsets[3]);
  object.exerciseUuid = reader.readString(offsets[4]);
  object.repNumber = reader.readLong(offsets[5]);
  object.startingPosition = reader.readString(offsets[6]);
  return object;
}

P _workoutRepDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension WorkoutRepQueryFilter
    on QueryBuilder<WorkoutRep, WorkoutRep, QFilterCondition> {
  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      completionTimeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completionTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      completionTimeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completionTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      completionTimeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completionTime',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      completionTimeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completionTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      distanceInMetersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceInMeters',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      distanceInMetersGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceInMeters',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      distanceInMetersLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceInMeters',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      distanceInMetersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceInMeters',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition> effortEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'effort',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition> effortGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'effort',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition> effortLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'effort',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition> effortBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'effort',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseName',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseName',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exerciseUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exerciseUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exerciseUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exerciseUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exerciseUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exerciseUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exerciseUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exerciseUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      exerciseUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exerciseUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition> repNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      repNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition> repNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition> repNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startingPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startingPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startingPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startingPosition',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'startingPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'startingPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'startingPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'startingPosition',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startingPosition',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRep, WorkoutRep, QAfterFilterCondition>
      startingPositionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'startingPosition',
        value: '',
      ));
    });
  }
}

extension WorkoutRepQueryObject
    on QueryBuilder<WorkoutRep, WorkoutRep, QFilterCondition> {}
