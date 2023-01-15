import 'package:flutter/material.dart';
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
        values: const [
          ChoiceChipValueDescription(value: null, description: 'All'),
          ChoiceChipValueDescription(
              value: PoseType.action, description: 'Action'),
          ChoiceChipValueDescription(
              value: PoseType.stationary, description: 'Stationary'),
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
        values: const [
          ChoiceChipValueDescription(value: null, description: 'All'),
          ChoiceChipValueDescription(value: true, description: 'Clothed'),
          ChoiceChipValueDescription(value: false, description: 'Nude'),
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
        const Text('Include NSWF images')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showNSFWCheckbox = options.clothing == true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Clothing and NSFW'),
        _clothingChips(),
        if (showNSFWCheckbox) _nsfwCheckbox(),
        const Text('Gender'),
        _genderChips(),
        const Text('Pose type'),
        _poseTypeChips(),
        const Text('ViewAngle'),
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
