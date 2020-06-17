import 'dart:async';

import 'package:avataaar_image/avataaar_image.dart';
import 'package:bloc/bloc.dart';
import 'package:faker/faker.dart';
import 'package:pokergame/model/board_model.dart';
import 'package:pokergame/model/card_model.dart';
import 'package:pokergame/model/hand_model.dart';
import 'package:pokergame/model/player_model.dart';
import 'package:pokergame/model/result_model.dart';
import 'package:pokergame/utils/game_utils.dart';

import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  PlayerModel playerOne;
  PlayerModel playerTwo;
  HandModel playerOneHand;
  HandModel playerTwoHand;
  int numberOfCardsDrawn = 0;
  CardModel firstDrawedCard;
  CardModel secondDrawedCard;
  CardModel thirdDrawedCard;
  CardModel fourthDrawedCard;
  CardModel fifthDrawedCard;
  List<CardModel> drawedCards = [];

  BoardModel get board => BoardModel(
        [
          firstDrawedCard,
          secondDrawedCard,
          thirdDrawedCard,
          fourthDrawedCard,
          fifthDrawedCard,
        ],
      );

  @override
  GameState get initialState => InitialGameState();

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is StartGame) {
      _generatePlayers();
      _generateHands();
      yield GameStarted();
    }
    if (event is TapOnDeck) {
      if (numberOfCardsDrawn != 5) {
        if (numberOfCardsDrawn == 0) {
          firstDrawedCard = _generateRandomUniqueCard();
          drawedCards.add(firstDrawedCard);
          yield FirstCardDrawed();
        }
        if (numberOfCardsDrawn == 1) {
          secondDrawedCard = _generateRandomUniqueCard();
          drawedCards.add(firstDrawedCard);
          yield SecondCardDrawed();
        }
        if (numberOfCardsDrawn == 2) {
          thirdDrawedCard = _generateRandomUniqueCard();
          drawedCards.add(firstDrawedCard);
          yield ThirdCardDrawed();
        }
        if (numberOfCardsDrawn == 3) {
          fourthDrawedCard = _generateRandomUniqueCard();
          drawedCards.add(firstDrawedCard);
          yield FourthCardDrawed();
        }
        if (numberOfCardsDrawn == 4) {
          fifthDrawedCard = _generateRandomUniqueCard();
          drawedCards.add(firstDrawedCard);
          yield FifthCardDrawed();
          add(EndGame());
        }
        numberOfCardsDrawn++;
      }
    }
    if (event is EndGame) {
      final results = calculateResults();
      yield WinningPlayerAnnounced(results);
    }
  }

  void _generatePlayers() {
    final faker = new Faker();
    playerOne = PlayerModel(
      name: faker.person.firstName(),
      avatar: Avataaar.random(),
    );

    playerTwo = PlayerModel(
      name: faker.person.firstName(),
      avatar: Avataaar.random(),
    );
  }

  void _generateHands() {
    _generateFirstHand();
    _generateSecondHand();
  }

  void _generateFirstHand() {
    final firstCardOfFirstHand = generateRandomCard();
    drawedCards.add(firstCardOfFirstHand);

    final secondCardOfFirstHand = _generateRandomUniqueCard();
    drawedCards.add(secondCardOfFirstHand);

    playerOneHand = HandModel(cards: [
      firstCardOfFirstHand,
      secondCardOfFirstHand,
    ]);
  }

  void _generateSecondHand() {
    final firstCardOfSecondHand = _generateRandomUniqueCard();
    drawedCards.add(firstCardOfSecondHand);

    final secondCardOfSecondHand = _generateRandomUniqueCard();
    drawedCards.add(secondCardOfSecondHand);

    playerTwoHand = HandModel(cards: [
      firstCardOfSecondHand,
      secondCardOfSecondHand,
    ]);
  }

  CardModel _generateRandomUniqueCard() {
    CardModel card;
    do {
      card = generateRandomCard();
    } while (drawedCards.contains(card));
    return card;
  }

  Map<String, dynamic> calculateResults() {
    final playerOneHasAPair = canMakeAPair(playerOneHand, board);
    final playerTwoHasAPair = canMakeAPair(playerTwoHand, board);

    final playerOneHasTwoPairs = canMakeTwoPairs(playerOneHand, board);
    final playerTwoHasTwoPairs = canMakeTwoPairs(playerTwoHand, board);

    final playerOneHasAThird = canMakeAThird(playerOneHand, board);
    final playerTwoHasAThird = canMakeAThird(playerTwoHand, board);

    final playerOneCanMakeSequence = canMakeSequence(playerOneHand, board);
    final playerTwoCanMakeSequence = canMakeSequence(playerTwoHand, board);

    final playerOneCanMakeFlush = canMakeFlush(playerOneHand, board);
    final playerTwoCanMakeFlush = canMakeFlush(playerTwoHand, board);

    final playerOneCanMakeFullHouse = canMakeFullHouse(playerOneHand, board);
    final playerTwoCanMakeFullHouse = canMakeFullHouse(playerTwoHand, board);

    final playerOneCanMakeAFourth = canMakeAFourth(playerOneHand, board);
    final playerTwoCanMakeAFourth = canMakeAFourth(playerTwoHand, board);

    final playerOneCanMakeStraightFlush =
        canMakeStraightFlush(playerOneHand, board);
    final playerTwoCanMakeStraightFlush =
        canMakeStraightFlush(playerTwoHand, board);

    final playerOneCanMakeRoyalStraightFlush =
        canMakeRoyalStraightFlush(playerOneHand, board);
    final playerTwoCanMakeRoyalStraightFlush =
        canMakeRoyalStraightFlush(playerTwoHand, board);

    final playerOneResult = ResultModel(
      highestCard: getHighestCardOfHand(playerOneHand),
      hasOnePair: playerOneHasAPair,
      hasTwoPairs: playerOneHasTwoPairs,
      hasThreeCards: playerOneHasAThird,
      hasSequence: playerOneCanMakeSequence,
      hasFlush: playerOneCanMakeFlush,
      hasFullHouse: playerOneCanMakeFullHouse,
      hasFourCards: playerOneCanMakeAFourth,
      hasStraightFlush: playerOneCanMakeStraightFlush,
      hasRoyalStraightFlush: playerOneCanMakeRoyalStraightFlush,
    );
    final playerTwoResult = ResultModel(
      highestCard: getHighestCardOfHand(playerTwoHand),
      hasOnePair: playerTwoHasAPair,
      hasTwoPairs: playerTwoHasTwoPairs,
      hasThreeCards: playerTwoHasAThird,
      hasSequence: playerTwoCanMakeSequence,
      hasFlush: playerTwoCanMakeFlush,
      hasFullHouse: playerTwoCanMakeFullHouse,
      hasFourCards: playerTwoCanMakeAFourth,
      hasStraightFlush: playerTwoCanMakeStraightFlush,
      hasRoyalStraightFlush: playerTwoCanMakeRoyalStraightFlush,
    );

    return _decideBestResult(playerOneResult, playerTwoResult);
  }

  Map<String, dynamic> _decideBestResult(
      ResultModel playerOneResult, ResultModel playerTwoResult) {
    if (playerOneResult.hasRoyalStraightFlush &&
        !playerTwoResult.hasRoyalStraightFlush) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Royal Straight Flush',
      };
    } else if (!playerOneResult.hasRoyalStraightFlush &&
        playerTwoResult.hasRoyalStraightFlush) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Royal Straight Flush',
      };
    }

    if (playerOneResult.hasStraightFlush && !playerTwoResult.hasStraightFlush) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Straight Flush',
      };
    } else if (!playerOneResult.hasStraightFlush &&
        playerTwoResult.hasStraightFlush) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Straight Flush',
      };
    }

    if (playerOneResult.hasFourCards && !playerTwoResult.hasFourCards) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Quadra',
      };
    } else if (!playerOneResult.hasFourCards && playerTwoResult.hasFourCards) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Quadra',
      };
    }

    if (playerOneResult.hasFullHouse && !playerTwoResult.hasFullHouse) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Full House',
      };
    } else if (!playerOneResult.hasFullHouse && playerTwoResult.hasFullHouse) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Full House',
      };
    }

    if (playerOneResult.hasFlush && !playerTwoResult.hasFlush) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Flush',
      };
    } else if (!playerOneResult.hasFlush && playerTwoResult.hasFlush) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Flush',
      };
    }

    if (playerOneResult.hasSequence && !playerTwoResult.hasSequence) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Sequência',
      };
    } else if (!playerOneResult.hasSequence && playerTwoResult.hasSequence) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Sequência',
      };
    }

    if (playerOneResult.hasThreeCards && !playerTwoResult.hasThreeCards) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Trinca',
      };
    } else if (!playerOneResult.hasThreeCards &&
        playerTwoResult.hasThreeCards) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Trinca',
      };
    }

    if (playerOneResult.hasTwoPairs && !playerTwoResult.hasTwoPairs) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Dois Pares',
      };
    } else if (!playerOneResult.hasTwoPairs && playerTwoResult.hasTwoPairs) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Dois Pares',
      };
    }

    if (playerOneResult.hasOnePair && !playerTwoResult.hasOnePair) {
      return {
        'result': playerOneResult,
        'winner': playerOne,
        'hand': 'Um Par',
      };
    } else if (!playerOneResult.hasOnePair && playerTwoResult.hasOnePair) {
      return {
        'result': playerTwoResult,
        'winner': playerTwo,
        'hand': 'Um Par',
      };
    }

    return playerOneResult.highestCard > playerTwoResult.highestCard
        ? {
            'result': playerOneResult,
            'winner': playerOne,
            'hand': 'Carta mais Alta',
          }
        : {
            'result': playerTwoResult,
            'winner': playerTwo,
            'hand': 'Carta mais Alta',
          };
  }
}
