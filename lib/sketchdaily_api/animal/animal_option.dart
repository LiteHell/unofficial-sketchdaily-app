import 'package:json_annotation/json_annotation.dart';
import 'package:sketchdaily/sketchdaily_api/picture_options.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

part 'animal_option.g.dart';

@JsonSerializable()
class AnimalOption extends PictureOption {
  final AnimalSpecies? species;
  final AnimalCategory? category;
  final ViewAngle? viewAngle;

  const AnimalOption({
    this.species,
    this.category,
    this.viewAngle,
  });

  factory AnimalOption.fromJson(Map<String, dynamic> json) =>
      _$AnimalOptionFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalOptionToJson(this);
}

enum AnimalSpecies { bird, fish, reptileOrAmphibian, bug, mammal }

enum AnimalCategory { living, skeletonOrBones }
