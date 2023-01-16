import 'package:flutter/material.dart';
import 'package:sketchdaily/i18n/messages.dart';

import '../../sketchdaily_api/gender.dart';
import 'choice_chips.dart';

class GenderButton extends StatelessWidget {
  final Gender? value;
  final void Function(Gender? newValue) onChanged;
  const GenderButton({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ChoiceChips<Gender>(value: value, onChanged: onChanged, values: [
      ChoiceChipValueDescription(value: null, description: Messages.all),
      ChoiceChipValueDescription(
          value: Gender.male, description: Messages.male),
      ChoiceChipValueDescription(
          value: Gender.female, description: Messages.female),
    ]);
  }
}
