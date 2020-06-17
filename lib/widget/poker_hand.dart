import 'package:flutter/material.dart';
import 'package:pokergame/model/hand_model.dart';

import 'poker_card.dart';

class PokerHand extends StatelessWidget {
  PokerHand(this.hand, {GlobalKey key}) : super(key: key);

  final HandModel hand;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        PokerCard(hand.cards[0]),
        PokerCard(hand.cards[1]),
      ],
    );
  }
}
