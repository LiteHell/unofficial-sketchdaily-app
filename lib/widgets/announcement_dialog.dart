import 'package:flutter/material.dart';
import 'package:sketchdaily/app_preferences.dart';
import 'package:sketchdaily/i18n/messages.dart';
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
        title: Text(Messages.announcement),
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
                  Flexible(
                      child: Text(
                    Messages.doNotShowThisAgain,
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
              label: Text(Messages.ok))
        ]);
  }
}
