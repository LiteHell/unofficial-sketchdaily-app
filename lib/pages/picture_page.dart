import 'package:flutter/material.dart';
import 'package:sketchdaily/app_preferences.dart';
import 'package:sketchdaily/pages/picture_info.dart';
import 'package:sketchdaily/pages/report_image.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal_option.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part_option.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body_option.dart';
import 'package:sketchdaily/sketchdaily_api/report_image.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_image.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure_option.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';
import 'package:sketchdaily/widgets/picture_player.dart';

import '../sketchdaily_api/picture_options.dart';

class PicturePage extends StatefulWidget {
  final PictureOption options;
  final Duration duration;
  final bool infiniteDuration;
  const PicturePage(
      {super.key,
      required this.options,
      required this.duration,
      required this.infiniteDuration});

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  List<String> imageIds = [];
  SketchDailyImage? currentImage;
  bool displayTimeLeft = true, displayElapsedTimeOnInfinite = true;

  void onCurrentImageChange(SketchDailyImage image) {
    currentImage = image;
  }

  void readPreferences() async {
    displayTimeLeft = await AppPreferences.doDisplayRemainingTimeOnPlayer();
    displayElapsedTimeOnInfinite =
        await AppPreferences.doDisplayElapsedTimeOnInfiniteTime();
  }

  Future<SketchDailyImage?> getNextImage() async {
    SketchDailyImage? nextImage;
    if (widget.options is AnimalOption) {
      nextImage =
          await Animal.getAnimal(widget.options as AnimalOption, imageIds);
    } else if (widget.options is FullBodyOption) {
      nextImage = await FullBody.getFullBody(
          widget.options as FullBodyOption, imageIds);
    } else if (widget.options is BodyPartOption) {
      nextImage = await BodyPart.getBodyPart(
          widget.options as BodyPartOption, imageIds);
    } else if (widget.options is VegetationOption) {
      nextImage = await Vegetation.getVegetation(
          widget.options as VegetationOption, imageIds);
    } else if (widget.options is StructureOption) {
      nextImage = await Structure.getStructure(
          widget.options as StructureOption, imageIds);
    }

    if (nextImage != null) {
      setState(() {
        imageIds.add(nextImage!.id);
      });
    }

    return nextImage;
  }

  String getTitle() {
    if (widget.options is AnimalOption) {
      return "Animal";
    } else if (widget.options is FullBodyOption) {
      return "Full body";
    } else if (widget.options is BodyPartOption) {
      return "Body part";
    } else if (widget.options is VegetationOption) {
      return "Vegetation";
    } else if (widget.options is StructureOption) {
      return "Structure";
    }
    throw Exception('None of known AnimalOption child classes');
  }

  @override
  Widget build(BuildContext context) {
    readPreferences();

    return Scaffold(
        appBar: AppBar(
          title: Text(getTitle()),
          actions: [
            IconButton(
              onPressed: () {
                SketchDailyImage? image = currentImage;
                if (image == null) return;

                ImageType imageType;
                if (image.classification is FullBodyOption) {
                  imageType = ImageType.fullBody;
                } else if (image.classification is BodyPartOption) {
                  imageType = ImageType.bodyPart;
                } else if (image.classification is AnimalOption) {
                  imageType = ImageType.animal;
                } else if (image.classification is StructureOption) {
                  imageType = ImageType.structure;
                } else if (image.classification is VegetationOption) {
                  imageType = ImageType.vegetation;
                } else {
                  throw Exception('Unknown option subtype');
                }

                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => ReportImagePage(
                          imageId: image.id,
                          imageType: imageType,
                        ))));
              },
              icon: const Icon(Icons.report_problem_outlined),
              tooltip: 'Report problem',
            ),
            IconButton(
              onPressed: () {
                SketchDailyImage? image = currentImage;
                if (image == null) return;

                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => PictureInfo(image: image))));
              },
              icon: const Icon(Icons.info),
              tooltip: 'Image information',
            )
          ],
        ),
        body: PicturePlayer(
          imageDuration: widget.duration,
          getNextImage: getNextImage,
          infiniteDuration: widget.infiniteDuration,
          onCurrentImageChange: onCurrentImageChange,
          displayElapsedTimeOnInfinity: displayElapsedTimeOnInfinite,
          displayElapsedTime: !displayTimeLeft,
        ));
  }
}
