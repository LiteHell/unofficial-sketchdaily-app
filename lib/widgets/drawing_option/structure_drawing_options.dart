import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure_option.dart';
import 'package:sketchdaily/widgets/buttons/choice_chips.dart';

class StructureDrawingOptions extends StatelessWidget {
  final StructureOption options;
  final void Function(StructureOption) onChanged;
  const StructureDrawingOptions(
      {super.key, required this.options, required this.onChanged});

  Widget _structureTypeChips() {
    return ChoiceChips<StructureType>(
        value: options.type,
        onChanged: (newStructureType) {
          onChanged(StructureOption(newStructureType));
        },
        values: const [
          ChoiceChipValueDescription(value: null, description: "All"),
          ChoiceChipValueDescription(
              value: StructureType.building, description: "Building"),
          ChoiceChipValueDescription(
              value: StructureType.house, description: "House"),
          ChoiceChipValueDescription(
              value: StructureType.other, description: "Other"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Type'),
        _structureTypeChips(),
      ],
    );
  }
}
