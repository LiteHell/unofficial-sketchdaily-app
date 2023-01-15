import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';
import 'package:sketchdaily/widgets/buttons/choice_chips.dart';

class ViewAngleButton extends StatelessWidget {
  final ViewAngle? value;
  final void Function(ViewAngle?) onChanged;
  const ViewAngleButton(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ChoiceChips<ViewAngle>(
        value: value,
        onChanged: onChanged,
        values: const [
          ChoiceChipValueDescription<ViewAngle>(
              value: null, description: "All"),
          ChoiceChipValueDescription<ViewAngle>(
              value: ViewAngle.aboveOrBelow, description: "Above or below"),
          ChoiceChipValueDescription<ViewAngle>(
              value: ViewAngle.back, description: "Back"),
          ChoiceChipValueDescription<ViewAngle>(
              value: ViewAngle.front, description: "Front"),
          ChoiceChipValueDescription<ViewAngle>(
              value: ViewAngle.side, description: "Side")
        ]);
  }
}
