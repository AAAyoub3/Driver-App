import 'package:flowery/config/general_cubit/constants.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final VoidCallback onChangeTap;

  const PasswordField({required this.onChangeTap});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.password,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  AppConstants.pass_stars,
                  style: TextStyle(fontSize: 18, letterSpacing: 2),
                ),
              ),
              TextButton(
                onPressed: onChangeTap,
                child: Text(localizations.change),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
