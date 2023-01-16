import 'package:flutter/material.dart';
import 'package:sketchdaily/enum_i18n.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';
import 'package:sketchdaily/widgets/buttons/choice_chips.dart';
import 'package:sketchdaily/widgets/buttons/view_angle_button.dart';

class AnimalDrawingOptions extends StatelessWidget {
  final AnimalOption options;
  final void Function(AnimalOption) onChanged;
  const AnimalDrawingOptions(
      {super.key, required this.options, required this.onChanged});

  Widget _animalSpeicesDropdown() {
    return DropdownButton<AnimalSpecies?>(
        items: [
          DropdownMenuItem(value: null, child: Text(Messages.all)),
          ...AnimalSpecies.values.map((e) => DropdownMenuItem(
                value: e,
                child: Text(enumI18n(e)),
              )),
        ],
        value: options.species,
        onChanged: (newSpecies) {
          onChanged(AnimalOption(
              category: options.category,
              species: newSpecies,
              viewAngle: options.viewAngle));
        });
  }

  Widget _animalCategoryChips() {
    return ChoiceChips<AnimalCategory>(
        value: options.category,
        onChanged: (category) {
          if (options.category != category) {
            onChanged(AnimalOption(
                category: category,
                species: options.species,
                viewAngle: options.viewAngle));
          }
        },
        values: <ChoiceChipValueDescription<AnimalCategory>>[
          ChoiceChipValueDescription(value: null, description: Messages.all),
          ...AnimalCategory.values.map((e) =>
              ChoiceChipValueDescription(value: e, description: enumI18n(e))),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Messages.animalSpecies),
        _animalSpeicesDropdown(),
        Text(Messages.animalCategory),
        _animalCategoryChips(),
        Text(Messages.viewAngle),
        ViewAngleButton(
            value: options.viewAngle,
            onChanged: (newViewAngle) {
              onChanged(AnimalOption(
                  category: options.category,
                  species: options.species,
                  viewAngle: newViewAngle));
            })
      ],
    );
  }
}
