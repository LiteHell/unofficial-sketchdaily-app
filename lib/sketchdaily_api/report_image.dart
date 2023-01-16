import 'package:sketchdaily/extensions/first_letter_upper_case_extension.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';

enum ImageReportType {
  inappropriate,
  wrongClassifications,
  copyrightViolation,
  lowQuality,
  other
}

enum ImageType { fullBody, bodyPart, animal, structure, vegetation }

String _getImageCategoryString(ImageType type) {
  switch (type) {
    case ImageType.fullBody:
      return "FullBodies";
    case ImageType.bodyPart:
      return "BodyParts";
    case ImageType.animal:
      return "Animals";
    case ImageType.structure:
      return "Structures";
    case ImageType.vegetation:
      return "Vegetation";
  }
}

Future<void> ReportImage(String imageId,
    {required ImageReportType reportType,
    required String comment,
    required ImageType type}) async {
  await postJsonSketchDailyApi('/api/Images/$imageId/Report', {
    "imageId": imageId,
    "comment": comment,
    "user": {
      "isAdmin": false,
      "name": "Unofficial SketchDaily application",
      "email": "example@example.com"
    },
    "reportType": reportType.name.toFirstLetterUpperCase(),
    "referenceTyoe": _getImageCategoryString(type),
    "date": DateTime.now().toIso8601String()
  });
}
