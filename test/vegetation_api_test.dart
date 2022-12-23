// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';

void main() {
  group('Animal', () {
    test('Get vegetation without any options', () async {
      Vegetation vegetation = (await Vegetation.getVegetation())!;
      expect(vegetation, isNotNull);
      final image = await http.get(vegetation.uri);
      expect(image.statusCode, 200);
      expect(image.contentLength, greaterThan(0));
      expect(image.headers['content-type'], startsWith('image/'));
    });

    test('Get structure with photoType option', () async {
      for (final i in VegetationPhotoType.values) {
        VegetationOption option = VegetationOption(photoType: i);
        Vegetation vegetation = (await Vegetation.getVegetation(option))!;
        expect(vegetation, isNotNull);
        final image = await http.get(vegetation.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(vegetation.classification.photoType, i);
      }
    });

    test('Get structure with vegetationType option', () async {
      for (final i in VegetationType.values) {
        VegetationOption option = VegetationOption(type: i);
        Vegetation vegetation = (await Vegetation.getVegetation(option))!;
        expect(vegetation, isNotNull);
        final image = await http.get(vegetation.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(vegetation.classification.type, i);
      }
    });
  });
}
