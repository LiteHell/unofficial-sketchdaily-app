import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sketchdaily/pages/amimal_picture_page.dart';
import 'package:sketchdaily/sketchdaily_api/animal/animal_option.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';
import 'package:sketchdaily/widgets/drawing_option/animal_drawing_options.dart';
import 'package:sketchdaily/widgets/drawings_drawer.dart';

class DrawingOptions extends StatefulWidget {
  const DrawingOptions({super.key});

  @override
  State<DrawingOptions> createState() => _DrawingOptionsState();
}

class _DrawingOptionsState extends State<DrawingOptions> {
  var _options = AnimalOption(category: null, species: null, viewAngle: null);
  bool _infiniteTime = false;
  final TextEditingController _controller = TextEditingController(text: '5');

  void startAnimalDrawing() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AnimalPicturePage(
              options: _options,
              duration: Duration(seconds: int.parse(_controller.text)),
              infiniteDuration: _infiniteTime,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Drawing options')),
        //drawer: drawingsDrawer(context),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimalDrawingOptions(
                        options: _options,
                        onChanged: (e) {
                          setState(() {
                            _options = e;
                          });
                        },
                      ),
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
                              onPressed: startAnimalDrawing,
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Start')))
                    ]))));
  }
}
