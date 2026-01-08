// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserSettingsCollection on Isar {
  IsarCollection<UserSettings> get userSettings => this.collection();
}

const UserSettingsSchema = CollectionSchema(
  name: r'UserSettings',
  id: 4939698790990493221,
  properties: {
    r'darkMode': PropertySchema(
      id: 0,
      name: r'darkMode',
      type: IsarType.bool,
    ),
    r'defaultDuration': PropertySchema(
      id: 1,
      name: r'defaultDuration',
      type: IsarType.long,
    ),
    r'notificationSound': PropertySchema(
      id: 2,
      name: r'notificationSound',
      type: IsarType.string,
    ),
    r'preferredSound': PropertySchema(
      id: 3,
      name: r'preferredSound',
      type: IsarType.string,
    ),
    r'showNotesPrompt': PropertySchema(
      id: 4,
      name: r'showNotesPrompt',
      type: IsarType.bool,
    ),
    r'soundVolumesJson': PropertySchema(
      id: 5,
      name: r'soundVolumesJson',
      type: IsarType.string,
    ),
    r'vibrationEnabled': PropertySchema(
      id: 6,
      name: r'vibrationEnabled',
      type: IsarType.bool,
    )
  },
  estimateSize: _userSettingsEstimateSize,
  serialize: _userSettingsSerialize,
  deserialize: _userSettingsDeserialize,
  deserializeProp: _userSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userSettingsGetId,
  getLinks: _userSettingsGetLinks,
  attach: _userSettingsAttach,
  version: '3.1.0+1',
);

int _userSettingsEstimateSize(
  UserSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.notificationSound.length * 3;
  {
    final value = object.preferredSound;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.soundVolumesJson.length * 3;
  return bytesCount;
}

void _userSettingsSerialize(
  UserSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.darkMode);
  writer.writeLong(offsets[1], object.defaultDuration);
  writer.writeString(offsets[2], object.notificationSound);
  writer.writeString(offsets[3], object.preferredSound);
  writer.writeBool(offsets[4], object.showNotesPrompt);
  writer.writeString(offsets[5], object.soundVolumesJson);
  writer.writeBool(offsets[6], object.vibrationEnabled);
}

UserSettings _userSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserSettings();
  object.darkMode = reader.readBool(offsets[0]);
  object.defaultDuration = reader.readLong(offsets[1]);
  object.id = id;
  object.notificationSound = reader.readString(offsets[2]);
  object.preferredSound = reader.readStringOrNull(offsets[3]);
  object.showNotesPrompt = reader.readBool(offsets[4]);
  object.soundVolumesJson = reader.readString(offsets[5]);
  object.vibrationEnabled = reader.readBool(offsets[6]);
  return object;
}

P _userSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userSettingsGetId(UserSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userSettingsGetLinks(UserSettings object) {
  return [];
}

void _userSettingsAttach(
    IsarCollection<dynamic> col, Id id, UserSettings object) {
  object.id = id;
}

extension UserSettingsQueryWhereSort
    on QueryBuilder<UserSettings, UserSettings, QWhere> {
  QueryBuilder<UserSettings, UserSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserSettingsQueryWhere
    on QueryBuilder<UserSettings, UserSettings, QWhereClause> {
  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterWhereClause> idBetween(
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
}

extension UserSettingsQueryFilter
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {
  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      darkModeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'darkMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      defaultDurationEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      defaultDurationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      defaultDurationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      defaultDurationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationSound',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notificationSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notificationSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notificationSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notificationSound',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationSound',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      notificationSoundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notificationSound',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'preferredSound',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'preferredSound',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preferredSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preferredSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preferredSound',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'preferredSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'preferredSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'preferredSound',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'preferredSound',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredSound',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      preferredSoundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'preferredSound',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      showNotesPromptEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showNotesPrompt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundVolumesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soundVolumesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soundVolumesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soundVolumesJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'soundVolumesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'soundVolumesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'soundVolumesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'soundVolumesJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundVolumesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      soundVolumesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'soundVolumesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterFilterCondition>
      vibrationEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vibrationEnabled',
        value: value,
      ));
    });
  }
}

extension UserSettingsQueryObject
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {}

extension UserSettingsQueryLinks
    on QueryBuilder<UserSettings, UserSettings, QFilterCondition> {}

extension UserSettingsQuerySortBy
    on QueryBuilder<UserSettings, UserSettings, QSortBy> {
  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkMode', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> sortByDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkMode', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByDefaultDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultDuration', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByDefaultDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultDuration', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByNotificationSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationSound', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByNotificationSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationSound', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByPreferredSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredSound', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByPreferredSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredSound', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByShowNotesPrompt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showNotesPrompt', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByShowNotesPromptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showNotesPrompt', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortBySoundVolumesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundVolumesJson', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortBySoundVolumesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundVolumesJson', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByVibrationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrationEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      sortByVibrationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrationEnabled', Sort.desc);
    });
  }
}

extension UserSettingsQuerySortThenBy
    on QueryBuilder<UserSettings, UserSettings, QSortThenBy> {
  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkMode', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'darkMode', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByDefaultDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultDuration', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByDefaultDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultDuration', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByNotificationSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationSound', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByNotificationSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationSound', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByPreferredSound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredSound', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByPreferredSoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredSound', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByShowNotesPrompt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showNotesPrompt', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByShowNotesPromptDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showNotesPrompt', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenBySoundVolumesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundVolumesJson', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenBySoundVolumesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundVolumesJson', Sort.desc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByVibrationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrationEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QAfterSortBy>
      thenByVibrationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vibrationEnabled', Sort.desc);
    });
  }
}

extension UserSettingsQueryWhereDistinct
    on QueryBuilder<UserSettings, UserSettings, QDistinct> {
  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'darkMode');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByDefaultDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultDuration');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByNotificationSound({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationSound',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct> distinctByPreferredSound(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preferredSound',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByShowNotesPrompt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showNotesPrompt');
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctBySoundVolumesJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soundVolumesJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSettings, UserSettings, QDistinct>
      distinctByVibrationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vibrationEnabled');
    });
  }
}

extension UserSettingsQueryProperty
    on QueryBuilder<UserSettings, UserSettings, QQueryProperty> {
  QueryBuilder<UserSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> darkModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'darkMode');
    });
  }

  QueryBuilder<UserSettings, int, QQueryOperations> defaultDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultDuration');
    });
  }

  QueryBuilder<UserSettings, String, QQueryOperations>
      notificationSoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationSound');
    });
  }

  QueryBuilder<UserSettings, String?, QQueryOperations>
      preferredSoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferredSound');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations> showNotesPromptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showNotesPrompt');
    });
  }

  QueryBuilder<UserSettings, String, QQueryOperations>
      soundVolumesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soundVolumesJson');
    });
  }

  QueryBuilder<UserSettings, bool, QQueryOperations>
      vibrationEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vibrationEnabled');
    });
  }
}
