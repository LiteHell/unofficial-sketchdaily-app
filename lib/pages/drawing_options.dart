import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sketchdaily/app_preferences.dart';
import 'package:sketchdaily/pages/picture_page.dart';
import 'package:sketchdaily/sketchdaily_api/picture_options.dart';
import 'package:sketchdaily/widgets/drawing_option/animal_drawing_options.dart';

import '../option_container.dart';
import '../widgets/drawing_option/body_part_drawing_options.dart';
import '../widgets/drawing_option/full_body_drawing_options.dart';
import '../widgets/drawing_option/structure_drawing_options.dart';
import '../widgets/drawing_option/vegetation_drawing_options.dart';

class DrawingOptions extends StatefulWidget {
  const DrawingOptions({super.key});

  @override
  State<DrawingOptions> createState() => _DrawingOptionsState();
}

class _DrawingOptionsState extends State<DrawingOptions> {
  OptionContainer options = OptionContainer();
  bool _infiniteTime = false;
  final TextEditingController _controller = TextEditingController(text: '5');

  _DrawingOptionsState() : super() {
    loadOptionsFromPreferences();
  }

  void loadOptionsFromPreferences() async {
    OptionContainer optionsLoaded = await AppPreferences.readPictureOptions();
    if (mounted) {
      setState(() => {options = optionsLoaded});
    }
  }

  void saveOptionsToPreferences() async {
    await AppPreferences.writePictureOptions(options);
  }

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
              saveOptionsToPreferences();
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
              saveOptionsToPreferences();
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
              saveOptionsToPreferences();
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
              saveOptionsToPreferences();
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
              saveOptionsToPreferences();
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
