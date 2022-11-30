import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

class AnimalOption {
  final AnimalSpecies? species;
  final AnimalCategory? category;
  final ViewAngle? viewAngle;

  AnimalOption({
    this.species,
    this.category,
    this.viewAngle,
  });
}

enum AnimalSpecies { bird, fish, reptileOrAmphibian, bug, mammal }

enum AnimalCategory { living, skeletonOrBones }
