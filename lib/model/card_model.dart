import 'package:equatable/equatable.dart';

import 'suit_enum.dart';

class CardModel extends Equatable {
  CardModel({
    this.value,
    this.suit,
  });

  factory CardModel.aceOfSpades() => CardModel(
        value: 1,
        suit: SuitEnum.spades,
      );
  factory CardModel.twoOfSpades() => CardModel(
        value: 2,
        suit: SuitEnum.spades,
      );
  factory CardModel.threeOfSpades() => CardModel(
        value: 3,
        suit: SuitEnum.spades,
      );
  factory CardModel.fourOfSpades() => CardModel(
        value: 4,
        suit: SuitEnum.spades,
      );
  factory CardModel.fiveOfSpades() => CardModel(
        value: 5,
        suit: SuitEnum.spades,
      );
  factory CardModel.sixOfSpades() => CardModel(
        value: 6,
        suit: SuitEnum.spades,
      );
  factory CardModel.sevenOfSpades() => CardModel(
        value: 7,
        suit: SuitEnum.spades,
      );
  factory CardModel.eightOfSpades() => CardModel(
        value: 8,
        suit: SuitEnum.spades,
      );
  factory CardModel.nineOfSpades() => CardModel(
        value: 9,
        suit: SuitEnum.spades,
      );
  factory CardModel.tenOfSpades() => CardModel(
        value: 10,
        suit: SuitEnum.spades,
      );
  factory CardModel.elevenOfSpades() => CardModel(
        value: 11,
        suit: SuitEnum.spades,
      );
  factory CardModel.twelveOfSpades() => CardModel(
        value: 12,
        suit: SuitEnum.spades,
      );
  factory CardModel.thirteenOfSpades() => CardModel(
        value: 13,
        suit: SuitEnum.spades,
      );

  factory CardModel.aceOfDiamonds() => CardModel(
        value: 1,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.twoOfDiamonds() => CardModel(
        value: 2,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.threeOfDiamonds() => CardModel(
        value: 3,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.fourOfDiamonds() => CardModel(
        value: 4,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.fiveOfDiamonds() => CardModel(
        value: 5,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.sixOfDiamonds() => CardModel(
        value: 6,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.sevenOfDiamonds() => CardModel(
        value: 7,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.eightOfDiamonds() => CardModel(
        value: 8,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.nineOfDiamonds() => CardModel(
        value: 9,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.tenOfDiamonds() => CardModel(
        value: 10,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.elevenOfDiamonds() => CardModel(
        value: 11,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.twelveOfDiamonds() => CardModel(
        value: 12,
        suit: SuitEnum.diamonds,
      );
  factory CardModel.thirteenOfDiamonds() => CardModel(
        value: 13,
        suit: SuitEnum.diamonds,
      );

  factory CardModel.aceOfHearts() => CardModel(
        value: 1,
        suit: SuitEnum.hearts,
      );
  factory CardModel.twoOfHearts() => CardModel(
        value: 2,
        suit: SuitEnum.hearts,
      );
  factory CardModel.threeOfHearts() => CardModel(
        value: 3,
        suit: SuitEnum.hearts,
      );
  factory CardModel.fourOfHearts() => CardModel(
        value: 4,
        suit: SuitEnum.hearts,
      );
  factory CardModel.fiveOfHearts() => CardModel(
        value: 5,
        suit: SuitEnum.hearts,
      );
  factory CardModel.sixOfHearts() => CardModel(
        value: 6,
        suit: SuitEnum.hearts,
      );
  factory CardModel.sevenOfHearts() => CardModel(
        value: 7,
        suit: SuitEnum.hearts,
      );
  factory CardModel.eightOfHearts() => CardModel(
        value: 8,
        suit: SuitEnum.hearts,
      );
  factory CardModel.nineOfHearts() => CardModel(
        value: 9,
        suit: SuitEnum.hearts,
      );
  factory CardModel.tenOfHearts() => CardModel(
        value: 10,
        suit: SuitEnum.hearts,
      );
  factory CardModel.elevenOfHearts() => CardModel(
        value: 11,
        suit: SuitEnum.hearts,
      );
  factory CardModel.twelveOfHearts() => CardModel(
        value: 12,
        suit: SuitEnum.hearts,
      );
  factory CardModel.thirteenOfHearts() => CardModel(
        value: 13,
        suit: SuitEnum.hearts,
      );

  factory CardModel.aceOfClubs() => CardModel(
        value: 1,
        suit: SuitEnum.clubs,
      );
  factory CardModel.twoOfClubs() => CardModel(
        value: 2,
        suit: SuitEnum.clubs,
      );
  factory CardModel.threeOfClubs() => CardModel(
        value: 3,
        suit: SuitEnum.clubs,
      );
  factory CardModel.fourOfClubs() => CardModel(
        value: 4,
        suit: SuitEnum.clubs,
      );
  factory CardModel.fiveOfClubs() => CardModel(
        value: 5,
        suit: SuitEnum.clubs,
      );
  factory CardModel.sixOfClubs() => CardModel(
        value: 6,
        suit: SuitEnum.clubs,
      );
  factory CardModel.sevenOfClubs() => CardModel(
        value: 7,
        suit: SuitEnum.clubs,
      );
  factory CardModel.eightOfClubs() => CardModel(
        value: 8,
        suit: SuitEnum.clubs,
      );
  factory CardModel.nineOfClubs() => CardModel(
        value: 9,
        suit: SuitEnum.clubs,
      );
  factory CardModel.tenOfClubs() => CardModel(
        value: 10,
        suit: SuitEnum.clubs,
      );
  factory CardModel.elevenOfClubs() => CardModel(
        value: 11,
        suit: SuitEnum.clubs,
      );
  factory CardModel.twelveOfClubs() => CardModel(
        value: 12,
        suit: SuitEnum.clubs,
      );
  factory CardModel.thirteenOfClubs() => CardModel(
        value: 13,
        suit: SuitEnum.clubs,
      );

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
