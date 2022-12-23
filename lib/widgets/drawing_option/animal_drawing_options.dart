import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';
import 'package:sketchdaily/widgets/drawing_option/view_angle_button.dart';

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

  void Function() _setCategoryClosure(AnimalCategory? category) {
    return () {
      onChanged(AnimalOption(
          category: category,
          species: options.species,
          viewAngle: options.viewAngle));
    };
  }

  void Function()? _animalCategoryOnPressedClosure(AnimalCategory? option) {
    if (options.category == option) {
      return null;
    }
    return _setCategoryClosure(option);
  }

  Widget _animalCategoryButtons() {
    return Row(
      children: [
        ElevatedButton(
            onPressed: _animalCategoryOnPressedClosure(null),
            child: const Text('All')),
        const SizedBox(width: 5),
        ElevatedButton(
            onPressed: _animalCategoryOnPressedClosure(AnimalCategory.living),
            child: const Text('Living')),
        const SizedBox(width: 5),
        ElevatedButton(
            onPressed:
                _animalCategoryOnPressedClosure(AnimalCategory.skeletonOrBones),
            child: const Text('Dead'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Species'),
        _animalSpeicesDropdown(),
        const Text('Category'),
        _animalCategoryButtons(),
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
