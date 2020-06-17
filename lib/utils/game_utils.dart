import 'dart:math';

import 'package:pokergame/model/board_model.dart';
import 'package:pokergame/model/card_model.dart';
import 'package:pokergame/model/hand_model.dart';
import 'package:pokergame/model/suit_enum.dart';

int generateRandomValue() {
  return Random().nextInt(12) + 1;
}

SuitEnum generateRandomSuit() {
  int range = Random().nextInt(3) + 1;
  return SuitEnum.values.elementAt(range);
}

CardModel generateRandomCard() {
  return CardModel(
    value: generateRandomValue(),
    suit: generateRandomSuit(),
  );
}

HandModel generateRandomHand() {
  final firstCard = generateRandomCard();
  final secondCard = generateRandomCard();
  return HandModel(
    cards: [
      firstCard,
      secondCard,
    ],
  );
}

bool cardMakesPair(CardModel card, BoardModel board) {
  final value = card.value;

  int firstDrawedCardValue = board.cardsOnBoard[0].value;
  int secondDrawedCardValue = board.cardsOnBoard[1].value;
  int thirdDrawedCardValue = board.cardsOnBoard[2].value;
  int fourthDrawedCardValue = board.cardsOnBoard[3].value;
  int fifthDrawedCardValue = board.cardsOnBoard[4].value;

  return (firstDrawedCardValue == value ||
      secondDrawedCardValue == value ||
      thirdDrawedCardValue == value ||
      fourthDrawedCardValue == value ||
      fifthDrawedCardValue == value);
}

bool canMakeAPair(HandModel hand, BoardModel board) {
  int numberOfPairs = 0;
  final mapValuesOcurrences = _getValueOcurrencesMap(hand, board);
  if (mapValuesOcurrences[0] == 2) numberOfPairs++;
  if (mapValuesOcurrences[1] == 2) numberOfPairs++;
  if (mapValuesOcurrences[2] == 2) numberOfPairs++;
  if (mapValuesOcurrences[3] == 2) numberOfPairs++;
  if (mapValuesOcurrences[4] == 2) numberOfPairs++;
  if (mapValuesOcurrences[5] == 2) numberOfPairs++;
  if (mapValuesOcurrences[6] == 2) numberOfPairs++;
  if (mapValuesOcurrences[7] == 2) numberOfPairs++;
  if (mapValuesOcurrences[8] == 2) numberOfPairs++;
  if (mapValuesOcurrences[9] == 2) numberOfPairs++;
  if (mapValuesOcurrences[10] == 2) numberOfPairs++;
  if (mapValuesOcurrences[11] == 2) numberOfPairs++;
  if (mapValuesOcurrences[12] == 2) numberOfPairs++;
  return numberOfPairs == 1;
}

bool canMakeTwoPairs(HandModel hand, BoardModel board) {
  int numberOfPairs = 0;
  final mapValuesOcurrences = _getValueOcurrencesMap(hand, board);
  if (mapValuesOcurrences[0] == 2) numberOfPairs++;
  if (mapValuesOcurrences[1] == 2) numberOfPairs++;
  if (mapValuesOcurrences[2] == 2) numberOfPairs++;
  if (mapValuesOcurrences[3] == 2) numberOfPairs++;
  if (mapValuesOcurrences[4] == 2) numberOfPairs++;
  if (mapValuesOcurrences[5] == 2) numberOfPairs++;
  if (mapValuesOcurrences[6] == 2) numberOfPairs++;
  if (mapValuesOcurrences[7] == 2) numberOfPairs++;
  if (mapValuesOcurrences[8] == 2) numberOfPairs++;
  if (mapValuesOcurrences[9] == 2) numberOfPairs++;
  if (mapValuesOcurrences[10] == 2) numberOfPairs++;
  if (mapValuesOcurrences[11] == 2) numberOfPairs++;
  if (mapValuesOcurrences[12] == 2) numberOfPairs++;
  return numberOfPairs == 2;
}

bool canMakeAThird(HandModel hand, BoardModel board) {
  final mapValuesOcurrences = _getValueOcurrencesMap(hand, board);

  return mapValuesOcurrences[0] == 3 ||
      mapValuesOcurrences[1] == 3 ||
      mapValuesOcurrences[2] == 3 ||
      mapValuesOcurrences[3] == 3 ||
      mapValuesOcurrences[4] == 3 ||
      mapValuesOcurrences[5] == 3 ||
      mapValuesOcurrences[6] == 3 ||
      mapValuesOcurrences[7] == 3 ||
      mapValuesOcurrences[8] == 3 ||
      mapValuesOcurrences[9] == 3 ||
      mapValuesOcurrences[10] == 3 ||
      mapValuesOcurrences[11] == 3 ||
      mapValuesOcurrences[12] == 3;
}

