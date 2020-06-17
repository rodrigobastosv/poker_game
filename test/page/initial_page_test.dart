import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/page/board_page.dart';
import 'package:pokergame/page/initial_page.dart';
import 'package:pokergame/page/tutorial_page.dart';

void main() {
  group('InitialPage tests', () {
    testWidgets('should build without exploding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: InitialPage(),
        ),
      );
      expect(find.byType(InitialPage), findsOneWidget);
    });

    testWidgets('should go to board page when press iniciar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: InitialPage(),
        ),
      );
      final initBtn = find.byKey(const ValueKey('iniciar-btn'));
      expect(initBtn, findsOneWidget);
      await tester.tap(initBtn);
      await tester.pump();
      await tester.pump();
      await tester.pump();
      expect(find.byType(BoardPage), findsOneWidget);
    });

    testWidgets('should go to tutorial page when press tutorial',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: InitialPage(),
        ),
      );
      final tutorialBtn = find.byKey(const ValueKey('tutorial-btn'));
      expect(tutorialBtn, findsOneWidget);
      await tester.tap(tutorialBtn);
      await tester.pump();
      await tester.pump();
      await tester.pump();
      expect(find.byType(TutorialPage), findsOneWidget);
    });
  });
}
