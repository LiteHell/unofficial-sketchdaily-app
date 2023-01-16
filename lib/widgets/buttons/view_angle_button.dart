import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';
import 'package:sketchdaily/widgets/buttons/choice_chips.dart';

class ViewAngleButton extends StatelessWidget {
  final ViewAngle? value;
  final void Function(ViewAngle?) onChanged;
  const ViewAngleButton(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ChoiceChips<ViewAngle>(value: value, onChanged: onChanged, values: [
      ChoiceChipValueDescription<ViewAngle>(
          value: null, description: Messages.all),
      ChoiceChipValueDescription<ViewAngle>(
          value: ViewAngle.aboveOrBelow, description: Messages.aboveOrBelow),
      ChoiceChipValueDescription<ViewAngle>(
          value: ViewAngle.back, description: Messages.back),
      ChoiceChipValueDescription<ViewAngle>(
          value: ViewAngle.front, description: Messages.front),
      ChoiceChipValueDescription<ViewAngle>(
          value: ViewAngle.side, description: Messages.side)
    ]);
  }
}
