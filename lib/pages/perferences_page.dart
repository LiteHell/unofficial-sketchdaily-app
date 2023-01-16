import 'package:flutter/material.dart';
import 'package:sketchdaily/app_preferences.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/widgets/get_cached_image.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool? skipNewsPage, displayElapsedTimeOnInfinite, displayTimeLeft;

  Future<void> readPreferences() async {
    bool skipNewsPage = await AppPreferences.doSkipAlreadyReadNews();
    bool displayElapsedTimeOnInfinite =
        await AppPreferences.doDisplayElapsedTimeOnInfiniteTime();
    bool displayTimeLeft =
        await AppPreferences.doDisplayRemainingTimeOnPlayer();

    if (mounted) {
      setState(() {
        this.skipNewsPage = skipNewsPage;
        this.displayElapsedTimeOnInfinite = displayElapsedTimeOnInfinite;
        this.displayTimeLeft = displayTimeLeft;
      });
    }
  }

  Widget checkboxListTile(
      {required void Function(bool? value) onChanged,
      required bool? value,
      required String title,
      String? subtitle}) {
    return ListTile(
      leading: Checkbox(
        onChanged: onChanged,
        value: value ?? false,
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }

  Widget headerListTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Iterable<Widget> newsAndAnnouncementSettings() {
    return [
      checkboxListTile(
          onChanged: (value) async {
            if (value == null) {
              return;
            }

            await AppPreferences.setSkipAlreadyReadNews(value);
            await readPreferences();
          },
          value: skipNewsPage,
          title: Messages.skipNewsPageWhenNoMoreLatestNews)
    ];
  }

  Iterable<Widget> drawingOptionsSettings() {
    return [
      ListTile(
        title: Text(Messages.clearDrawingOptions),
        subtitle: Text(Messages.clearDrawingOptionsDescription),
        onTap: () async {
          await AppPreferences.clearPictureOptions();
        },
      ),
      ListTile(
        title: Text(Messages.clearTimeValues),
        subtitle: Text(Messages.clearTimeValuesDescription),
        onTap: () async {
          for (var i = 0; i < 5; i++) {
            await AppPreferences.clearDrawingTimeOptionFor(i);
          }
        },
      )
    ];
  }

  Iterable<Widget> picturePlayerSettings() {
    bool displayTimeLeft = this.displayTimeLeft ?? true;
    return [
      checkboxListTile(
        title: Messages.displayElapsedTimeWithInfinityTimer,
        subtitle: Messages.displayElapsedTimeWithInfinityTimerDescription,
        value: displayElapsedTimeOnInfinite,
        onChanged: (value) async {
          if (value == null) return;

          await AppPreferences.setDisplayElapsedTimeOnInfiniteTime(value);
          await readPreferences();
        },
      ),
      checkboxListTile(
        title: Messages.displayElapsedTime,
        subtitle: Messages.displayElapsedTimeDescription,
        value: !displayTimeLeft,
        onChanged: (value) async {
          if (value == null) return;

          await AppPreferences.setDisplayTimeLeftOnPlayer(!value);
          await readPreferences();
        },
      ),
      ListTile(
          title: Text(Messages.clearImageCache),
          subtitle: Text(Messages.clearImageCacheDescription),
          onTap: () async {
            await clearCache();
          })
    ];
  }

  @override
  Widget build(BuildContext context) {
    /**
     * News and announcements
     * [Boolean] Skip news page when there's no latest news
     * Picture options
     * [void]    Clear picture options memory for category
     * [void]    Clear drawing time memory for category
     * Player
     * [void]    Display elapsed time on infinity time
     * [void]    Display time left instead of time elapsed
     */

    readPreferences();
    final items = [
      headerListTile(Messages.newsAndAnnouncementsPreferences),
      ...newsAndAnnouncementSettings(),
      headerListTile(Messages.referenceOptionsPreferences),
      ...drawingOptionsSettings(),
      headerListTile(Messages.playerOptions),
      ...picturePlayerSettings()
    ];

    return Scaffold(
      appBar: AppBar(title: Text(Messages.preferences)),
      body: ListView.separated(
          itemBuilder: (context, index) => items[index],
          separatorBuilder: (context, count) => const Divider(),
          itemCount: items.length),
    );
  }
}
