import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'option_container.dart';

class AppPreferences {
  static Future<bool> doSkipAlreadyReadNews() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('skip-already-read-news') ?? true;
  }

  static Future<void> setSkipAlreadyReadNews(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('skip-already-read-news', value);
  }

  static Future<bool> isReadNews(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('read-news-id') == id;
  }

  static Future<void> markNewsRead(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('read-news-id', id);
  }

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

  static Future<void> clearPictureOptions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('picture-options');
  }

  static Future<void> writePictureOptions(OptionContainer options) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('picture-options', json.encode(options));
  }

  static Future<void> clearDrawingTimeOptionFor(int idx) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'drawing-options-time-$idx';
    await prefs.remove(key);
  }

  static Future<void> writeDrawingTimeOptionFor(int idx, int? time) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'drawing-options-time-$idx';
    if (time == null) {
      await prefs.setInt(key, -1);
    } else {
      await prefs.setInt(key, time!);
    }
  }

  static Future<int?> readDrawingTimeOptionOf(int idx,
      [int? defaultTime = 5]) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'drawing-options-time-$idx';
    final saved = prefs.getInt(key);

    if (saved == -1) {
      return null;
    } else if (saved == null) {
      return defaultTime;
    } else {
      return saved;
    }
  }

  static Future<bool> doDisplayElapsedTimeOnInfiniteTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('display-elapsed-time-on-infinite') ?? true;
  }

  static Future<void> setDisplayElapsedTimeOnInfiniteTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('display-elapsed-time-on-infinite', value);
  }

  static Future<bool> doDisplayRemainingTimeOnPlayer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('display-time-left-on-player') ?? true;
  }

  static Future<void> setDisplayTimeLeftOnPlayer(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('display-time-left-on-player', value);
  }
}
