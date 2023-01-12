import '../picture_options.dart';

enum VegetationType { flowers, plants }

enum VegetationPhotoType { closeup, full }

class VegetationOption extends PictureOption {
  final VegetationType? type;
  final VegetationPhotoType? photoType;

  const VegetationOption({this.type, this.photoType});
}
