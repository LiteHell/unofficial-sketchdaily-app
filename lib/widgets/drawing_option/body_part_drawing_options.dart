import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        values: const [
          ChoiceChipValueDescription(value: null, description: "All"),
          ChoiceChipValueDescription(
              value: BodyPartType.foot, description: "Foot"),
          ChoiceChipValueDescription(
              value: BodyPartType.head, description: "Head"),
          ChoiceChipValueDescription(
              value: BodyPartType.hand, description: "Hand")
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Body Part'),
        _bodyPartChips(),
        const Text('Gender'),
        GenderButton(
            value: options.gender,
            onChanged: (newGender) {
              onChanged(BodyPartOption(
                  bodyPart: options.bodyPart,
                  gender: newGender,
                  viewAngle: options.viewAngle));
            }),
        const Text('View Angle'),
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
