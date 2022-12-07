enum VegetationType { flowers, plants }

enum VegetationPhotoType { closeup, full }

class VegetationOption {
  final VegetationType? type;
  final VegetationPhotoType? photoType;

  const VegetationOption({this.type, this.photoType});
}
