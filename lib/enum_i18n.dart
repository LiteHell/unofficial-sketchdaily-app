import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal_option.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part_option.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body_option.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure_option.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';
import 'package:sketchdaily/sketchdaily_api/view_angle.dart';

import 'sketchdaily_api/gender.dart';

String enumI18n(Enum? value, {valueWhenNull = ''}) {
  if (value == null) {
    return valueWhenNull;
  }
  if (value is AnimalSpecies) {
    switch (value) {
      case AnimalSpecies.bird:
        return Messages.bird;
      case AnimalSpecies.fish:
        return Messages.fish;
      case AnimalSpecies.reptileOrAmphibian:
        return Messages.reptileOrAmphibian;
      case AnimalSpecies.bug:
        return Messages.bug;
      case AnimalSpecies.mammal:
        return Messages.mammal;
    }
  } else if (value is AnimalCategory) {
    switch (value) {
      case AnimalCategory.living:
        return Messages.livingAnimal;
      case AnimalCategory.skeletonOrBones:
        return Messages.animalSkeletonOrBones;
    }
  } else if (value is BodyPartType) {
    switch (value) {
      case BodyPartType.hand:
        return Messages.hand;
      case BodyPartType.foot:
        return Messages.foot;
      case BodyPartType.head:
        return Messages.head;
    }
  } else if (value is PoseType) {
    switch (value) {
      case PoseType.action:
        return Messages.actionPose;
      case PoseType.stationary:
        return Messages.stationaryPose;
    }
  } else if (value is StructureType) {
    switch (value) {
      case StructureType.house:
        return Messages.house;
      case StructureType.building:
        return Messages.building;
      case StructureType.other:
        return Messages.other;
    }
  } else if (value is VegetationType) {
    switch (value) {
      case VegetationType.flowers:
        return Messages.flower;
      case VegetationType.plants:
        return Messages.plant;
    }
  } else if (value is VegetationPhotoType) {
    switch (value) {
      case VegetationPhotoType.closeup:
        return Messages.closeup;
      case VegetationPhotoType.full:
        return Messages.fullVegetationPhotoType;
    }
  } else if (value is ViewAngle) {
    switch (value) {
      case ViewAngle.front:
        return Messages.front;
      case ViewAngle.side:
        return Messages.side;
      case ViewAngle.back:
        return Messages.back;
      case ViewAngle.aboveOrBelow:
        return Messages.aboveOrBelow;
    }
  } else if (value is Gender) {
    switch (value) {
      case Gender.male:
        return Messages.male;
      case Gender.female:
        return Messages.female;
    }
  } else {
    throw Exception('i18n-unsupported enum');
  }
}
