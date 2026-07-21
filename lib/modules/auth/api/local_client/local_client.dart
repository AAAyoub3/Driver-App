import 'dart:convert';
import 'package:flowery/config/api/app_endpoints.dart';
import 'package:flowery/modules/auth/data/models/country_model.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocalClient {
  static const String countriesFile = AppEndPoints.countries;

  Future<List<CountryModel>> getCountries() async {
    final String jsonString = await rootBundle.loadString(countriesFile);
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

    return jsonList
        .map((item) => CountryModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
