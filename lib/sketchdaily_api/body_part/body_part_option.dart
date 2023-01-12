import 'package:json_annotation/json_annotation.dart';
import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

import '../picture_options.dart';

part 'body_part_option.g.dart';

@JsonSerializable()
class BodyPartOption extends PictureOption {
  final Gender? gender;
  final BodyPartType? bodyPart;
  final ViewAngle? viewAngle;

  const BodyPartOption({this.bodyPart, this.gender, this.viewAngle});

  factory BodyPartOption.fromJson(Map<String, dynamic> json) =>
      _$BodyPartOptionFromJson(json);

  Map<String, dynamic> toJson() => _$BodyPartOptionToJson(this);
}

enum BodyPartType { hand, foot, head }
