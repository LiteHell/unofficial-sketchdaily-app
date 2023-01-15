import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sketchdaily/pages/perferences_page.dart';

import '../pages/about_page.dart';

class CustomizedPopupMenu extends StatelessWidget {
  List<PopupMenuItem> additionalMenus;
  CustomizedPopupMenu({super.key, this.additionalMenus = const []});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_horiz),
        onSelected: (value) {
          value();
        },
        itemBuilder: (context) => <PopupMenuEntry>[
              if (additionalMenus.isNotEmpty) ...additionalMenus,
              if (additionalMenus.isNotEmpty) const PopupMenuDivider(),
              PopupMenuItem(
                child: const Text('Preferences'),
                value: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PreferencesPage()));
                },
              ),
              PopupMenuItem(
                child: const Text('About...'),
                value: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutPage()));
                },
              )
            ]);
  }
}
