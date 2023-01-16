import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sketchdaily/enum_i18n.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part_option.dart';
import 'package:sketchdaily/widgets/buttons/choice_chips.dart';
import 'package:sketchdaily/widgets/buttons/gender_button.dart';
import 'package:sketchdaily/widgets/buttons/view_angle_button.dart';

class BodyPartDrawingOptions extends StatelessWidget {
  final BodyPartOption options;
  final void Function(BodyPartOption) onChanged;
  const BodyPartDrawingOptions(
      {super.key, required this.options, required this.onChanged});

  Widget _bodyPartChips() {
    return ChoiceChips<BodyPartType>(
        value: options.bodyPart,
        onChanged: (newBodyPartType) {
          onChanged(BodyPartOption(
              bodyPart: newBodyPartType,
              gender: options.gender,
              viewAngle: options.viewAngle));
        },
        values: [
          ChoiceChipValueDescription(value: null, description: Messages.all),
          ...BodyPartType.values.map((i) =>
              ChoiceChipValueDescription(value: i, description: enumI18n(i))),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Messages.bodyPart),
        _bodyPartChips(),
        Text(Messages.gender),
        GenderButton(
            value: options.gender,
            onChanged: (newGender) {
              onChanged(BodyPartOption(
                  bodyPart: options.bodyPart,
                  gender: newGender,
                  viewAngle: options.viewAngle));
            }),
        Text(Messages.viewAngle),
        ViewAngleButton(
            value: options.viewAngle,
            onChanged: (newViewAngle) {
              onChanged(BodyPartOption(
                  bodyPart: options.bodyPart,
                  gender: options.gender,
                  viewAngle: newViewAngle));
            })
      ],
    );
  }
}
