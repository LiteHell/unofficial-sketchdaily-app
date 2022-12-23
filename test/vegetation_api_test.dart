import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation.dart';
import 'package:sketchdaily/sketchdaily_api/vegetation/vegetation_option.dart';

void main() {
  group('Animal', () {
    test('Can count vegetations without any options', () async {
      final count = await Vegetation.count(const VegetationOption());
      expect(count, greaterThan(0));
    });
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
