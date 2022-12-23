import 'package:sketchdaily/extensions/first_letter_upper_case_extension.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part_option.dart';
import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

class BodyPart extends SketchDailyImage {
  final BodyPartOption classification;
  final Person? model;
  @override
  Uri get uri => Uri.http('reference.sketchdaily.net:4000', filePath);

  BodyPart._privateConstructor(
      {required id,
      required filePath,
      required photographer,
      required uploadedAt,
      required uploader,
      required this.model,
      required this.classification})
      : super(
            id: id,
            filePath: filePath,
            uploader: uploader,
            uploadedAt: uploadedAt,
            photographer: photographer);

  static BodyPartOption createClassification(dynamic object) {
    return BodyPartOption(
      gender: Gender.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['gender'] as String).toLowerCase()),
      viewAngle: ViewAngle.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['viewAngle'] as String).toLowerCase()),
      bodyPart: BodyPartType.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['bodyPart'] as String).toLowerCase()),
    );
  }

  static Future<BodyPart?> getFullBody(
      [BodyPartOption option = const BodyPartOption(),
      List<String> excludeIds = const []]) async {
    Map<String, String> parameters = {};

    if (option.gender != null) {
      parameters['Gender'] = option.gender!.name.toFirstLetterUpperCase();
    }
    if (option.viewAngle != null) {
      parameters['ViewAngle'] = option.viewAngle!.name.toFirstLetterUpperCase();
    }
    if (option.bodyPart != null) {
      parameters['BodyPart'] = option.bodyPart!.name.toFirstLetterUpperCase();
    }

    dynamic response = await postJsonSketchDailyApi(
        '/api/BodyParts/Next', excludeIds, parameters);

    if (response == null) {
      return null;
    }

    Person? photographer = Person.fromJsonObject(response['photographer']);
    Person? model = Person.fromJsonObject(response['model']);

    return BodyPart._privateConstructor(
        photographer: photographer,
        model: model,
        uploader: response['uploadedBy'],
        uploadedAt: DateTime.parse(response['uploadDate']),
        filePath: response['file'],
        id: response['id'],
        classification: createClassification(response['classifications']));
  }
}
