import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        values: const [
          ChoiceChipValueDescription(value: null, description: "All"),
          ChoiceChipValueDescription(
              value: VegetationType.flowers, description: "Flowers"),
          ChoiceChipValueDescription(
              value: VegetationType.plants, description: "Plants"),
        ]);
  }

  Widget _photoTypeChips() {
    return ChoiceChips<VegetationPhotoType>(
        value: options.photoType,
        onChanged: (newPhotoType) {
          onChanged(
              VegetationOption(photoType: newPhotoType, type: options.type));
        },
        values: const [
          ChoiceChipValueDescription(value: null, description: "All"),
          ChoiceChipValueDescription(
              value: VegetationPhotoType.closeup, description: "Closeup"),
          ChoiceChipValueDescription(
              value: VegetationPhotoType.full, description: "Full"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Vegetation type'),
        _typeChips(),
        const Text('Photo type'),
        _photoTypeChips(),
      ],
    );
  }
}
