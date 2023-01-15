import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sketchdaily/extensions/whitespace_first_letter_upper_case_extension.dart';
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
        "Category": option.category?.name.toWhitespaceFirstLetterUpperCase() ??
            'Unknown',
        "Species": option.species?.name.toWhitespaceFirstLetterUpperCase() ??
            'Unknown',
        "View angle":
            option.viewAngle?.name.toWhitespaceFirstLetterUpperCase() ??
                'Unknown',
      };
    } else if (image is FullBody) {
      FullBodyOption option = (image as FullBody).classification;
      return {
        "Clothing": option.clothing == null
            ? 'Unknown'
            : option.clothing!
                ? 'Clothed'
                : 'Nude',
        "NSFW": option.nsfw == null
            ? 'Unknown'
            : option.nsfw!
                ? 'Yes'
                : 'No',
        "Pose type": option.poseType?.name.toWhitespaceFirstLetterUpperCase() ??
            'Unknown',
        "Gender":
            option.gender?.name.toWhitespaceFirstLetterUpperCase() ?? 'Unknown',
        "View angle":
            option.viewAngle?.name.toWhitespaceFirstLetterUpperCase() ??
                'Unknown',
      };
    } else if (image is BodyPart) {
      BodyPartOption option = (image as BodyPart).classification;
      return {
        "Body part": option.bodyPart?.name.toWhitespaceFirstLetterUpperCase() ??
            'Unknown',
        "Gender":
            option.gender?.name.toWhitespaceFirstLetterUpperCase() ?? 'Unknown',
        "View angle":
            option.viewAngle?.name.toWhitespaceFirstLetterUpperCase() ??
                'Unknown',
      };
    } else if (image is Vegetation) {
      VegetationOption option = (image as Vegetation).classification;
      return {
        "Type":
            option.type?.name.toWhitespaceFirstLetterUpperCase() ?? 'Unknown',
        "Photo type":
            option.photoType?.name.toWhitespaceFirstLetterUpperCase() ??
                'Unknown',
      };
    } else if (image is Structure) {
      final type = (image as Structure).classification.type;

      return {
        "Structure type":
            type?.name.toWhitespaceFirstLetterUpperCase() ?? 'Unknown'
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
    return _mapDataToSettingsMenuItem(
        {"Name": person.name, "Webpage": person.webpage});
  }

  Widget _header(String text) {
    return ListTile(
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      _header('Image classification'),
      ..._mapDataToSettingsMenuItem(_getClassificationInfo()),
      _header('Image id and upload information'),
      ..._mapDataToSettingsMenuItem({
        "Image id": image.id,
        "Uploaded by": image.uploader,
        "Uploaded at": image.uploadedAt.toString(),
      })
    ];

    if (image.photographer != null) {
      items.add(_header('Photographer'));
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
        items.addAll([_header('Model'), ..._personToSettingsMenuItem(model)]);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Information')),
      body: _listItemsToListView(items.toList()),
    );
  }
}
