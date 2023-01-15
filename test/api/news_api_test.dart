import 'package:flutter_test/flutter_test.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';

void main() {
  group('News', () {
    isNonEmptyNews(element) {
      expect(element.content, isNotEmpty);
      expect(element.id, isNotEmpty);
      expect(element.title, isNotEmpty);
    }

    test('Get announcement', () async {
      Announcement announcement = await Announcement.getAnnouncement();
      expect(announcement.id, isNotEmpty);
    });

    test('Get news', () async {
      List<News> news = await News.getNews();

      news.forEach(isNonEmptyNews);
    });

    test('Get news with limit', () async {
      for (var i = 1; i <= 3; i++) {
        List<News> news = await News.getNews(limit: i);

        expect(news.length, i);
        news.forEach(isNonEmptyNews);
      }
    });

    test('Get news with limit and offset', () async {
      List<News> secondNews = await News.getNews(offset: 2, limit: 1);
      List<News> thirdNews = await News.getNews(offset: 3, limit: 1);
      List<News> news = await News.getNews(offset: 1, limit: 3);
      expect(news.length, 3);
      expect(news[1].id, secondNews.first.id);
      expect(news[2].id, thirdNews.first.id);

      news.forEach(isNonEmptyNews);
    });
  });
}
