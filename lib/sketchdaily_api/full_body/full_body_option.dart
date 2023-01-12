import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

import '../picture_options.dart';

class FullBodyOption extends PictureOption {
  final bool? nsfw;
  final bool? clothing;
  final Gender? gender;
  final PoseType? poseType;
  final ViewAngle? viewAngle;

  const FullBodyOption(
      {this.nsfw, this.clothing, this.gender, this.poseType, this.viewAngle});
}

enum PoseType { action, stationary }
