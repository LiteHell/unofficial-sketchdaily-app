// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sketchdaily/app_preferences.dart';
import 'package:sketchdaily/main.dart';

void main() {
  setUpAll(() async {
    HttpOverrides.global = null;
  });
  group('News page', () {
    setUp(() async {
      await AppPreferences.clearAll();
    });
    testWidgets(
        '"Start Drawing!" button and pallete icon are displayed at first screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SketchDailyReferenceApp());

      // Verify that palette icon and drawing button is visible
      expect(find.text('Start Drawing!'), findsOneWidget);
      expect(find.byIcon(Icons.palette), findsOneWidget);

      // Click button and trigger a frame.
      await tester.tap(find.text('Start Drawing!'));
      await tester.pump();
    });
    testWidgets('Menu is visible on news page', (WidgetTester tester) async {
      await tester.pumpWidget(const SketchDailyReferenceApp());

      // Verify that more icon and drawing button is visible
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
    });
    testWidgets('Submenu is visible when menu is clicked',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SketchDailyReferenceApp());

      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pump(const Duration(seconds: 3));

      expect(find.text('Preferences'), findsOneWidget);
      expect(find.text('About...'), findsOneWidget);
    });
  });
  group('Drawing options page', () {
    Future<void> clickStartDrawingButton(WidgetTester tester) async {
      await tester.pumpWidget(const SketchDailyReferenceApp());

      // Click button and trigger a frame.
      await tester.tap(find.text('Start Drawing!'));
      await tester.pumpAndSettle();
    }

    testWidgets('Five tabs are available', (tester) async {
      await clickStartDrawingButton(tester);

      final tabBarFinder =
          find.byKey(const ValueKey('drawing-options-tab-bar'));
      final tabBarCenter = tester.getCenter(tabBarFinder);
      const tabNames = [
        'Full body',
        'Body part',
        'Animal',
        'Structure',
        'Vegetation'
      ];

      for (final i in tabNames) {
        final itemFinder = find.text(i);
        while (itemFinder.evaluate().isEmpty) {
          await tester.dragFrom(tabBarCenter, const Offset(3.0, 0.0));
        }
        expect(find.text(i), findsOneWidget);
      }
    });
  });
}
