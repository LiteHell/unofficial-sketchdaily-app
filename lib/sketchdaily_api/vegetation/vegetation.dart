import 'package:sketchdaily/extensions/first_letter_upper_case_extension.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';

class Vegetation extends SketchDailyImage {
  final VegetationOption classification;

  Vegetation._privateConstructor(
      {required super.filePath,
      required super.id,
      required super.uploadedAt,
      required super.uploader,
      required super.photographer,
      required this.classification});

  static Future<Vegetation?> getVegetation(
      [VegetationOption option = const VegetationOption(),
      List<String> excludeIds = const []]) async {
    Map<String, String> parameters = {};
    if (option.type != null) {
      parameters['VegetationType'] = option.type!.name.toFirstLetterUpperCase();
    }
    if (option.photoType != null) {
      parameters['PhotoType'] = option.photoType!.name.toFirstLetterUpperCase();
    }
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
