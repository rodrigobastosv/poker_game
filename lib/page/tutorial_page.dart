import 'package:flutter/material.dart';
import 'package:pokergame/widget/fake_board.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FakeBoard(),
      ),
    );
  }
}
