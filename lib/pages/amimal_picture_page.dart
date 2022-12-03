import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal_option.dart';
import 'package:sketchdaily/sketchdaily_api/image_uri_suppliable.dart';
import 'package:sketchdaily/widgets/picture_player.dart';

class AnimalPicturePage extends StatefulWidget {
  final AnimalOption options;
  final Duration duration;
  final bool infiniteDuration;
  const AnimalPicturePage(
      {super.key,
      required this.options,
      required this.duration,
      required this.infiniteDuration});

  @override
  State<AnimalPicturePage> createState() => _AnimalPicturePageState();
}

class _AnimalPicturePageState extends State<AnimalPicturePage> {
  List<String> imageIds = [];

  Future<ImageUriSuppliable?> getNextImage() async {
    final animal = await Animal.getAnimal(widget.options, imageIds);

    if (animal != null) {
      setState(() {
        imageIds.add(animal.id);
      });
    }

    return animal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Animal')),
        body: PicturePlayer(
          imageDuration: widget.duration,
          getNextImage: getNextImage,
          infiniteDuration: widget.infiniteDuration,
        ));
  }
}
