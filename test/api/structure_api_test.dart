import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:sketchdaily/sketchdaily_api/structure/structure.dart';
import 'package:sketchdaily/sketchdaily_api/structure/structure_option.dart';

void main() {
  group('Animal', () {
    test('Can count structures without any options', () async {
      final count = await Structure.count(const StructureOption(null));
      expect(count, greaterThan(0));
    });
    test('Get structure without any options', () async {
      Structure structure =
          (await Structure.getStructure(const StructureOption(null)))!;
      expect(structure, isNotNull);
      final image = await http.get(structure.uri);
      expect(image.statusCode, 200);
      expect(image.contentLength, greaterThan(0));
      expect(image.headers['content-type'], startsWith('image/'));
    });

    test('Get structure with type option', () async {
      for (final i in StructureType.values) {
        Structure structure =
            (await Structure.getStructure(StructureOption(i)))!;
        expect(structure, isNotNull);
        expect(structure.classification.type, i);
        final image = await http.get(structure.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
      }
    });
  });
}
