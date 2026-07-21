import 'package:flowery/modules/auth/domain/entities/country_entity.dart';

class CountryModel {
  final String isoCode;
  final String name;
  final String phoneCode;
  final String flag;
  final String currency;
  final String latitude;
  final String longitude;
  final List<TimezoneModel> timezones;

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

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      isoCode: json['isoCode'] ?? '',
      name: json['name'] ?? '',
      phoneCode: json['phoneCode'] ?? '',
      flag: json['flag'] ?? '',
      currency: json['currency'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      timezones: (json['timezones'] as List<dynamic>?)
              ?.map((x) => TimezoneModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isoCode': isoCode,
      'name': name,
      'phoneCode': phoneCode,
      'flag': flag,
      'currency': currency,
      'latitude': latitude,
      'longitude': longitude,
      'timezones': timezones.map((x) => x.toJson()).toList(),
    };
  }

  CountryEntity toEntity() {
    return CountryEntity(
      isoCode: isoCode,
      name: name,
      phoneCode: phoneCode,
      flag: flag,
      currency: currency,
      latitude: latitude,
      longitude: longitude,
      timezones: timezones.map((e) => e.toEntity()).toList(),
    );
  }
}

class TimezoneModel {
  final String zoneName;
  final int gmtOffset;
  final String gmtOffsetName;
  final String abbreviation;
  final String tzName;

  const TimezoneModel({
    required this.zoneName,
    required this.gmtOffset,
    required this.gmtOffsetName,
    required this.abbreviation,
    required this.tzName,
  });

  factory TimezoneModel.fromJson(Map<String, dynamic> json) {
    return TimezoneModel(
      zoneName: json['zoneName'] ?? '',
      gmtOffset: (json['gmtOffset'] as num?)?.toInt() ?? 0,
      gmtOffsetName: json['gmtOffsetName'] ?? '',
      abbreviation: json['abbreviation'] ?? '',
      tzName: json['tzName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zoneName': zoneName,
      'gmtOffset': gmtOffset,
      'gmtOffsetName': gmtOffsetName,
      'abbreviation': abbreviation,
      'tzName': tzName,
    };
  }

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