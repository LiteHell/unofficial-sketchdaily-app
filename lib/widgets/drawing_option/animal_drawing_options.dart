import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        items: const [
          DropdownMenuItem(value: null, child: Text('All')),
          DropdownMenuItem(
            value: AnimalSpecies.bird,
            child: Text('Bird'),
          ),
          DropdownMenuItem(
            value: AnimalSpecies.bug,
            child: Text('Bug'),
          ),
          DropdownMenuItem(
            value: AnimalSpecies.fish,
            child: Text('Fish'),
          ),
          DropdownMenuItem(
            value: AnimalSpecies.mammal,
            child: Text('Mammal'),
          ),
          DropdownMenuItem(
            value: AnimalSpecies.reptileOrAmphibian,
            child: Text('Reptile or Amphibian'),
          )
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
        values: const [
          ChoiceChipValueDescription<AnimalCategory>(
              value: null, description: 'All'),
          ChoiceChipValueDescription<AnimalCategory>(
              value: AnimalCategory.living, description: 'Living'),
          ChoiceChipValueDescription<AnimalCategory>(
              value: AnimalCategory.skeletonOrBones, description: 'Dead'),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Species'),
        _animalSpeicesDropdown(),
        const Text('Category'),
        _animalCategoryChips(),
        const Text('View Angle'),
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
