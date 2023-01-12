import 'package:json_annotation/json_annotation.dart';
import 'package:sketchdaily/sketchdaily_api/picture_options.dart';

part 'structure_option.g.dart';

@JsonSerializable()
class StructureOption extends PictureOption {
  final StructureType? type;

  const StructureOption(this.type);

  factory StructureOption.fromJson(Map<String, dynamic> json) =>
      _$StructureOptionFromJson(json);

  Map<String, dynamic> toJson() => _$StructureOptionToJson(this);
}

enum StructureType { house, building, other }
