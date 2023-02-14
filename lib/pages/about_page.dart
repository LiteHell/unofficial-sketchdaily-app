import 'package:flutter/material.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  List<Widget> listItems(BuildContext context) {
    const header = TextStyle(fontWeight: FontWeight.bold);
    return [
      ListTile(title: Text(Messages.aboutSketchDailyReference, style: header)),
      ListTile(
        title: Text(Messages.author),
        subtitle: const Text('Artomizer 〈artomizer@sketchdaily.net〉'),
        onTap: () {
          launchUrl(Uri.parse('mailto:artomizer@sketchdaily.net'));
        },
      ),
      ListTile(
        title: Text(Messages.website),
        subtitle: const Text('http://reference.sketchdaily.net/'),
        onTap: () {
          launchUrl(Uri.http('reference.sketchdaily.net'),
              mode: LaunchMode.externalApplication);
        },
      ),
      ListTile(title: Text(Messages.aboutApplication, style: header)),
      ListTile(
        title: Text(Messages.author),
        subtitle: const Text('LiteHell 〈litehell@litehell.info〉'),
        onTap: () {
          launchUrl(Uri.parse('mailto:litehell@litehell.info'));
        },
      ),
      ListTile(
        title: Text(Messages.githubRepository),
        subtitle: const Text(
            'https://github.com/litehell/unofficial-sketchdaily-app'),
        onTap: () {
          launchUrl(
              Uri.https('github.com', '/litehell/unofficial-sketchdaily-app'),
              mode: LaunchMode.externalApplication);
        },
      ),
      ListTile(
        title: Text(Messages.appLicense),
        subtitle: Text(Messages.gplNotice),
        onTap: () {
          launchUrl(Uri.https('www.gnu.org', '/licenses/gpl-3.0.html'));
        },
      ),
      ListTile(
          title: Text(Messages.fossLicense),
          subtitle: Text(Messages.fossLicenseSubtitle),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => LicensePage(
                    applicationName: Messages.sketchDailyReference))));
          })
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = listItems(context);

    return Scaffold(
      appBar: AppBar(title: Text(Messages.about)),
      body: ListView.separated(
          itemBuilder: ((context, index) => items[index]),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: items.length),
    );
  }
}
