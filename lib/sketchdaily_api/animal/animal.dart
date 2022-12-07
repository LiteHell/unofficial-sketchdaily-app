import 'package:sketchdaily/sketchdaily_api/animal/animal_option.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
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

  static Future<Animal?> getAnimal(AnimalOption option,
      [List<String> excludeIds = const []]) async {
    Map<String, String> parameters = {};

    switch (option.category) {
      case AnimalCategory.living:
        parameters['Category'] = 'Living';
        break;
      case AnimalCategory.skeletonOrBones:
        parameters['Category'] = 'SkeletonOrBones';
        break;
      default:
        break;
    }

    switch (option.species) {
      case AnimalSpecies.bird:
        parameters['Species'] = 'Bird';
        break;
      case AnimalSpecies.fish:
        parameters['Species'] = 'Fish';
        break;
      case AnimalSpecies.reptileOrAmphibian:
        parameters['Species'] = 'ReptileOrAmphibian';
        break;
      case AnimalSpecies.bug:
        parameters['Species'] = 'Bug';
        break;
      case AnimalSpecies.mammal:
        parameters['Species'] = 'Mammal';
        break;
      default:
        break;
    }

    switch (option.viewAngle) {
      case ViewAngle.front:
        parameters['ViewAngle'] = 'Front';
        break;
      case ViewAngle.side:
        parameters['ViewAngle'] = 'Side';
        break;
      case ViewAngle.back:
        parameters['ViewAngle'] = 'Back';
        break;
      case ViewAngle.aboveOrBelow:
        parameters['ViewAngle'] = 'AboveOrBelow';
        break;
      default:
        break;
    }

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
