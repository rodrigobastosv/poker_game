import 'package:flutter/material.dart';

class PokerBackCard extends StatelessWidget {
  PokerBackCard({GlobalKey key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('deck'),
      width: 100,
      height: 140,
      child: Image.asset(
        'assets/images/back.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
