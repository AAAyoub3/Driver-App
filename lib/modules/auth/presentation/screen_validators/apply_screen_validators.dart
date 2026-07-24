import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery/modules/auth/domain/entities/vehicle_entity.dart';
import 'package:image_picker/image_picker.dart';

abstract class ApplyScreenValidators {
  static String? validateTextFormField(String? value, String errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? validateCountry(CountryEntity? country, String errorMessage) {
    if (country == null) {
      return errorMessage;
    }
    return null;
  }

    static String? validateVehicle(VehicleEntity? vehicle, String errorMessage) {
    if (vehicle == null) {
      return errorMessage;
    }
    return null;
  }

    static String? validateFile(XFile? file, String errorMessage) {
    if (file == null) {
      return errorMessage;
    }
    return null;
  }

    static String? validateID(CountryEntity? country, String errorMessage) {
    if (country == null) {
      return errorMessage;
    }
    return null;
  }

  static String? validateEmail(
    String? email,
    String errorMessageRequired,
    String errorMessageInValid,
  ) {
    if (email == null || email.trim().isEmpty) {
      return errorMessageRequired;
    }
    if (!AppRegExp.isEmailValid(email)) {
      return errorMessageInValid;
    }
    return null;
  }

  static String? validatePhoneNumber(
    String? phone,
    String errorMessageRequired,
    String errorMessageInValid,
  ) {
    if (phone == null || phone.trim().isEmpty) {
      return errorMessageRequired;
    }
    if (!AppRegExp.isPhoneNumberValid(phone)) {
      return errorMessageInValid;
    }
    return null;
  }

  static String? validatePassword(
    String? password,
    String errorMessageRequired,
    String errorMessageInValid,
  ) {
    if (password == null || password.isEmpty) {
      return errorMessageRequired;
    }
    if (!AppRegExp.isPasswordValid(password)) {
      return errorMessageInValid;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String? password,
    String errorMessageRequired,
    String errorMessageMatch,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return errorMessageRequired;
    }
    if (confirmPassword != password) {
      return errorMessageMatch;
    }
    return null;
  }
}
