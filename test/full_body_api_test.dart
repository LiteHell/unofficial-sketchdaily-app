// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:sketchdaily/sketchdaily_api/full_body/full_body.dart';
import 'package:sketchdaily/sketchdaily_api/full_body/full_body_option.dart';
import 'package:sketchdaily/sketchdaily_api/gender.dart';
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';

void main() {
  group('FullBody', () {
    test('Get fullbody without any options', () async {
      FullBody fullBody = (await FullBody.getFullBody())!;
      expect(fullBody, isNotNull);
      final image = await http.get(fullBody.uri);
      expect(image.statusCode, 200);
      expect(image.contentLength, greaterThan(0));
      expect(image.headers['content-type'], startsWith('image/'));
    });

    // Test unavailable because sketchdaily server always return true as nsfw value, regardless of it's nsfw or not.
    /*
    test('Get fullbody with nsfw option', () async {
      for (final i in [true, false]) {
        FullBodyOption option = FullBodyOption(nsfw: i, clothing: true);
        FullBody vegetation = (await FullBody.getFullBody(option))!;
        expect(vegetation, isNotNull);
        final image = await http.get(vegetation.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
      }
    }); */

    test('Get fullbody with clothing option', () async {
      for (final i in [true, false]) {
        FullBodyOption option = FullBodyOption(clothing: i);
        FullBody fullBody = (await FullBody.getFullBody(option))!;
        expect(fullBody, isNotNull);
        final image = await http.get(fullBody.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(fullBody.classification.clothing, i);
      }
    });
    test('Get fullbody with gender option', () async {
      for (final i in Gender.values) {
        FullBodyOption option = FullBodyOption(gender: i);
        FullBody fullBody = (await FullBody.getFullBody(option))!;
        expect(fullBody, isNotNull);
        final image = await http.get(fullBody.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(fullBody.classification.gender, i);
      }
    });
    test('Get fullbody with pose option', () async {
      for (final i in PoseType.values) {
        FullBodyOption option = FullBodyOption(poseType: i);
        FullBody fullBody = (await FullBody.getFullBody(option))!;
        expect(fullBody, isNotNull);
        final image = await http.get(fullBody.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(fullBody.classification.poseType, i);
      }
    });
    test('Get fullbody with viewAngle option', () async {
      for (final i in ViewAngle.values) {
        FullBodyOption option = FullBodyOption(viewAngle: i);
        FullBody fullBody = (await FullBody.getFullBody(option))!;
        expect(fullBody, isNotNull);
        final image = await http.get(fullBody.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
        expect(fullBody.classification.viewAngle, i);
      }
    });
  });
}
