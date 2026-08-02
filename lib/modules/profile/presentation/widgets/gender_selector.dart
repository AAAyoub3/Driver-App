import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/modules/profile/presentation/widgets/gender_option.dart';
import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final String selected; // "male" | "female"
  final ValueChanged<String> onChanged;

  const GenderSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
     final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.gender,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        Row(
          children: [
            GenderOption(
              label: localizations.female,
              value: localizations.female,
              groupValue: selected,
              onChanged: onChanged,
            ),
            const SizedBox(width: 24),
            GenderOption(
              label: localizations.male,
              value: localizations.male,
              groupValue: selected,
              onChanged: onChanged,
            ),
          ],
        ),
      ],
    );
  }
}
