import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      appBar: AppBar(title: const Text('Report image')),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Report type'),
            DropdownButton(
                value: reportType,
                items: const [
                  DropdownMenuItem(
                    value: ImageReportType.inappropriate,
                    child: Text('Inappopriate'),
                  ),
                  DropdownMenuItem(
                    value: ImageReportType.copyrightViolation,
                    child: Text('Copyright violation'),
                  ),
                  DropdownMenuItem(
                    value: ImageReportType.lowQuality,
                    child: Text('Low qaulity'),
                  ),
                  DropdownMenuItem(
                    value: ImageReportType.wrongClassifications,
                    child: Text('Wrong classifications'),
                  ),
                  DropdownMenuItem(
                    value: ImageReportType.other,
                    child: Text('Other'),
                  ),
                ],
                onChanged: ((value) {
                  if (value != null) {
                    setState(() {
                      reportType = value;
                    });
                  }
                })),
            const Text('Comment'),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: controller,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  await ReportImage(widget.imageId,
                      reportType: reportType,
                      comment: controller.text,
                      type: widget.imageType);

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(Icons.report_problem_outlined),
                label: const Text('Report problem'))
          ]
              .map((i) => Padding(child: i, padding: const EdgeInsets.all(10)))
              .toList()),
    );
  }
}
