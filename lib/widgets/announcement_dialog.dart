import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketchdaily/app_preferences.dart';
import 'package:sketchdaily/sketchdaily_api/news/announcement.dart';

class AnnouncementDialog extends StatefulWidget {
  final Announcement announcement;
  const AnnouncementDialog({super.key, required this.announcement});

  @override
  State<AnnouncementDialog> createState() => _AnnouncementDialogState();
}

class _AnnouncementDialogState extends State<AnnouncementDialog> {
  var _doNotShowThisAgain = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Announcement'),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: SingleChildScrollView(
                    child: Text(widget.announcement.value, softWrap: true)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                      value: _doNotShowThisAgain,
                      onChanged: (e) {
                        if (e != null) {
                          setState(() {
                            _doNotShowThisAgain = e;
                          });
                        }
                      }),
                  const Flexible(
                      child: Text(
                    'Do not show this again',
                    softWrap: true,
                  )),
                ],
              )
            ]),
        actions: [
          TextButton.icon(
              onPressed: () {
                if (_doNotShowThisAgain) {
                  AppPreferences.markAnnouncementRead(widget.announcement.id);
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check),
              label: const Text('OK'))
        ]);
  }
}
