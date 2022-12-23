import 'package:sketchdaily/extensions/first_letter_upper_case_extension.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal_option.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_get_request.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

class Animal extends SketchDailyImage {
  final AnimalOption classification;
  @override
  Uri get uri => Uri.http('reference.sketchdaily.net:4000', filePath);

  Animal._privateConstructor(
      {required id,
      required filePath,
      required photographer,
      required uploadedAt,
      required uploader,
      required this.classification})
      : super(
            id: id,
            filePath: filePath,
            uploader: uploader,
            uploadedAt: uploadedAt,
            photographer: photographer);

  static AnimalOption createClassification(dynamic object) {
    return AnimalOption(
      species: AnimalSpecies.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['species'] as String).toLowerCase()),
      category: AnimalCategory.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['category'] as String).toLowerCase()),
      viewAngle: ViewAngle.values.firstWhere((element) =>
          element.name.toLowerCase() ==
          (object['viewAngle'] as String).toLowerCase()),
    );
  }

  static Map<String, String> createParameters(AnimalOption option) {
    Map<String, String> parameters = {};

    if (option.category != null) {
      parameters['Category'] = option.category!.name.toFirstLetterUpperCase();
    }
    if (option.species != null) {
      parameters['Species'] = option.species!.name.toFirstLetterUpperCase();
    }
    if (option.viewAngle != null) {
      parameters['ViewAngle'] = option.viewAngle!.name.toFirstLetterUpperCase();
    }

    return parameters;
  }

  static Future<int> count(AnimalOption option,
      {bool recentImagesOnly = false}) async {
    Map<String, String> parameters = createParameters(option);
    parameters['recentImagesOnly'] = recentImagesOnly ? 'true' : 'false';

    return await getSketchDailyApi('/api/Animals/Count', parameters) as int;
  }

  static Future<Animal?> getAnimal(AnimalOption option,
      [List<String> excludeIds = const []]) async {
    Map<String, String> parameters = createParameters(option);

    dynamic response = await postJsonSketchDailyApi(
        '/api/Animals/Next', excludeIds, parameters);

    if (response == null) {
      return null;
    }

    Person? photographer = Person.fromJsonObject(response['photographer']);

    return Animal._privateConstructor(
        photographer: photographer,
        uploader: response['uploadedBy'],
        uploadedAt: DateTime.parse(response['uploadDate']),
        filePath: response['file'],
        id: response['id'],
        classification: createClassification(response['classifications']));
  }
}
