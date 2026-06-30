import 'package:flowery/config/helpers/regex.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';

class ChangePasswordValidator {

  static String? validateCurrentPassword(
    String? value,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) {
      return l10n.enter_current_password;
    }

    if (!AppRegExp.isPasswordValid(value)) {
      return l10n.password_is_not_valid;
    }

    return null;
  }

  static String? validateNewPassword(
    String? value,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) {
      return l10n.enter_new_password;
    }

    if (!AppRegExp.isPasswordValid(value)) {
      return l10n.password_is_not_valid;
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String newPassword,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) {
      return l10n.enter_confirm_password;
    }

    if (value != newPassword) {
      return l10n.password_and_confirm_password_must_be_same;
    }

    return null;
  }

}