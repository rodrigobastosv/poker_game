import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/model/card_model.dart';

void main() {
  test('toString', () {
    expect(CardModel.elevenOfClubs().toString(),
        'Card{value: 11, suit: SuitEnum.clubs}');
    expect(CardModel.eightOfClubs().toString(),
        'Card{value: 8, suit: SuitEnum.clubs}');
    expect(CardModel.sevenOfClubs().toString(),
        'Card{value: 7, suit: SuitEnum.clubs}');
    expect(CardModel.fourOfClubs().toString(),
        'Card{value: 4, suit: SuitEnum.clubs}');
    expect(CardModel.threeOfClubs().toString(),
        'Card{value: 3, suit: SuitEnum.clubs}');
    expect(CardModel.thirteenOfHearts().toString(),
        'Card{value: 13, suit: SuitEnum.hearts}');
    expect(CardModel.twelveOfHearts().toString(),
        'Card{value: 12, suit: SuitEnum.hearts}');
    expect(CardModel.tenOfHearts().toString(),
        'Card{value: 10, suit: SuitEnum.hearts}');
    expect(CardModel.nineOfHearts().toString(),
        'Card{value: 9, suit: SuitEnum.hearts}');
    expect(CardModel.eightOfHearts().toString(),
        'Card{value: 8, suit: SuitEnum.hearts}');
    expect(CardModel.sevenOfHearts().toString(),
        'Card{value: 7, suit: SuitEnum.hearts}');
    expect(CardModel.sixOfHearts().toString(),
        'Card{value: 6, suit: SuitEnum.hearts}');
    expect(CardModel.fiveOfHearts().toString(),
        'Card{value: 5, suit: SuitEnum.hearts}');
    expect(CardModel.fourOfHearts().toString(),
        'Card{value: 4, suit: SuitEnum.hearts}');
    expect(CardModel.thirteenOfDiamonds().toString(),
        'Card{value: 13, suit: SuitEnum.diamonds}');
    expect(CardModel.twelveOfDiamonds().toString(),
        'Card{value: 12, suit: SuitEnum.diamonds}');
    expect(CardModel.elevenOfDiamonds().toString(),
        'Card{value: 11, suit: SuitEnum.diamonds}');
    expect(CardModel.nineOfDiamonds().toString(),
        'Card{value: 9, suit: SuitEnum.diamonds}');
    expect(CardModel.eightOfDiamonds().toString(),
        'Card{value: 8, suit: SuitEnum.diamonds}');
    expect(CardModel.sixOfDiamonds().toString(),
        'Card{value: 6, suit: SuitEnum.diamonds}');
    expect(CardModel.fiveOfDiamonds().toString(),
        'Card{value: 5, suit: SuitEnum.diamonds}');
    expect(CardModel.fourOfDiamonds().toString(),
        'Card{value: 4, suit: SuitEnum.diamonds}');
    expect(CardModel.threeOfDiamonds().toString(),
        'Card{value: 3, suit: SuitEnum.diamonds}');
    expect(CardModel.twoOfDiamonds().toString(),
        'Card{value: 2, suit: SuitEnum.diamonds}');
    expect(CardModel.thirteenOfSpades().toString(),
        'Card{value: 13, suit: SuitEnum.spades}');
    expect(CardModel.twelveOfSpades().toString(),
        'Card{value: 12, suit: SuitEnum.spades}');
    expect(CardModel.elevenOfSpades().toString(),
        'Card{value: 11, suit: SuitEnum.spades}');
    expect(CardModel.nineOfSpades().toString(),
        'Card{value: 9, suit: SuitEnum.spades}');
    expect(CardModel.eightOfSpades().toString(),
        'Card{value: 8, suit: SuitEnum.spades}');
    expect(CardModel.sevenOfSpades().toString(),
        'Card{value: 7, suit: SuitEnum.spades}');
    expect(CardModel.sixOfSpades().toString(),
        'Card{value: 6, suit: SuitEnum.spades}');
  });
}
