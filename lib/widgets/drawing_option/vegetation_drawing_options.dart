import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sketchdaily/enum_i18n.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';
import 'package:sketchdaily/widgets/buttons/choice_chips.dart';

class VegetationDrawingOptions extends StatelessWidget {
  final VegetationOption options;
  final void Function(VegetationOption) onChanged;
  const VegetationDrawingOptions(
      {super.key, required this.options, required this.onChanged});

  Widget _typeChips() {
    return ChoiceChips(
        value: options.type,
        onChanged: (newType) {
          onChanged(
              VegetationOption(photoType: options.photoType, type: newType));
        },
        values: [
          ChoiceChipValueDescription(value: null, description: Messages.all),
          ...VegetationType.values.map((i) =>
              ChoiceChipValueDescription(value: i, description: enumI18n(i)))
        ]);
  }

  Widget _photoTypeChips() {
    return ChoiceChips<VegetationPhotoType>(
        value: options.photoType,
        onChanged: (newPhotoType) {
          onChanged(
              VegetationOption(photoType: newPhotoType, type: options.type));
        },
        values: [
          ChoiceChipValueDescription(value: null, description: Messages.all),
          ...VegetationPhotoType.values.map((i) =>
              ChoiceChipValueDescription(value: i, description: enumI18n(i))),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Messages.vegetationType),
        _typeChips(),
        Text(Messages.vegetationPhotoType),
        _photoTypeChips(),
      ],
    );
  }
}
