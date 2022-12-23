import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

class FullBodyOption {
  final bool? nsfw;
  final bool? clothing;
  final Gender? gender;
  final PoseType? poseType;
  final ViewAngle? viewAngle;

  const FullBodyOption(
      {this.nsfw, this.clothing, this.gender, this.poseType, this.viewAngle})
      : assert(
            clothing == true ||
                nsfw == null ||
                (nsfw == true && clothing == false),
            'nsfw can be set only when clothing is true');
}

enum PoseType { action, stationary }
