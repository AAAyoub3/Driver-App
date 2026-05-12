import 'regex.dart';


enum ValidationError {
  required,
  invalidName,
  invalidEmail,
  invalidPassword,
  invalidConfirmPassword,
  passwordMismatch,
  invalidPhoneNumber,
}

abstract class Validations {
  static ValidationError? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return ValidationError.required;
    }

    if (!AppRegExp.isNameValid(name)) {
      return ValidationError.invalidName;
    }

    return null;
  }

  static ValidationError? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return ValidationError.required;
    }

    if (!AppRegExp.isEmailValid(email)) {
      return ValidationError.invalidEmail;
    }

    return null;
  }

  static ValidationError? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return ValidationError.required;
    }

    if (!AppRegExp.isPasswordValid(password)) {
      return ValidationError.invalidPassword;
    }

    return null;
  }

  static ValidationError? validateConfirmPassword({
    required String? password,
    required String? confirmPassword,
  }) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return ValidationError.required;
    }

    if (!AppRegExp.isPasswordValid(confirmPassword)) {
      return ValidationError.invalidConfirmPassword;
    }

    if (password != confirmPassword) {
      return ValidationError.passwordMismatch;
    }

    return null;
  }

  static ValidationError? validatePhoneNumber(
    String? phoneNumber,
  ) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return ValidationError.required;
    }

    if (!AppRegExp.isPhoneNumberValid(phoneNumber)) {
      return ValidationError.invalidPhoneNumber;
    }

    return null;
  }

  static ValidationError? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationError.required;
    }

    return null;
  }
}