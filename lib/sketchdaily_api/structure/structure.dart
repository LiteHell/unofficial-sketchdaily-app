import 'package:sketchdaily/extensions/first_letter_upper_case_extension.dart';
import 'package:sketchdaily/sketchdaily_api/person.dart';
import 'package:sketchdaily/sketchdaily_api/request/api_post_request.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure_option.dart';

import '../request/api_get_request.dart';

class Structure extends SketchDailyImage<StructureOption> {
  Structure._privateConstructor(
      {required super.filePath,
      required super.photographer,
      required super.classification,
      required super.uploadedAt,
      required super.uploader,
      required super.id});

  static Future<int> count(StructureOption structureOption,
      {bool recentImagesOnly = false}) async {
    Map<String, String> parameters = {};

    StructureType? structureType = structureOption.type;
    if (structureType != null) {
      parameters['StructureType'] = structureType.name.toFirstLetterUpperCase();
    }
    parameters['recentImagesOnly'] = recentImagesOnly ? 'true' : 'false';

    return await getSketchDailyApi('/api/Structures/Count', parameters) as int;
  }

  static Future<Structure?> getStructure(
      [StructureOption option = const StructureOption(null),
      List<String> excludeIds = const []]) async {
    Map<String, String> parameters = {};

    if (option.type != null) {
      parameters['StructureType'] = option.type!.name.toFirstLetterUpperCase();
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
        classification: StructureOption(StructureType.values.firstWhere((i) =>
            i.name.toLowerCase() ==
            response['classifications']['structureType']
                .toString()
                .toLowerCase())),
        uploadedAt: DateTime.parse(response['uploadDate']),
        uploader: response['uploadedBy']);
  }
}
