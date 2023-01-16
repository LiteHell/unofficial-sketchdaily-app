import 'package:flutter/material.dart';
import 'package:sketchdaily/app_preferences.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/pages/picture_page.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body.dart';
import 'package:sketchdaily/sketchdaily_api/picture_options.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation.dart';
import 'package:sketchdaily/widgets/drawing_option/animal_drawing_options.dart';

import '../option_container.dart';
import '../widgets/customized_popup_menu.dart';
import '../widgets/drawing_option/body_part_drawing_options.dart';
import '../widgets/drawing_option/full_body_drawing_options.dart';
import '../widgets/drawing_option/structure_drawing_options.dart';
import '../widgets/drawing_option/vegetation_drawing_options.dart';

class ReferenceOptions extends StatefulWidget {
  const ReferenceOptions({super.key});

  @override
  State<ReferenceOptions> createState() => _ReferenceOptionsState();
}

class _ReferenceOptionsState extends State<ReferenceOptions> {
  OptionContainer options = OptionContainer();
  final List<bool> _isInfiniteTimes = [false, false, false, false, false];
  final List<int?> _imageCounts = [null, null, null, null, null];
  final List<TextEditingController> _controllers = [
    TextEditingController(text: '5'),
    TextEditingController(text: '5'),
    TextEditingController(text: '5'),
    TextEditingController(text: '5'),
    TextEditingController(text: '5')
  ];

  _ReferenceOptionsState() : super() {
    attachTextControllerListener();
    loadOptionsFromPreferences().then((value) async {
      await getAllImageCount();
    });
  }

  Future<void> getAllImageCount() async {
    final newImageCounts = [
      await FullBody.count(options.fullBody),
      await BodyPart.count(options.bodyPart),
      await Animal.count(options.animal),
      await Structure.count(options.structure),
      await Vegetation.count(options.vegetation)
    ];
    if (mounted) {
      setState(() {
        for (var i = 0; i < 5; i++) {
          _imageCounts[i] = newImageCounts[i];
        }
      });
    }
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

  Future<void> loadOptionsFromPreferences() async {
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
              Text(Messages.timeInSeconds),
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
                Text(Messages.infiniteTimeCheckbox),
              ]),
              Center(
                child: Text(_imageCounts[tabIndex] == null
                    ? Messages.loadingImageCount
                    : Messages.nImagesAvailable(
                        _imageCounts[tabIndex]?.toString() ?? '??')),
              ),
              Center(
                  child: ElevatedButton.icon(
                      onPressed: onStartPreseed,
                      icon: const Icon(Icons.play_arrow),
                      label: Text(Messages.start)))
            ])));
  }

  Widget animalOptions(int tabIndex) {
    return createOptionsTabPage(
        optionsWidget: AnimalDrawingOptions(
          options: options.animal,
          onChanged: (e) async {
            final newCount = await Animal.count(e);

            if (mounted) {
              setState(() {
                options.animal = e;
                _imageCounts[tabIndex] = newCount;
                saveOptionsToPreferences();
              });
            }
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
          onChanged: (e) async {
            final newCount = await FullBody.count(e);

            if (mounted) {
              setState(() {
                options.fullBody = e;
                _imageCounts[tabIndex] = newCount;
                saveOptionsToPreferences();
              });
            }
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
          onChanged: (e) async {
            final newCount = await BodyPart.count(e);

            if (mounted) {
              setState(() {
                options.bodyPart = e;
                _imageCounts[tabIndex] = newCount;
                saveOptionsToPreferences();
              });
            }
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
          onChanged: (e) async {
            final newCount = await Vegetation.count(e);

            if (mounted) {
              setState(() {
                options.vegetation = e;
                _imageCounts[tabIndex] = newCount;
                saveOptionsToPreferences();
              });
            }
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
          onChanged: (e) async {
            final newCount = await Structure.count(e);

            if (mounted) {
              setState(() {
                options.structure = e;
                _imageCounts[tabIndex] = newCount;
                saveOptionsToPreferences();
              });
            }
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
              title: Text(Messages.referenceOptionsTitle),
              actions: const [CustomizedPopupMenu()],
              bottom: TabBar(
                  isScrollable: true,
                  key: const Key('drawing-options-tab-bar'),
                  tabs: <Widget>[
                    Tab(
                      text: Messages.fullBody,
                    ),
                    Tab(
                      text: Messages.bodyPart,
                    ),
                    Tab(
                      text: Messages.animal,
                    ),
                    Tab(
                      text: Messages.structure,
                    ),
                    Tab(
                      text: Messages.vegetation,
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
