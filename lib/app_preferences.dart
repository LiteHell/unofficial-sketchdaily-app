import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static Future<bool> isReadAnnouncement(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('read-announcement-id') == id;
  }

  static Future<void> markAnnouncementRead(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('read-announcement-id', id);
  }
}
