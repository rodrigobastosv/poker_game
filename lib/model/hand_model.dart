import 'package:equatable/equatable.dart';

import 'card_model.dart';

class HandModel extends Equatable {
  HandModel({this.cards});

  final List<CardModel> cards;

  @override
  List<Object> get props => [cards];

  @override
  String toString() {
    return 'Hand{cards: $cards}';
  }
}
