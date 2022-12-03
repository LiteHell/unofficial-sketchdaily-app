// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:sketchdaily/sketchdaily_api/structure/structure.dart';

void main() {
  group('Animal', () {
    test('Get structure without any options', () async {
      Structure structure = (await Structure.getStructure())!;
      expect(structure, isNotNull);
      final image = await http.get(structure.uri);
      expect(image.statusCode, 200);
      expect(image.contentLength, greaterThan(0));
      expect(image.headers['content-type'], startsWith('image/'));
    });

    test('Get structure with type option', () async {
      for (final i in StrctureType.values) {
        Structure structure = (await Structure.getStructure(type: i))!;
        expect(structure, isNotNull);
        expect(structure.structureType, i);
        final image = await http.get(structure.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
      }
    });
  });
}
