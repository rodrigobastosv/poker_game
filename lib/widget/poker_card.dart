import 'package:flutter/material.dart';
import 'package:pokergame/model/card_model.dart';
import 'package:pokergame/model/suit_enum.dart';

class PokerCard extends StatelessWidget {
  PokerCard(this.card);

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 100,
        height: 140,
        child: Image.asset(
          'assets/images/${card.value}_${getSuitFromEnum(card.suit)}.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
