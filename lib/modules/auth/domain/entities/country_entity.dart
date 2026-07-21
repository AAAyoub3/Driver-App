import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String isoCode;
  final String name;
  final String phoneCode;
  final String flag;
  final String currency;
  final String latitude;
  final String longitude;
  final List<TimezoneEntity> timezones;

  const CountryEntity({
    required this.isoCode,
    required this.name,
    required this.phoneCode,
    required this.flag,
    required this.currency,
    required this.latitude,
    required this.longitude,
    required this.timezones,
  });

  @override
  List<Object?> get props => [
        isoCode,
        name,
        phoneCode,
        flag,
        currency,
        latitude,
        longitude,
        timezones,
      ];
}

class TimezoneEntity extends Equatable {
  final String zoneName;
  final int gmtOffset;
  final String gmtOffsetName;
  final String abbreviation;
  final String tzName;

  const TimezoneEntity({
    required this.zoneName,
    required this.gmtOffset,
    required this.gmtOffsetName,
    required this.abbreviation,
    required this.tzName,
  });

  @override
  List<Object?> get props => [
        zoneName,
        gmtOffset,
        gmtOffsetName,
        abbreviation,
        tzName,
      ];
}