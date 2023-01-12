import 'package:json_annotation/json_annotation.dart';

import '../picture_options.dart';

part 'vegetation_option.g.dart';

enum VegetationType { flowers, plants }

enum VegetationPhotoType { closeup, full }

@JsonSerializable()
class VegetationOption extends PictureOption {
  final VegetationType? type;
  final VegetationPhotoType? photoType;

  const VegetationOption({this.type, this.photoType});

  factory VegetationOption.fromJson(Map<String, dynamic> json) =>
      _$VegetationOptionFromJson(json);

  Map<String, dynamic> toJson() => _$VegetationOptionToJson(this);
}
