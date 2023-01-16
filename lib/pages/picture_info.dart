import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sketchdaily/enum_i18n.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body_option.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';

import '../sketchdaily_api/body_part/body_part_option.dart';
import '../sketchdaily_api/full_body/full_body.dart';

class PictureInfo extends StatelessWidget {
  final SketchDailyImage image;
  const PictureInfo({super.key, required this.image});

  Map<String, String> _getClassificationInfo() {
    if (image is Animal) {
      AnimalOption option = (image as Animal).classification;
      return {
        Messages.animalCategory:
            enumI18n(option.category, valueWhenNull: Messages.unknown),
        Messages.animalSpecies:
            enumI18n(option.species, valueWhenNull: Messages.unknown),
        Messages.viewAngle:
            enumI18n(option.viewAngle, valueWhenNull: Messages.unknown),
      };
    } else if (image is FullBody) {
      FullBodyOption option = (image as FullBody).classification;
      return {
        Messages.clothing: option.clothing == null
            ? Messages.unknown
            : option.clothing!
                ? Messages.clothed
                : Messages.nude,
        Messages.poseType: option.nsfw == null
            ? Messages.unknown
            : option.nsfw!
                ? Messages.yes
                : Messages.no,
        Messages.poseType:
            enumI18n(option.poseType, valueWhenNull: Messages.unknown),
        Messages.gender:
            enumI18n(option.gender, valueWhenNull: Messages.unknown),
        Messages.viewAngle:
            enumI18n(option.viewAngle, valueWhenNull: Messages.unknown),
      };
    } else if (image is BodyPart) {
      BodyPartOption option = (image as BodyPart).classification;
      return {
        Messages.bodyPart:
            enumI18n(option.bodyPart, valueWhenNull: Messages.unknown),
        Messages.gender:
            enumI18n(option.gender, valueWhenNull: Messages.unknown),
        Messages.viewAngle:
            enumI18n(option.viewAngle, valueWhenNull: Messages.unknown),
      };
    } else if (image is Vegetation) {
      VegetationOption option = (image as Vegetation).classification;
      return {
        Messages.vegetationType:
            enumI18n(option.type, valueWhenNull: Messages.unknown),
        Messages.vegetationPhotoType:
            enumI18n(option.photoType, valueWhenNull: Messages.unknown),
      };
    } else if (image is Structure) {
      final type = (image as Structure).classification.type;

      return {
        Messages.structureType: enumI18n(type, valueWhenNull: Messages.unknown),
      };
    }

    throw Exception('Unknown PictureOption');
  }

  Iterable<Widget> _mapDataToSettingsMenuItem(Map<String, String> data) {
    return data.entries.map((i) => ListTile(
          title: Text(i.key),
          subtitle: Text(i.value),
          onTap: () {
            Clipboard.setData(ClipboardData(text: '${i.key}: ${i.value}'));
          },
        ));
  }

  Widget _listItemsToListView(List<Widget> items) {
    return ListView.separated(
        itemBuilder: ((context, index) => items[index]),
        separatorBuilder: ((context, index) => const Divider()),
        itemCount: items.length);
  }

  Iterable<Widget> _personToSettingsMenuItem(Person person) {
    return _mapDataToSettingsMenuItem({
      Messages.personName: person.name,
      Messages.personWebpage: person.webpage
    });
  }

  Widget _header(String text) {
    return ListTile(
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      _header(Messages.imageClassification),
      ..._mapDataToSettingsMenuItem(_getClassificationInfo()),
      _header(Messages.imageIdAndUploadInformation),
      ..._mapDataToSettingsMenuItem({
        Messages.imageId: image.id,
        Messages.uploadedBy: image.uploader,
        Messages.uploadedAt: image.uploadedAt.toString(),
        Messages.termsOfUse: image.termsOfUse ?? Messages.empty,
        Messages.imageSourceUrl: image.sourceUri?.toString() ?? Messages.empty
      })
    ];

    if (image.photographer != null) {
      items.add(_header(Messages.photographer));
      items.addAll(_personToSettingsMenuItem(image.photographer!));
    }

    if (image is FullBody || image is BodyPart) {
      Person? model;
      if (image is FullBody) {
        model = (image as FullBody).model;
      } else if (image is BodyPart) {
        model = (image as BodyPart).model;
      }

      if (model != null) {
        items.addAll(
            [_header(Messages.model), ..._personToSettingsMenuItem(model)]);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(Messages.pictureInformation)),
      body: _listItemsToListView(items.toList()),
    );
  }
}
