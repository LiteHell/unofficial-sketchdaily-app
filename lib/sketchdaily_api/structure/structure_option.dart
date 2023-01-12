import 'package:sketchdaily/sketchdaily_api/picture_options.dart';

class StructureOption extends PictureOption {
  final StructureType? type;

  const StructureOption(this.type);
}

enum StructureType { house, building, other }
