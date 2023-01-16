import 'package:flutter/material.dart';
import 'package:sketchdaily/enum_i18n.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body_option.dart';
import 'package:sketchdaily/widgets/buttons/choice_chips.dart';
import 'package:sketchdaily/widgets/buttons/gender_button.dart';
import 'package:sketchdaily/widgets/buttons/view_angle_button.dart';

class FullBodyDrawingOptions extends StatelessWidget {
  final FullBodyOption options;
  final void Function(FullBodyOption) onChanged;
  const FullBodyDrawingOptions(
      {super.key, required this.options, required this.onChanged});

  Widget _poseTypeChips() {
    return ChoiceChips<PoseType>(
        value: options.poseType,
        onChanged: (newPoseType) {
          onChanged(FullBodyOption(
              clothing: options.clothing,
              gender: options.gender,
              nsfw: options.nsfw,
              poseType: newPoseType,
              viewAngle: options.viewAngle));
        },
        values: [
          ChoiceChipValueDescription(value: null, description: Messages.all),
          ...PoseType.values.map((i) =>
              ChoiceChipValueDescription(value: i, description: enumI18n(i))),
        ]);
  }

  Widget _genderChips() {
    return GenderButton(
        value: options.gender,
        onChanged: (newGender) {
          onChanged(FullBodyOption(
              clothing: options.clothing,
              gender: newGender,
              nsfw: options.nsfw,
              poseType: options.poseType,
              viewAngle: options.viewAngle));
        });
  }

  Widget _clothingChips() {
    return ChoiceChips<bool>(
        value: options.clothing,
        onChanged: (clothed) {
          onChanged(FullBodyOption(
              clothing: clothed,
              gender: options.gender,
              nsfw: options.nsfw,
              poseType: options.poseType,
              viewAngle: options.viewAngle));
        },
        values: [
          ChoiceChipValueDescription(value: null, description: Messages.all),
          ChoiceChipValueDescription(
              value: true, description: Messages.clothed),
          ChoiceChipValueDescription(value: false, description: Messages.nude),
        ]);
  }

  Widget _nsfwCheckbox() {
    return Row(
      children: [
        Checkbox(
            value: options.nsfw ?? false,
            onChanged: (bool? newNSFW) {
              onChanged(FullBodyOption(
                  clothing: true,
                  nsfw: newNSFW,
                  gender: options.gender,
                  poseType: options.poseType,
                  viewAngle: options.viewAngle));
            }),
        Text(Messages.includeNSFWImages)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showNSFWCheckbox = options.clothing == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Messages.clothingAndNSFW),
        _clothingChips(),
        if (showNSFWCheckbox) _nsfwCheckbox(),
        Text(Messages.gender),
        _genderChips(),
        Text(Messages.poseType),
        _poseTypeChips(),
        Text(Messages.viewAngle),
        ViewAngleButton(
            value: options.viewAngle,
            onChanged: (newViewAngle) {
              onChanged(FullBodyOption(
                  clothing: options.clothing,
                  gender: options.gender,
                  nsfw: options.nsfw,
                  poseType: options.poseType,
                  viewAngle: newViewAngle));
            })
      ],
    );
  }
}
