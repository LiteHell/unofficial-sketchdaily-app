import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:sketchdaily/sketchdaily_api/body_part/body_part.dart';
import 'package:sketchdaily/sketchdaily_api/body_part/body_part_option.dart';
import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';

void main() {
  group('BodyPart', () {
    test('Can count bodyParts without any options', () async {
      final count = await BodyPart.count(const BodyPartOption());
      expect(count, greaterThan(0));
    });
    test('Get bodyPart without any options', () async {
      BodyPart bodyPart = (await BodyPart.getFullBody())!;
      expect(bodyPart, isNotNull);
      final image = await http.get(bodyPart.uri);
      expect(image.statusCode, 200);
      expect(image.contentLength, greaterThan(0));
      expect(image.headers['content-type'], startsWith('image/'));
    });

    test('Get bodyPart with gender option', () async {
      for (final i in Gender.values) {
        BodyPartOption option = BodyPartOption(gender: i);
        BodyPart bodyPart = (await BodyPart.getFullBody(option))!;
        expect(bodyPart, isNotNull);
        final image = await http.get(bodyPart.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(bodyPart.classification.gender, i);
      }
    });

    test('Get bodyPart with bodyPart option', () async {
      for (final i in BodyPartType.values) {
        if (i == BodyPartType.foot)
          continue; // Currently there're no foot images in sketchdaily website
        BodyPartOption option = BodyPartOption(bodyPart: i);
        BodyPart bodyPart = (await BodyPart.getFullBody(option))!;
        expect(bodyPart, isNotNull);
        final image = await http.get(bodyPart.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(bodyPart.classification.bodyPart, i);
      }
    });

    test('Get bodyPart with viewAngle option', () async {
      for (final i in ViewAngle.values) {
        BodyPartOption option = BodyPartOption(viewAngle: i);
        BodyPart bodyPart = (await BodyPart.getFullBody(option))!;
        expect(bodyPart, isNotNull);
        final image = await http.get(bodyPart.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(bodyPart.classification.viewAngle, i);
      }
    });
  });
}
