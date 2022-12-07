import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';

class SketchDailyImage {
  final String filePath;
  final String id;
  final DateTime uploadedAt;
  final String uploader;
  final Person? photographer;
  Uri get uri => Uri.http('reference.sketchdaily.net:4000', filePath);

  SketchDailyImage(
      {required this.filePath,
      required this.id,
      required this.uploadedAt,
      required this.uploader,
      required this.photographer});
}
