import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';

class Structure extends SketchDailyImage {
  final StrctureType structureType;

  Structure._privateConstructor(
      {required filePath,
      required photographer,
      required this.structureType,
      required uploadedAt,
      required uploader,
      required id})
      : super(
            filePath: filePath,
            photographer: photographer,
            uploadedAt: uploadedAt,
            uploader: uploader,
            id: id);

  static Future<Structure?> getStructure(
      {StrctureType? type, List<String> excludeIds = const []}) async {
    Map<String, String> parameters = {};

    if (type != null) {
      parameters['StructureType'] =
          type.name.toUpperCase().substring(0, 1) + type.name.substring(1);
    }
    dynamic response = await postJsonSketchDailyApi(
        '/api/Structures/Next', excludeIds, parameters);

    if (response == null) {
      return null;
    }

    final photographer = Person(
        response['photographer']['name'], response['photographer']['webpage']);

    return Structure._privateConstructor(
        id: response['id'],
        filePath: response['file'],
        photographer: photographer,
        structureType: StrctureType.values.firstWhere((i) =>
            i.name.toLowerCase() ==
            response['classifications']['structureType']
                .toString()
                .toLowerCase()),
        uploadedAt: DateTime.parse(response['uploadDate']),
        uploader: response['uploadedBy']);
  }
}

enum StrctureType { house, building, other }
