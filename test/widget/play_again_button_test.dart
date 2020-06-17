import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/page/board_page.dart';
import 'package:pokergame/widget/play_again_button.dart';

void main() {
  testWidgets('PlayAgainButton tests', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: Scaffold(
        body: PlayAgainButton(),
      )),
    );
    final playButton = find.byType(PlayAgainButton);
    await tester.tap(playButton);
    await tester.pump();
    await tester.pump();
    expect(find.byType(BoardPage), findsOneWidget);
  });
}
