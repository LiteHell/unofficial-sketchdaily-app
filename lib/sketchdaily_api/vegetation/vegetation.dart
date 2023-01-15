import 'package:sketchdaily/extensions/first_letter_upper_case_extension.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';

import '../request/api_get_request.dart';

class Vegetation extends SketchDailyImage<VegetationOption> {
  Vegetation._privateConstructor(
      {required super.filePath,
      required super.id,
      required super.uploadedAt,
      required super.uploader,
      required super.photographer,
      required super.classification});

  static Map<String, String> createParameters(VegetationOption option) {
    Map<String, String> parameters = {};

    if (option.type != null) {
      parameters['VegetationType'] = option.type!.name.toFirstLetterUpperCase();
    }
    if (option.photoType != null) {
      parameters['PhotoType'] = option.photoType!.name.toFirstLetterUpperCase();
    }

    return parameters;
  }

  static Future<int> count(VegetationOption option,
      {bool recentImagesOnly = false}) async {
    Map<String, String> parameters = createParameters(option);
    parameters['recentImagesOnly'] = recentImagesOnly ? 'true' : 'false';

    return await getSketchDailyApi('/api/Vegetation/Count', parameters) as int;
  }

  static Future<Vegetation?> getVegetation(
      [VegetationOption option = const VegetationOption(),
      List<String> excludeIds = const []]) async {
    Map<String, String> parameters = createParameters(option);

    final response = await postJsonSketchDailyApi(
        '/api/Vegetation/Next', excludeIds, parameters);

    if (response == null) return null;

    final photographer = Person.fromJsonObject(response['photographer']);
    final classification = VegetationOption(
        type: VegetationType.values.firstWhere((e) =>
            e.name.toLowerCase() ==
            response['classifications']['vegetationType']
                .toString()
                .toLowerCase()),
        photoType: VegetationPhotoType.values.firstWhere((e) =>
            e.name.toLowerCase() ==
            response['classifications']['photoType'].toString().toLowerCase()));

    return Vegetation._privateConstructor(
        classification: classification,
        filePath: response['file'],
        id: response['id'],
        uploadedAt: DateTime.parse(response['uploadDate']),
        uploader: response['uploadedBy'],
        photographer: photographer);
  }
}
