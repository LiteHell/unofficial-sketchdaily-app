import 'package:flutter/src/widgets/framework.dart';

import '../../sketchdaily_api/gender.dart';
import 'choice_chips.dart';

class GenderButton extends StatelessWidget {
  final Gender? value;
  final void Function(Gender? newValue) onChanged;
  const GenderButton({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ChoiceChips<Gender>(
        value: value,
        onChanged: onChanged,
        values: const [
          ChoiceChipValueDescription(value: null, description: 'All'),
          ChoiceChipValueDescription(value: Gender.male, description: 'Male'),
          ChoiceChipValueDescription(
              value: Gender.female, description: 'Female'),
        ]);
  }
}
