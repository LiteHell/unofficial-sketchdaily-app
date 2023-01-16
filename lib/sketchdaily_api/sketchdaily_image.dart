import 'package:sketchdaily/sketchdaily_api/picture_options.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';

class SketchDailyImage<T extends PictureOption> {
  final String filePath;
  final String id;
  final DateTime uploadedAt;
  final String uploader;
  final Person? photographer;
  final String? termsOfUse;
  final Uri? sourceUri;
  final T classification;
  Uri get uri => Uri.http('reference.sketchdaily.net:4000', filePath);

  SketchDailyImage(
      {required this.filePath,
      required this.id,
      required this.uploadedAt,
      required this.uploader,
      required this.photographer,
      required this.classification,
      required this.termsOfUse,
      required this.sourceUri});
}
