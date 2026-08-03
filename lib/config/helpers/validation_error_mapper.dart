import 'package:flowery/config/helpers/validators.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';

extension ValidationErrorMapper on ValidationError {
  String toMessage(AppLocalizations l10n) => switch (this) {
        ValidationError.required => l10n.this_field_is_required,
        ValidationError.invalidName => l10n.name_is_not_valid,
        ValidationError.invalidEmail => l10n.email_is_not_valid,
        ValidationError.invalidPassword => l10n.password_is_not_valid,
        ValidationError.invalidConfirmPassword =>
          l10n.confirm_password_is_not_valid,
        ValidationError.passwordMismatch => l10n.passwords_do_not_match,
        ValidationError.invalidPhoneNumber => l10n.phone_number_is_not_valid,
      };
}
