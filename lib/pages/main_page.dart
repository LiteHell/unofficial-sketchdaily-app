import 'package:flutter/material.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/pages/reference_options.dart';
import 'package:sketchdaily/widgets/announcements.dart';
import 'package:sketchdaily/widgets/customized_popup_menu.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.sketchDailyReference),
        actions: const [CustomizedPopupMenu()],
      ),
      body: Column(children: [
        const Flexible(child: Announcements()),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
              icon: const Icon(Icons.palette),
              label: Text(Messages.startDrawing),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ReferenceOptions()));
              }),
        )
      ]),
    );
  }
}