bool canMakeSequence(HandModel hand, BoardModel board) {
  final firstCard = hand.cards[0];
  final secondCard = hand.cards[1];
  final firstValue = firstCard.value;
  final secondValue = secondCard.value;

  int firstDrawedCardValue = board.cardsOnBoard[0].value;
  int secondDrawedCardValue = board.cardsOnBoard[1].value;
  int thirdDrawedCardValue = board.cardsOnBoard[2].value;
  int fourthDrawedCardValue = board.cardsOnBoard[3].value;
  int fifthDrawedCardValue = board.cardsOnBoard[4].value;

  List<int> values = [
    firstValue,
    secondValue,
    firstDrawedCardValue,
    secondDrawedCardValue,
    thirdDrawedCardValue,
    fourthDrawedCardValue,
    fifthDrawedCardValue,
  ];
  List<int> comparatorValues = [];
  values.sort((a, b) => a.compareTo(b));
  for (int i = 0; i < values.length - 1; i++) {
    comparatorValues.add(values[i + 1] - values[i]);
  }
  final firstIndex = comparatorValues.indexWhere((v) => v == 1);
  if (firstIndex <= 2 && firstIndex != -1) {
    final sum = values[firstIndex] +
        values[firstIndex + 1] +
        values[firstIndex + 2] +
        values[firstIndex + 3] +
        values[firstIndex + 4];
    return sum == 5;
  }
  return false;
}

bool canMakeFlush(HandModel hand, BoardModel board) {
  final firstCard = hand.cards[0];
  final secondCard = hand.cards[1];
  final firstSuit = firstCard.suit;
  final secondSuit = secondCard.suit;

  SuitEnum firstDrawedCardSuit = board.cardsOnBoard[0].suit;
  SuitEnum secondDrawedCardSuit = board.cardsOnBoard[1].suit;
  SuitEnum thirdDrawedCardSuit = board.cardsOnBoard[2].suit;
  SuitEnum fourthDrawedCardSuit = board.cardsOnBoard[3].suit;
  SuitEnum fifthDrawedCardSuit = board.cardsOnBoard[4].suit;

  List<SuitEnum> suits = [
    firstSuit,
    secondSuit,
    firstDrawedCardSuit,
    secondDrawedCardSuit,
    thirdDrawedCardSuit,
    fourthDrawedCardSuit,
    fifthDrawedCardSuit,
  ];
  suits.sort((a, b) => a.index.compareTo(b.index));

  final mapSuitsOcurrences = Map();

  suits.forEach((element) {
    if (!mapSuitsOcurrences.containsKey(element)) {
      mapSuitsOcurrences[element] = 1;
    } else {
      mapSuitsOcurrences[element] += 1;
    }
  });

  return mapSuitsOcurrences[SuitEnum.clubs] == 5 ||
      mapSuitsOcurrences[SuitEnum.diamonds] == 5 ||
      mapSuitsOcurrences[SuitEnum.hearts] == 5 ||
      mapSuitsOcurrences[SuitEnum.spades] == 5;
}

bool canMakeFullHouse(HandModel hand, BoardModel board) {
  final mapValuesOcurrences = _getValueOcurrencesMap(hand, board);
  return mapValuesOcurrences.containsValue(2) &&
      mapValuesOcurrences.containsValue(3);
}

bool canMakeAFourth(HandModel hand, BoardModel board) {
  final mapValuesOcurrences = _getValueOcurrencesMap(hand, board);

  return mapValuesOcurrences[0] == 4 ||
      mapValuesOcurrences[1] == 4 ||
      mapValuesOcurrences[2] == 4 ||
      mapValuesOcurrences[3] == 4 ||
      mapValuesOcurrences[4] == 4 ||
      mapValuesOcurrences[5] == 4 ||
      mapValuesOcurrences[6] == 4 ||
      mapValuesOcurrences[7] == 4 ||
      mapValuesOcurrences[8] == 4 ||
      mapValuesOcurrences[9] == 4 ||
      mapValuesOcurrences[10] == 4 ||
      mapValuesOcurrences[11] == 4 ||
      mapValuesOcurrences[12] == 4;
}

int getHighestCardOfHand(HandModel hand) {
  final firstCard = hand.cards[0];
  final secondCard = hand.cards[1];
  final firstValue = firstCard.value;
  final secondValue = secondCard.value;

  return firstValue > secondValue ? firstValue : secondValue;
}

Map _getValueOcurrencesMap(HandModel hand, BoardModel board) {
  final firstCard = hand.cards[0];
  final secondCard = hand.cards[1];
  final firstValue = firstCard.value;
  final secondValue = secondCard.value;

  int firstDrawedCardValue = board.cardsOnBoard[0].value;
  int secondDrawedCardValue = board.cardsOnBoard[1].value;
  int thirdDrawedCardValue = board.cardsOnBoard[2].value;
  int fourthDrawedCardValue = board.cardsOnBoard[3].value;
  int fifthDrawedCardValue = board.cardsOnBoard[4].value;

  List<int> values = [
    firstValue,
    secondValue,
    firstDrawedCardValue,
    secondDrawedCardValue,
    thirdDrawedCardValue,
    fourthDrawedCardValue,
    fifthDrawedCardValue,
  ];

  final mapValuesOcurrences = Map();

  values.forEach((element) {
    if (!mapValuesOcurrences.containsKey(element)) {
      mapValuesOcurrences[element] = 1;
    } else {
      mapValuesOcurrences[element] += 1;
    }
  });

  return mapValuesOcurrences;
}