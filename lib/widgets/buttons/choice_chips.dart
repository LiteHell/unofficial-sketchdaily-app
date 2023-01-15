import 'package:flutter/material.dart';

class ChoiceChipValueDescription<T> {
  final T? value;
  final String description;

  const ChoiceChipValueDescription(
      {required this.value, required this.description});
}

class ChoiceChips<T> extends StatelessWidget {
  final T? value;
  final Map<T?, String> descriptions = {};
  final void Function(T?) onChanged;
  ChoiceChips(
      {super.key,
      required this.value,
      required this.onChanged,
      required List<ChoiceChipValueDescription<T>> values}) {
    for (final i in values) {
      descriptions[i.value] = i.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = descriptions.entries.map((i) {
      return ChoiceChip(
          label: Text(i.value),
          selected: value == i.key,
          onSelected: (selected) {
            if (selected && value != i.key) {
              onChanged(i.key);
            }
          });
    }).toList();

    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: 5,
      children: children,
    );
  }
}
