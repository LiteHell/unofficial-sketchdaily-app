import 'package:sketchdaily/sketchdaily_api/animal/animal_option.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

class Animal {
  final String id;
  final String filePath;
  final Person photorgapher;
  final String uploader;
  final DateTime uploadedAt;
  final AnimalOption classification;
  Uri get uri => Uri.http('reference.sketchdaily.net:4000', filePath);

  Animal._privateConstructor(
      {required this.id,
      required this.filePath,
      required this.photorgapher,
      required this.uploadedAt,
      required this.uploader,
      required this.classification});

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

    Person photographer = Person(
        response['photographer']['name'], response['photographer']['webpage']);

    return Animal._privateConstructor(
        photorgapher: photographer,
        uploader: response['uploadedBy'],
        uploadedAt: DateTime.parse(response['uploadDate']),
        filePath: response['file'],
        id: response['id'],
        classification: createClassification(response['classifications']));
  }
}
