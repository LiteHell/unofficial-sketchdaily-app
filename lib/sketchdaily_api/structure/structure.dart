import 'package:sketchdaily/extensions/first_letter_upper_case_extension.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';

import '../request/api_get_request.dart';

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

  static Future<int> count(StrctureType? structureType,
      {bool recentImagesOnly = false}) async {
    Map<String, String> parameters = {};

    if (structureType != null) {
      parameters['StructureType'] = structureType.name.toFirstLetterUpperCase();
    }
    parameters['recentImagesOnly'] = recentImagesOnly ? 'true' : 'false';

    return await getSketchDailyApi('/api/Structures/Count', parameters) as int;
  }

  static Future<Structure?> getStructure(
      {StrctureType? type, List<String> excludeIds = const []}) async {
    Map<String, String> parameters = {};

    if (type != null) {
      parameters['StructureType'] = type.name.toFirstLetterUpperCase();
    }
    dynamic response = await postJsonSketchDailyApi(
        '/api/Structures/Next', excludeIds, parameters);

    if (response == null) {
      return null;
    }

    final photographer = Person.fromJsonObject(response['photographer']);

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
