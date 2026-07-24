import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  @JsonKey(name: 'isoCode')
  final String? isoCode;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'phoneCode')
  final String? phoneCode;
  @JsonKey(name: 'flag')
  final String? flag;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'latitude')
  final String? latitude;
  @JsonKey(name: 'longitude')
  final String? longitude;
  @JsonKey(name: 'timezones')
  final List<TimezoneModel>? timezones;

  const CountryModel({
    required this.isoCode,
    required this.name,
    required this.phoneCode,
    required this.flag,
    required this.currency,
    required this.latitude,
    required this.longitude,
    required this.timezones,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  CountryEntity toEntity() {
    return CountryEntity(
      isoCode: isoCode,
      name: name,
      phoneCode: phoneCode,
      flag: flag,
      currency: currency,
      latitude: latitude,
      longitude: longitude,
      timezones: timezones?.map((e) => e.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class TimezoneModel {
  @JsonKey(name: 'zoneName')
  final String? zoneName;
  @JsonKey(name: 'gmtOffset', defaultValue: 0)
  final int? gmtOffset;
  @JsonKey(name: 'gmtOffsetName')
  final String? gmtOffsetName;
  @JsonKey(name: 'abbreviation')
  final String? abbreviation;
  @JsonKey(name: 'tzName')
  final String? tzName;

  const TimezoneModel({
    required this.zoneName,
    required this.gmtOffset,
    required this.gmtOffsetName,
    required this.abbreviation,
    required this.tzName,
  });

  factory TimezoneModel.fromJson(Map<String, dynamic> json) =>
      _$TimezoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimezoneModelToJson(this);

  TimezoneEntity toEntity() {
    return TimezoneEntity(
      zoneName: zoneName,
      gmtOffset: gmtOffset,
      gmtOffsetName: gmtOffsetName,
      abbreviation: abbreviation,
      tzName: tzName,
    );
  }
}