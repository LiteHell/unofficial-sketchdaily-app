import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sketchdaily/enum_i18n.dart';
import 'package:sketchdaily/i18n/messages.dart';
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
        values: [
          ChoiceChipValueDescription(value: null, description: Messages.all),
          ...StructureType.values.map((i) =>
              ChoiceChipValueDescription(value: i, description: enumI18n(i))),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Messages.structureType),
        _structureTypeChips(),
      ],
    );
  }
}
