import 'package:json_annotation/json_annotation.dart';

import 'sketchdaily_api/body_part/body_part_option.dart';
import 'sketchdaily_api/full_body/full_body_option.dart';
import 'sketchdaily_api/sketchdaily_api.dart';
import 'sketchdaily_api/structure/structure_option.dart';
import 'sketchdaily_api/vegetation/vegetation_option.dart';

part 'option_container.g.dart';

@JsonSerializable()
class OptionContainer {
  AnimalOption animal;
  FullBodyOption fullBody;
  VegetationOption vegetation;
  StructureOption structure;
  BodyPartOption bodyPart;

  OptionContainer(
      {this.animal =
          const AnimalOption(species: null, category: null, viewAngle: null),
      this.fullBody = const FullBodyOption(
          nsfw: null,
          clothing: true,
          gender: null,
          poseType: null,
          viewAngle: null),
      this.bodyPart =
          const BodyPartOption(bodyPart: null, gender: null, viewAngle: null),
      this.vegetation = const VegetationOption(photoType: null, type: null),
      this.structure = const StructureOption(null)});

  factory OptionContainer.fromJson(Map<String, dynamic> json) =>
      _$OptionContainerFromJson(json);

  Map<String, dynamic> toJson() => _$OptionContainerToJson(this);
}
