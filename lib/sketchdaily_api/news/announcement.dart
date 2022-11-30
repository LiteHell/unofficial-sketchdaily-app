import 'package:sketchdaily/sketchdaily_api/request/api_get_request.dart';

class Announcement {
  final String id;
  final String value;

  Announcement._privateConstructor(this.id, this.value);
  static Future<Announcement> getAnnouncement() async {
    dynamic response = await getSketchDailyApi('/api/Announcement');
    return Announcement._privateConstructor(response['id'], response['value']);
  }
}
