import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

import '../picture_options.dart';

class BodyPartOption extends PictureOption {
  final Gender? gender;
  final BodyPartType? bodyPart;
  final ViewAngle? viewAngle;

  const BodyPartOption({this.bodyPart, this.gender, this.viewAngle});
}

enum BodyPartType { hand, foot, head }
