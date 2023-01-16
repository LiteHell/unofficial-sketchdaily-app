import 'package:sketchdaily/extensions/first_letter_upper_case_extension.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body_option.dart';
import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

import '../request/api_get_request.dart';

class FullBody extends SketchDailyImage<FullBodyOption> {
  final Person? model;
  @override
  Uri get uri => Uri.http('reference.sketchdaily.net:4000', filePath);

  FullBody._privateConstructor(
      {required super.id,
      required super.filePath,
      required super.photographer,
      required super.uploadedAt,
      required super.uploader,
      required this.model,
      required super.classification,
      required super.sourceUri,
      required super.termsOfUse});

  static FullBodyOption createClassification(dynamic object,
      {required bool? nsfw}) {
    return FullBodyOption(
      gender: Gender.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['gender'] as String).toLowerCase()),
      viewAngle: ViewAngle.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['viewAngle'] as String).toLowerCase()),
      poseType: PoseType.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['poseType'] as String).toLowerCase()),
      clothing: (object['clothing'] as bool),
      nsfw: nsfw /*(object['nsfw'] as bool)*/,
    );
  }

  static Map<String, String> createParameters(FullBodyOption option) {
    Map<String, String> parameters = {};

    if (option.gender != null) {
      parameters['Gender'] = option.gender!.name.toFirstLetterUpperCase();
    }
    if (option.nsfw != null) {
      parameters['NSFW'] = option.nsfw! ? 'true' : 'false';
    }
    if (option.poseType != null) {
      parameters['PoseType'] = option.poseType!.name.toFirstLetterUpperCase();
    }
    if (option.clothing != null) {
      parameters['Clothing'] = option.clothing! ? 'true' : 'false';
    }
    if (option.viewAngle != null) {
      parameters['ViewAngle'] = option.viewAngle!.name.toFirstLetterUpperCase();
    }

    return parameters;
  }

  static Future<int> count(FullBodyOption option,
      {bool recentImagesOnly = false}) async {
    Map<String, String> parameters = createParameters(option);
    parameters['recentImagesOnly'] = recentImagesOnly ? 'true' : 'false';

    return await getSketchDailyApi('/api/FullBodies/Count', parameters) as int;
  }

  static Future<FullBody?> getFullBody(
      [FullBodyOption option = const FullBodyOption(),
      List<String> excludeIds = const []]) async {
    Map<String, String> parameters = createParameters(option);

    dynamic response = await postJsonSketchDailyApi(
        '/api/FullBodies/Next', excludeIds, parameters);

    if (response == null) {
      return null;
    }

    Person? photographer = Person.fromJsonObject(response['photographer']);
    Person? model = Person.fromJsonObject(response['model']);

    return FullBody._privateConstructor(
        photographer: photographer,
        model: model,
        uploader: response['uploadedBy'],
        uploadedAt: DateTime.parse(response['uploadDate']),
        filePath: response['file'],
        id: response['id'],
        classification: createClassification(response['classifications'],
            nsfw: option.nsfw),
        sourceUri: response['sourceUrl'] != null
            ? (response['sourceUrl'] as String).isNotEmpty
                ? Uri.parse(response['sourceUrl'])
                : null
            : null,
        termsOfUse: response['termsOfUse']);
  }
}
