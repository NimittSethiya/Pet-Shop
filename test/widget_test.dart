import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:testproject/ui/MyPetsScreen/my_pets_screen.dart';
import 'package:testproject/ui/bindings/initialBinding.dart';

void main() {
  testWidgets('Pet Shop Grid Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GetMaterialApp(
      title: 'Pet Shop',
      initialBinding: InitialBinding(),
      home: const MyPetsScreen(),
    ));

    // Scroll to the end of the GridView
    await tester.pump(Duration(seconds: 3));
    await tester.drag(find.byKey(Key('grid')), const Offset(0, -500));
    await tester.pumpAndSettle();

    // Verify that the last item is visible
    expect(find.byKey(Key('Item 24')), findsOneWidget);

    // Tap the first item in the GridView
    await tester.tap(find.byKey(Key('Item 0')));
    await tester.pumpAndSettle();

    // Verify that the tap is registered
    expect(tester.widget<GestureDetector>(find.byKey(Key('Item 0'))).onTap, isNotNull);
    expect(tester.widget<GestureDetector>(find.byKey(Key('Item 0'))).onTap, isNotNull);

  });
}
