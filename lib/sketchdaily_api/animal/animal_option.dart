import 'package:sketchdaily/sketchdaily_api/picture_options.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

class AnimalOption extends PictureOption {
  final AnimalSpecies? species;
  final AnimalCategory? category;
  final ViewAngle? viewAngle;

  const AnimalOption({
    this.species,
    this.category,
    this.viewAngle,
  });
}

enum AnimalSpecies { bird, fish, reptileOrAmphibian, bug, mammal }

enum AnimalCategory { living, skeletonOrBones }
