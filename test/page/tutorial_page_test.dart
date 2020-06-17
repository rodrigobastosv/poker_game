import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/page/board_page.dart';
import 'package:pokergame/page/tutorial_page.dart';

void main() {
  group('TutorialPage tests', () {
    testWidgets('should build without exploding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TutorialPage(),
        ),
      );
      expect(find.byType(TutorialPage), findsOneWidget);
    });

    testWidgets('should skip tutorial when click PULAR', (tester) async {
      const double PORTRAIT_WIDTH = 1000.0;
      const double PORTRAIT_HEIGHT = 2000.0;
      const double LANDSCAPE_WIDTH = PORTRAIT_HEIGHT;
      const double LANDSCAPE_HEIGHT = PORTRAIT_WIDTH;

      final TestWidgetsFlutterBinding binding =
          TestWidgetsFlutterBinding.ensureInitialized();

      await binding.setSurfaceSize(Size(PORTRAIT_WIDTH, PORTRAIT_HEIGHT));
      await tester.pumpWidget(
        MaterialApp(
          home: TutorialPage(),
        ),
      );

      await binding.setSurfaceSize(Size(LANDSCAPE_WIDTH, LANDSCAPE_HEIGHT));
      await tester.pump();
      await tester.pump();
      await tester.pump();
      await tester.pump();

      final skip = find.text('PULAR', skipOffstage: false);
      expect(skip, findsOneWidget);
      await tester.tap(skip);
      await tester.pump();
      await tester.pump();
      await tester.pump();
      await tester.pump();
      expect(find.byType(BoardPage), findsWidgets);
    });
  });
}
