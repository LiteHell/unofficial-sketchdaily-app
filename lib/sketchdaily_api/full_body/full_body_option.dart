import 'package:json_annotation/json_annotation.dart';
import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

import '../picture_options.dart';

part 'full_body_option.g.dart';

@JsonSerializable()
class FullBodyOption extends PictureOption {
  final bool? nsfw;
  final bool? clothing;
  final Gender? gender;
  final PoseType? poseType;
  final ViewAngle? viewAngle;

  const FullBodyOption(
      {this.nsfw, this.clothing, this.gender, this.poseType, this.viewAngle});

  factory FullBodyOption.fromJson(Map<String, dynamic> json) =>
      _$FullBodyOptionFromJson(json);

  Map<String, dynamic> toJson() => _$FullBodyOptionToJson(this);
}

enum PoseType { action, stationary }
