import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sketchdaily/pages/picture_page.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal_option.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part_option.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body_option.dart';
import 'package:sketchdaily/sketchdaily_api/picture_options.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure_option.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';
import 'package:sketchdaily/widgets/drawing_option/animal_drawing_options.dart';

import '../widgets/drawing_option/body_part_drawing_options.dart';
import '../widgets/drawing_option/full_body_drawing_options.dart';
import '../widgets/drawing_option/structure_drawing_options.dart';
import '../widgets/drawing_option/vegetation_drawing_options.dart';

class OptionContainer {
  AnimalOption animal =
      const AnimalOption(species: null, category: null, viewAngle: null);
  FullBodyOption fullBody = const FullBodyOption(
      nsfw: null,
      clothing: true,
      gender: null,
      poseType: null,
      viewAngle: null);
  BodyPartOption bodyPart =
      const BodyPartOption(bodyPart: null, gender: null, viewAngle: null);
  VegetationOption vegetation =
      const VegetationOption(photoType: null, type: null);
  StructureOption structure = const StructureOption(null);
}

class DrawingOptions extends StatefulWidget {
  const DrawingOptions({super.key});

  @override
  State<DrawingOptions> createState() => _DrawingOptionsState();
}

class _DrawingOptionsState extends State<DrawingOptions> {
  final OptionContainer options = OptionContainer();
  bool _infiniteTime = false;
  final TextEditingController _controller = TextEditingController(text: '5');

  void startDrawing(PictureOption options) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PicturePage(
              options: options,
              duration: Duration(seconds: int.parse(_controller.text)),
              infiniteDuration: _infiniteTime,
            )));
  }

  Widget createOptionsTabPage({
    required Widget optionsWidget,
    required void Function() onStartPreseed,
  }) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              optionsWidget,
              const Text('Time (in seconds)'),
              TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  enabled: !_infiniteTime,
                  maxLines: 1),
              Row(children: [
                Checkbox(
                    value: _infiniteTime,
                    onChanged: (e) {
                      if (e != null) {
                        setState(() {
                          _infiniteTime = e;
                        });
                      }
                    }),
                const Text('Infinite time'),
              ]),
              Center(
                  child: ElevatedButton.icon(
                      onPressed: onStartPreseed,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start')))
            ])));
  }

  Widget animalOptions() {
    return createOptionsTabPage(
        optionsWidget: AnimalDrawingOptions(
          options: options.animal,
          onChanged: (e) {
            setState(() {
              options.animal = e;
            });
          },
        ),
        onStartPreseed: () {
          startDrawing(options.animal);
        });
  }

  Widget fullBodyOptions() {
    return createOptionsTabPage(
        optionsWidget: FullBodyDrawingOptions(
          options: options.fullBody,
          onChanged: (e) {
            setState(() {
              options.fullBody = e;
            });
          },
        ),
        onStartPreseed: () {
          startDrawing(options.fullBody);
        });
  }

  Widget bodyPartOptions() {
    return createOptionsTabPage(
        optionsWidget: BodyPartDrawingOptions(
          options: options.bodyPart,
          onChanged: (e) {
            setState(() {
              options.bodyPart = e;
            });
          },
        ),
        onStartPreseed: () {
          startDrawing(options.bodyPart);
        });
  }

  Widget vegetationOptions() {
    return createOptionsTabPage(
        optionsWidget: VegetationDrawingOptions(
          options: options.vegetation,
          onChanged: (e) {
            setState(() {
              options.vegetation = e;
            });
          },
        ),
        onStartPreseed: () {
          startDrawing(options.vegetation);
        });
  }

  Widget structureOptions() {
    return createOptionsTabPage(
        optionsWidget: StructureDrawingOptions(
          options: options.structure,
          onChanged: (e) {
            setState(() {
              options.structure = e;
            });
          },
        ),
        onStartPreseed: () {
          startDrawing(options.structure);
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        initialIndex: 1,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Drawing options'),
              bottom: const TabBar(isScrollable: true, tabs: <Widget>[
                Tab(
                  text: 'Full body',
                ),
                Tab(
                  text: 'Body part',
                ),
                Tab(
                  text: 'Animal',
                ),
                Tab(
                  text: 'Structure',
                ),
                Tab(
                  text: 'Vegetation',
                )
              ]),
            ),
            //drawer: drawingsDrawer(context),
            body: TabBarView(children: [
              fullBodyOptions(),
              bodyPartOptions(),
              animalOptions(),
              structureOptions(),
              vegetationOptions()
            ])));
  }
}
