import 'package:flutter/material.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';

class AnimalPage extends StatefulWidget {
  final AnimalOption option;
  const AnimalPage({super.key, required this.option});

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animal')),
      body: const Text('Hello, World!'),
    );
  }
}
