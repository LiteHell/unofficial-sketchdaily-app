import 'package:flutter/material.dart';
import 'package:sketchdaily/widgets/announcements.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SketchDaily reference'),
        ),
        body: Column(children: [
          Flexible(child: const Announcements()),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
                child: const Text('Start Drawing!'), onPressed: () {}),
          )
        ]));
  }
}
