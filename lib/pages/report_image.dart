import 'package:flutter/material.dart';
import 'package:sketchdaily/i18n/messages.dart';
import 'package:sketchdaily/sketchdaily_api/report_image.dart';

class ReportImagePage extends StatefulWidget {
  final ImageType imageType;
  final String imageId;
  const ReportImagePage(
      {super.key, required this.imageId, required this.imageType});

  @override
  State<ReportImagePage> createState() => _ReportImagePageState();
}

class _ReportImagePageState extends State<ReportImagePage> {
  ImageReportType reportType = ImageReportType.inappropriate;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Messages.reportImageTitle)),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Messages.reportType),
            DropdownButton(
                value: reportType,
                items: [
                  DropdownMenuItem(
                    value: ImageReportType.inappropriate,
                    child: Text(Messages.inappopriate),
                  ),
                  DropdownMenuItem(
                    value: ImageReportType.copyrightViolation,
                    child: Text(Messages.copyrightViolation),
                  ),
                  DropdownMenuItem(
                    value: ImageReportType.lowQuality,
                    child: Text(Messages.lowQaulity),
                  ),
                  DropdownMenuItem(
                    value: ImageReportType.wrongClassifications,
                    child: Text(Messages.wrongClassifications),
                  ),
                  DropdownMenuItem(
                    value: ImageReportType.other,
                    child: Text(Messages.other),
                  ),
                ],
                onChanged: ((value) {
                  if (value != null) {
                    setState(() {
                      reportType = value;
                    });
                  }
                })),
            Text(Messages.reportComment),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: controller,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  await reportImage(widget.imageId,
                      reportType: reportType,
                      comment: controller.text,
                      type: widget.imageType);

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.report_problem_outlined),
                label: Text(Messages.reportImageButton))
          ]
              .map((i) => Padding(padding: const EdgeInsets.all(10), child: i))
              .toList()),
    );
  }
}
