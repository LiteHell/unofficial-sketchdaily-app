import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';

class ViewAngleButton extends StatelessWidget {
  final ViewAngle? value;
  final void Function(ViewAngle?) onChanged;
  const ViewAngleButton(
      {super.key, required this.value, required this.onChanged});

  void Function()? onPressedClosure(ViewAngle? option) {
    if (value == option) {
      return null;
    }
    return () {
      onChanged(option);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: 5,
      children: [
        ElevatedButton(
            onPressed: onPressedClosure(null), child: const Text('All')),
        ElevatedButton(
            onPressed: onPressedClosure(ViewAngle.front),
            child: const Text('Front')),
        ElevatedButton(
            onPressed: onPressedClosure(ViewAngle.back),
            child: const Text('Back')),
        ElevatedButton(
            onPressed: onPressedClosure(ViewAngle.side),
            child: const Text('Side')),
        ElevatedButton(
            onPressed: onPressedClosure(ViewAngle.aboveOrBelow),
            child: const Text('Above or below')),
      ],
    );
  }
}
