import 'package:sketchdaily/sketchdaily_api/request/api_get_request.dart';

class News {
  final String id;
  final String title;
  final DateTime date;
  final String content;
  News._privateConstructor(this.id, this.title, this.date, this.content);

  static Future<List<News>> getNews({int? offset, int? limit}) async {
    Map<String, String> parameters = {};
    if (offset != null) {
      parameters['offset'] = offset.toString();
    }
    if (limit != null) {
      parameters['limit'] = limit.toString();
    }
    final response =
        await getSketchDailyApi('/api/News', parameters) as List<dynamic>;
    List<News> result = [];
    for (final news in response) {
      result.add(News._privateConstructor(news['id'], news['title'],
          DateTime.parse(news['date']), news['content']));
    }
    return result;
  }
}
