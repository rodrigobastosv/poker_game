import 'package:equatable/equatable.dart';

import 'suit_enum.dart';

class CardModel extends Equatable {
  CardModel({
    this.value,
    this.suit,
  });

  final int value;
  final SuitEnum suit;

  @override
  List<Object> get props => [
        value,
        suit,
      ];

  @override
  String toString() {
    return 'Card{value: $value, suit: $suit}';
  }
}
