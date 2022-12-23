// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:sketchdaily/sketchdaily_api/sketchdaily_api.dart';

void main() {
  group('Animal', () {
    test('Can count animal without any options', () async {
      final count = await Animal.count(AnimalOption());
      expect(count, greaterThan(0));
    });
    test('Get animal without any options', () async {
      Animal animal = (await Animal.getAnimal(AnimalOption()))!;
      final image = await http.get(animal.uri);
      expect(image.statusCode, 200);
      expect(image.contentLength, greaterThan(0));
      expect(image.headers['content-type'], startsWith('image/'));
    });

    test('Get animal with species option', () async {
      for (final species in AnimalSpecies.values) {
        printOnFailure('Testing animal with species option $species');
        if (species == AnimalSpecies.bug) {
          // There's no bug image on SketchDaily reference
          continue;
        }
        Animal? animal = await Animal.getAnimal(AnimalOption(species: species));
        expect(animal, isNotNull);
        expect(animal!.classification.species, species);
        final image = await http.get(animal.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
      }
    });

    test('Get animal with category option', () async {
      for (final category in AnimalCategory.values) {
        printOnFailure('Testing animal with category option $category');
        Animal? animal =
            await Animal.getAnimal(AnimalOption(category: category));
        expect(animal, isNotNull);
        expect(animal!.classification.category, category);
        final image = await http.get(animal.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
      }
    });

    test('Get animal with viewAngle option', () async {
      for (final viewAngle in ViewAngle.values) {
        printOnFailure('Testing animal with viewAngle option $viewAngle');
        Animal? animal =
            await Animal.getAnimal(AnimalOption(viewAngle: viewAngle));
        expect(animal, isNotNull);
        expect(animal!.classification.viewAngle, viewAngle);
        final image = await http.get(animal.uri);
        expect(image.statusCode, 200);
        expect(image.contentLength, greaterThan(0));
        expect(image.headers['content-type'], startsWith('image/'));
      }
    });
  });
}
