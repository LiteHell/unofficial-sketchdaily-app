import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sketchdaily/app_preferences.dart';
import 'package:sketchdaily/sketchdaily_api/news/announcement.dart';
import 'package:sketchdaily/sketchdaily_api/news/news.dart';
import 'package:sketchdaily/widgets/announcement_dialog.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  bool _gotAnnouncement = false;
  static const _newsLimit = 10;
  late PagingController<int, News> _pagingController;

  Future handleAnnouncement() async {
    if (_gotAnnouncement) return;

    final announcement = await Announcement.getAnnouncement();
    _gotAnnouncement = true;

    if (await AppPreferences.isReadAnnouncement(announcement.id)) return;

    if (announcement.value.isNotEmpty && mounted) {
      showDialog(
          context: context,
          builder: ((context) =>
              AnnouncementDialog(announcement: announcement)));
    }
  }

  Future<void> fetchNews(int offset) async {
    final news = await News.getNews(offset: offset, limit: _newsLimit);
    final isLastPage = news.length < _newsLimit;

    if (isLastPage) {
      _pagingController.appendLastPage(news);
    } else {
      _pagingController.appendPage(news, offset + _newsLimit);
    }
  }

  @override
  void initState() {
    super.initState();

    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) {
      fetchNews(pageKey);
    });
    handleAnnouncement();
  }

  Widget buildNewsTile(News news) {
    return ListTile(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          news.title,
          textScaleFactor: 1.3,
        ),
        const SizedBox(
          width: 3,
          height: 3,
        ),
        HtmlWidget(news.content),
        Text('Wrote at ${news.date.toString()}',
            textScaleFactor: 0.55,
            style: const TextStyle(color: Color.fromARGB(255, 96, 96, 96)))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<News>(
          itemBuilder: (context, item, index) => buildNewsTile(item),
        ),
        separatorBuilder: ((context, index) => const Divider()));
  }
}
