import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'option_container.dart';

class AppPreferences {
  static Future<bool> isReadAnnouncement(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('read-announcement-id') == id;
  }

  static Future<void> markAnnouncementRead(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('read-announcement-id', id);
  }

  static Future<OptionContainer> readPictureOptions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('picture-options');

    if (jsonString == null) {
      return OptionContainer();
    } else {
      return OptionContainer.fromJson(json.decode(jsonString));
    }
  }

  static Future<void> writePictureOptions(OptionContainer options) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('picture-options', json.encode(options));
  }
}
