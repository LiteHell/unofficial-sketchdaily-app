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
  final List<bool> _isInfiniteTimes = [false, false, false, false, false];
  final List<TextEditingController> _controllers = [
    TextEditingController(text: '5'),
    TextEditingController(text: '5'),
    TextEditingController(text: '5'),
    TextEditingController(text: '5'),
    TextEditingController(text: '5')
  ];

  _DrawingOptionsState() : super() {
    loadOptionsFromPreferences();
    attachTextControllerListener();
  }

  void attachTextControllerListener() {
    for (var i = 0; i < 5; i++) {
      _controllers[i].addListener(() {
        int? result = int.tryParse(_controllers[i].text);
        if (result != null) {
          AppPreferences.writeDrawingTimeOptionFor(i, result);
        }
      });
    }
  }

  void loadOptionsFromPreferences() async {
    OptionContainer optionsLoaded = await AppPreferences.readPictureOptions();
    List<int> times = [5, 5, 5, 5, 5];
    List<bool> isInfiniteTimes = [false, false, false, false, false];
    for (var i = 0; i < 5; i++) {
      final time = await AppPreferences.readDrawingTimeOptionOf(i);
      if (time == null) {
        isInfiniteTimes[i] = true;
      } else {
        isInfiniteTimes[i] = false;
        times[i] = time;
      }
    }
    if (mounted) {
      setState(() {
        options = optionsLoaded;
        for (var i = 0; i < 5; i++) {
          _isInfiniteTimes[i] = isInfiniteTimes[i];
          _controllers[i].text = times[i].toString();
        }
      });
    }
  }

  void saveOptionsToPreferences() async {
    await AppPreferences.writePictureOptions(options);
  }

  void startDrawing(PictureOption options, int tabIndex) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PicturePage(
              options: options,
              duration:
                  Duration(seconds: int.parse(_controllers[tabIndex].text)),
              infiniteDuration: _isInfiniteTimes[tabIndex],
            )));
  }

  Widget createOptionsTabPage({
    required Widget optionsWidget,
    required void Function() onStartPreseed,
    required int tabIndex,
  }) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              optionsWidget,
              const Text('Time (in seconds)'),
              TextField(
                  controller: _controllers[tabIndex],
                  keyboardType: TextInputType.number,
                  enabled: !_isInfiniteTimes[tabIndex],
                  maxLines: 1),
              Row(children: [
                Checkbox(
                    value: _isInfiniteTimes[tabIndex],
                    onChanged: (e) {
                      if (e != null) {
                        setState(() {
                          _isInfiniteTimes[tabIndex] = e;
                          int? parsedTime =
                              int.tryParse(_controllers[tabIndex].text);

                          if (e) {
                            AppPreferences.writeDrawingTimeOptionFor(
                                tabIndex, null);
                          } else {
                            AppPreferences.writeDrawingTimeOptionFor(
                                tabIndex, parsedTime);
                          }
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

  Widget animalOptions(int tabIndex) {
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
          startDrawing(options.animal, tabIndex);
        },
        tabIndex: tabIndex);
  }

  Widget fullBodyOptions(int tabIndex) {
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
          startDrawing(options.fullBody, tabIndex);
        },
        tabIndex: tabIndex);
  }

  Widget bodyPartOptions(int tabIndex) {
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
          startDrawing(options.bodyPart, tabIndex);
        },
        tabIndex: tabIndex);
  }

  Widget vegetationOptions(int tabIndex) {
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
          startDrawing(options.vegetation, tabIndex);
        },
        tabIndex: tabIndex);
  }

  Widget structureOptions(int tabIndex) {
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
          startDrawing(options.structure, tabIndex);
        },
        tabIndex: tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        initialIndex: 0,
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
              fullBodyOptions(0),
              bodyPartOptions(1),
              animalOptions(2),
              structureOptions(3),
              vegetationOptions(4)
            ])));
  }
}
