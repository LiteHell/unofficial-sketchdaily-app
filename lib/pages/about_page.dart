import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  List<Widget> listItems() {
    const header = TextStyle(fontWeight: FontWeight.bold);
    return [
      const ListTile(title: Text('About Sketchdaily reference', style: header)),
      ListTile(
        title: const Text('Author'),
        subtitle: const Text('Artomizer 〈artomizer@sketchdaily.net〉'),
        onTap: () {
          launchUrl(Uri.parse('mailto:artomizer@sketchdaily.net'));
        },
      ),
      ListTile(
        title: const Text('Website'),
        subtitle: const Text('http://reference.sketchdaily.net/'),
        onTap: () {
          launchUrl(Uri.http('reference.sketchdaily.net'),
              mode: LaunchMode.externalApplication);
        },
      ),
      const ListTile(title: Text('About application', style: header)),
      ListTile(
        title: const Text('Author'),
        subtitle: const Text('LiteHell 〈litehell@litehell.info〉'),
        onTap: () {
          launchUrl(Uri.parse('mailto:litehell@litehell.info'));
        },
      ),
      ListTile(
        title: const Text('Repository'),
        subtitle: const Text(
            'https://github.com/litehell/unofficial-sketchdaily-app'),
        onTap: () {
          launchUrl(
              Uri.https('github.com', '/litehell/unofficial-sketchdaily-app'),
              mode: LaunchMode.externalApplication);
        },
      ),
      ListTile(
        title: const Text('License'),
        subtitle: const Text(
            'GNU General Public License version 3, or (at your option) any later version'),
        onTap: () {
          launchUrl(Uri.https('www.gnu.org', '/licenses/gpl-3.0.html'));
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = listItems();

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView.separated(
          itemBuilder: ((context, index) => items[index]),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: items.length),
    );
  }
}
