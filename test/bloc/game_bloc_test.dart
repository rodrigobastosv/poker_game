import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/bloc/bloc.dart';
import 'package:pokergame/model/card_model.dart';
import 'package:pokergame/model/hand_model.dart';
import 'package:pokergame/model/player_model.dart';
import 'package:pokergame/model/suit_enum.dart';

void main() {
  group('GameBloc tests', () {
    GameBloc gameBloc;

    setUp(() {
      gameBloc = GameBloc();
    });

    tearDown(() {
      gameBloc?.close();
    });

    test('Expects InitialGameState to be the initial state', () {
      expect(gameBloc.state, equals(InitialGameState()));
    });

    group('StartGame event', () {
      blocTest(
        'Expects to generate players, hands and yield GameStarted state',
        build: () async => gameBloc,
        act: (gameBloc) {
          gameBloc.add(StartGame());
          return;
        },
        verify: (gameBloc) async {
          expect(gameBloc.playerOne, isNotNull);
          expect(gameBloc.playerTwo, isNotNull);
          expect(gameBloc.playerOneHand, isNotNull);
          expect(gameBloc.playerTwoHand, isNotNull);
        },
        expect: [
          GameStarted(),
        ],
      );
    });

    group('TapOnDeck event', () {
      blocTest(
        'Tapping on deck should yield the draw card states',
        build: () async => GameBloc(),
        act: (gameBloc) {
          gameBloc.add(StartGame());
          gameBloc.add(TapOnDeck());
          gameBloc.add(TapOnDeck());
          gameBloc.add(TapOnDeck());
          gameBloc.add(TapOnDeck());
          gameBloc.add(TapOnDeck());
          return;
        },
        verify: (gameBloc) async {
          expect(gameBloc.numberOfCardsDrawn, 4);
        },
        expect: [
          GameStarted(),
          FirstCardDrawed(),
          SecondCardDrawed(),
          ThirdCardDrawed(),
          FourthCardDrawed(),
          FifthCardDrawed(),
        ],
      );
    });

    group('EndGame', () {
      blocTest(
        'should have the results by the end of the game',
        build: () async {
          final bloc = GameBloc();
          bloc.firstDrawedCard = CardModel(suit: SuitEnum.clubs, value: 4);
          bloc.secondDrawedCard = CardModel(suit: SuitEnum.diamonds, value: 8);
          bloc.thirdDrawedCard = CardModel(suit: SuitEnum.diamonds, value: 12);
          bloc.fourthDrawedCard = CardModel(suit: SuitEnum.spades, value: 3);
          bloc.fifthDrawedCard = CardModel(suit: SuitEnum.hearts, value: 1);
          return bloc;
        },
        act: (gameBloc) {
          gameBloc.add(StartGame());
          gameBloc.add(EndGame());
          return;
        },
        verify: (gameBloc) async {},
        expect: [
          GameStarted(),
          isInstanceOf<WinningPlayerAnnounced>(),
        ],
      );
    });

    group('results', () {
      GameBloc gameBloc;

      setUp(() {
        gameBloc = GameBloc();
        gameBloc.playerOne = PlayerModel(
          name: 'Player 1',
        );
        gameBloc.playerTwo = PlayerModel(
          name: 'Player 2',
        );
      });

      tearDown(() {
        gameBloc.close();
      });

      test('player one should win with a fourth', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.twoOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.tenOfClubs(),
          CardModel.tenOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.aceOfHearts();
        gameBloc.thirdDrawedCard = CardModel.aceOfSpades();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.thirteenOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasFourCards, true);
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with a fourth', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.tenOfClubs(),
          CardModel.tenOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.twoOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.aceOfHearts();
        gameBloc.thirdDrawedCard = CardModel.aceOfSpades();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.thirteenOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasFourCards, true);
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with a full house', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.tenOfClubs(),
          CardModel.tenOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.twoOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.aceOfHearts();
        gameBloc.thirdDrawedCard = CardModel.fiveOfClubs();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasFullHouse, true);
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with a full house', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.twoOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.tenOfClubs(),
          CardModel.tenOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.aceOfHearts();
        gameBloc.thirdDrawedCard = CardModel.fiveOfClubs();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasFullHouse, true);
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with a flush', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.fiveOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.tenOfClubs(),
          CardModel.tenOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.twoOfClubs();
        gameBloc.thirdDrawedCard = CardModel.sixOfClubs();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasFlush, true);
        expect(results['hand'], 'Flush');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with a flush', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.tenOfClubs(),
          CardModel.tenOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.fiveOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.twoOfClubs();
        gameBloc.thirdDrawedCard = CardModel.sixOfClubs();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasFlush, true);
        expect(results['hand'], 'Flush');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with a sequence', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfSpades(),
          CardModel.twoOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.fiveOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.threeOfSpades();
        gameBloc.secondDrawedCard = CardModel.fourOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fiveOfSpades();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasSequence, true);
        expect(results['hand'], 'Sequência');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with a sequence', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.fiveOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfSpades(),
          CardModel.twoOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.threeOfSpades();
        gameBloc.secondDrawedCard = CardModel.fourOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fiveOfSpades();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasSequence, true);
        expect(results['hand'], 'Sequência');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with a third', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfSpades(),
          CardModel.aceOfHearts(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.fiveOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.fourOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fiveOfSpades();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasThreeCards, true);
        expect(results['hand'], 'Trinca');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with a third', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.fiveOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfSpades(),
          CardModel.aceOfHearts(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.fourOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fiveOfSpades();
        gameBloc.fourthDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasThreeCards, true);
        expect(results['hand'], 'Trinca');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with two pairs', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.twoOfHearts(),
          CardModel.threeOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.thirteenOfClubs(),
          CardModel.fiveOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.twoOfClubs();
        gameBloc.secondDrawedCard = CardModel.fourOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fiveOfSpades();
        gameBloc.fourthDrawedCard = CardModel.threeOfHearts();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasTwoPairs, true);
        expect(results['hand'], 'Dois Pares');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with two pairs', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.thirteenOfClubs(),
          CardModel.fiveOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.twoOfHearts(),
          CardModel.threeOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.twoOfClubs();
        gameBloc.secondDrawedCard = CardModel.fourOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fiveOfSpades();
        gameBloc.fourthDrawedCard = CardModel.threeOfHearts();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasTwoPairs, true);
        expect(results['hand'], 'Dois Pares');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with one pair', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfHearts(),
          CardModel.sixOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.twoOfHearts(),
          CardModel.thirteenOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.aceOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.fourOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fiveOfSpades();
        gameBloc.fourthDrawedCard = CardModel.elevenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasOnePair, true);
        expect(results['hand'], 'Um Par');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with one pair', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfHearts(),
          CardModel.sixOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.twoOfHearts(),
          CardModel.elevenOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.twoOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.fourOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fiveOfSpades();
        gameBloc.fourthDrawedCard = CardModel.thirteenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.tenOfDiamonds();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasOnePair, true);
        expect(results['hand'], 'Um Par');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with a high card', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.twoOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.twoOfHearts(),
          CardModel.thirteenOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfSpades();
        gameBloc.secondDrawedCard = CardModel.sevenOfDiamonds();
        gameBloc.thirdDrawedCard = CardModel.nineOfClubs();
        gameBloc.fourthDrawedCard = CardModel.tenOfSpades();
        gameBloc.fifthDrawedCard = CardModel.elevenOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['result'].highestCard, 1);
        expect(results['hand'], 'Carta mais Alta');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player one should win with a high card that is not ace', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.thirteenOfClubs(),
          CardModel.twoOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.twoOfHearts(),
          CardModel.threeOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfSpades();
        gameBloc.secondDrawedCard = CardModel.sevenOfDiamonds();
        gameBloc.thirdDrawedCard = CardModel.nineOfClubs();
        gameBloc.fourthDrawedCard = CardModel.tenOfSpades();
        gameBloc.fifthDrawedCard = CardModel.elevenOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['result'].highestCard, 13);
        expect(results['hand'], 'Carta mais Alta');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with a high card', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.twoOfHearts(),
          CardModel.thirteenOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfClubs(),
          CardModel.twoOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfSpades();
        gameBloc.secondDrawedCard = CardModel.sevenOfDiamonds();
        gameBloc.thirdDrawedCard = CardModel.nineOfClubs();
        gameBloc.fourthDrawedCard = CardModel.tenOfSpades();
        gameBloc.fifthDrawedCard = CardModel.elevenOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['result'].highestCard, 1);
        expect(results['hand'], 'Carta mais Alta');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player two should win with a high card that is not ace', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.twoOfHearts(),
          CardModel.threeOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.thirteenOfClubs(),
          CardModel.twoOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfSpades();
        gameBloc.secondDrawedCard = CardModel.sevenOfDiamonds();
        gameBloc.thirdDrawedCard = CardModel.nineOfClubs();
        gameBloc.fourthDrawedCard = CardModel.tenOfSpades();
        gameBloc.fifthDrawedCard = CardModel.elevenOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['result'].highestCard, 13);
        expect(results['hand'], 'Carta mais Alta');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with a straight flush', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.sevenOfClubs(),
          CardModel.eightOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfDiamonds(),
          CardModel.fiveOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.nineOfClubs();
        gameBloc.secondDrawedCard = CardModel.tenOfClubs();
        gameBloc.thirdDrawedCard = CardModel.elevenOfClubs();
        gameBloc.fourthDrawedCard = CardModel.aceOfHearts();
        gameBloc.fifthDrawedCard = CardModel.threeOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['hand'], 'Straight Flush');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with a straight flush', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfDiamonds(),
          CardModel.fiveOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.sevenOfClubs(),
          CardModel.eightOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.nineOfClubs();
        gameBloc.secondDrawedCard = CardModel.tenOfClubs();
        gameBloc.thirdDrawedCard = CardModel.elevenOfClubs();
        gameBloc.fourthDrawedCard = CardModel.aceOfHearts();
        gameBloc.fifthDrawedCard = CardModel.threeOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['hand'], 'Straight Flush');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('player one should win with a royal straight flush', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.eightOfClubs(),
          CardModel.nineOfClubs(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfDiamonds(),
          CardModel.fiveOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.tenOfClubs();
        gameBloc.secondDrawedCard = CardModel.elevenOfClubs();
        gameBloc.thirdDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fourthDrawedCard = CardModel.aceOfHearts();
        gameBloc.fifthDrawedCard = CardModel.threeOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['hand'], 'Royal Straight Flush');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('player two should win with a royal straight flush', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfDiamonds(),
          CardModel.fiveOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.eightOfClubs(),
          CardModel.nineOfClubs(),
        ]);
        gameBloc.firstDrawedCard = CardModel.tenOfClubs();
        gameBloc.secondDrawedCard = CardModel.elevenOfClubs();
        gameBloc.thirdDrawedCard = CardModel.twelveOfClubs();
        gameBloc.fourthDrawedCard = CardModel.aceOfHearts();
        gameBloc.fifthDrawedCard = CardModel.threeOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['hand'], 'Royal Straight Flush');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('''player two should win with a flush with a hand 
        [
          12 - spades
          9  - spades
        ]
        and the board 
        [
          8  - spades
          11 - diamonds
          3  - spades
          6  - spades
          12 - queen
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.nineOfHearts(),
          CardModel.sevenOfHearts(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.twelveOfSpades(),
          CardModel.nineOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.eightOfSpades();
        gameBloc.secondDrawedCard = CardModel.elevenOfDiamonds();
        gameBloc.thirdDrawedCard = CardModel.threeOfSpades();
        gameBloc.fourthDrawedCard = CardModel.sixOfSpades();
        gameBloc.fifthDrawedCard = CardModel.twelveOfHearts();
        final results = gameBloc.calculateResults();
        expect(results['hand'], 'Flush');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('''player one should win because has a higher pair with a hand 
        [
          12  - hearts
          10  - hearts
        ]
        and the board 
        [
          5  - hearts
          7  - hearts
          6  - spades
          12 - spades
          11 - spades
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.twelveOfHearts(),
          CardModel.tenOfHearts(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfSpades(),
          CardModel.sevenOfDiamonds(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfHearts();
        gameBloc.secondDrawedCard = CardModel.sevenOfHearts();
        gameBloc.thirdDrawedCard = CardModel.sixOfSpades();
        gameBloc.fourthDrawedCard = CardModel.twelveOfSpades();
        gameBloc.fifthDrawedCard = CardModel.elevenOfSpades();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasOnePair, true);
        expect(results['result'].pairOf, 12);
        expect(results['hand'], 'Um Par');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('''player two should win because has a higher pair with a hand 
        [
          12  - hearts
          10  - hearts
        ]
        and the board 
        [
          5  - hearts
          7  - hearts
          6  - spades
          12 - spades
          11 - spades
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfSpades(),
          CardModel.sevenOfDiamonds(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.twelveOfHearts(),
          CardModel.tenOfHearts(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfHearts();
        gameBloc.secondDrawedCard = CardModel.sevenOfHearts();
        gameBloc.thirdDrawedCard = CardModel.sixOfSpades();
        gameBloc.fourthDrawedCard = CardModel.twelveOfSpades();
        gameBloc.fifthDrawedCard = CardModel.elevenOfSpades();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasOnePair, true);
        expect(results['result'].pairOf, 12);
        expect(results['hand'], 'Um Par');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('''player one should win because has a higher pair with a hand 
        [
          1  - diamonds
          1  - spades
        ]
        and the board 
        [
          5  - diamonds
          9  - spades
          4  - diamonds
          7  - hearts
          7  - clubs
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfDiamonds(),
          CardModel.aceOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.threeOfDiamonds(),
          CardModel.fourOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.nineOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fourOfDiamonds();
        gameBloc.fourthDrawedCard = CardModel.sevenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.sevenOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasTwoPairs, true);
        expect(results['result'].pairOf, 1);
        expect(results['hand'], 'Dois Pares');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('''player two should win because has a higher pair with a hand 
        [
          1  - diamonds
          1  - spades
        ]
        and the board 
        [
          5  - diamonds
          9  - spades
          4  - diamonds
          7  - hearts
          7  - clubs
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.threeOfDiamonds(),
          CardModel.fourOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfDiamonds(),
          CardModel.aceOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.nineOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fourOfDiamonds();
        gameBloc.fourthDrawedCard = CardModel.sevenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.sevenOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasTwoPairs, true);
        expect(results['result'].pairOf, 1);
        expect(results['hand'], 'Dois Pares');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('''player one should win because has a higher pair with a hand 
        [
          11  - diamonds
          11  - spades
        ]
        and the board 
        [
          5  - diamonds
          9  - spades
          4  - diamonds
          7  - hearts
          7  - clubs
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.elevenOfDiamonds(),
          CardModel.elevenOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.threeOfDiamonds(),
          CardModel.fourOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.nineOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fourOfDiamonds();
        gameBloc.fourthDrawedCard = CardModel.sevenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.sevenOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasTwoPairs, true);
        expect(results['result'].pairOf, 7);
        expect(results['hand'], 'Dois Pares');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('''player one should win because has a higher pair with a hand 
        [
          11  - diamonds
          11  - spades
        ]
        and the board 
        [
          5  - diamonds
          9  - spades
          4  - diamonds
          10  - hearts
          7  - clubs
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.elevenOfDiamonds(),
          CardModel.elevenOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.twoOfSpades(),
          CardModel.twoOfDiamonds(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.nineOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fourOfDiamonds();
        gameBloc.fourthDrawedCard = CardModel.tenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.sevenOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasOnePair, true);
        expect(results['result'].pairOf, 11);
        expect(results['hand'], 'Um Par');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('''player two should win because has a higher pair with a hand 
        [
          11  - diamonds
          11  - spades
        ]
        and the board 
        [
          5  - diamonds
          9  - spades
          4  - diamonds
          10  - hearts
          7  - clubs
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.twoOfSpades(),
          CardModel.twoOfDiamonds(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.elevenOfDiamonds(),
          CardModel.elevenOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.nineOfSpades();
        gameBloc.thirdDrawedCard = CardModel.fourOfDiamonds();
        gameBloc.fourthDrawedCard = CardModel.tenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.sevenOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasOnePair, true);
        expect(results['result'].pairOf, 11);
        expect(results['hand'], 'Um Par');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('''player two should win because has a higher pair with a hand 
        [
          11  - diamonds
          11  - spades
        ]
        and the board 
        [
          5  - diamonds
          9  - spades
          7  - diamonds
          10  - hearts
          7  - clubs
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.twoOfSpades(),
          CardModel.twoOfDiamonds(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.elevenOfDiamonds(),
          CardModel.elevenOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.nineOfSpades();
        gameBloc.thirdDrawedCard = CardModel.sevenOfDiamonds();
        gameBloc.fourthDrawedCard = CardModel.tenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.sevenOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasTwoPairs, true);
        expect(results['result'].pairOf, 7);
        expect(results['hand'], 'Dois Pares');
        expect(results['winner'], gameBloc.playerTwo);
      });

      test('''player one should win because has a higher pair with a hand 
        [
          1  - diamonds
          1  - spades
        ]
        and the board 
        [
          5  - diamonds
          9  - spades
          7  - diamonds
          10  - hearts
          3  - clubs
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.aceOfDiamonds(),
          CardModel.aceOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.elevenOfDiamonds(),
          CardModel.elevenOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.nineOfSpades();
        gameBloc.thirdDrawedCard = CardModel.sevenOfDiamonds();
        gameBloc.fourthDrawedCard = CardModel.tenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.threeOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasOnePair, true);
        expect(results['result'].pairOf, 1);
        expect(results['hand'], 'Um Par');
        expect(results['winner'], gameBloc.playerOne);
      });

      test('''player two should win because has a higher pair with a hand 
        [
          1  - diamonds
          1  - spades
        ]
        and the board 
        [
          5  - diamonds
          9  - spades
          7  - diamonds
          10  - hearts
          3  - clubs
        ]
        ''', () {
        gameBloc.playerOneHand = HandModel(cards: [
          CardModel.elevenOfDiamonds(),
          CardModel.elevenOfSpades(),
        ]);
        gameBloc.playerTwoHand = HandModel(cards: [
          CardModel.aceOfDiamonds(),
          CardModel.aceOfSpades(),
        ]);
        gameBloc.firstDrawedCard = CardModel.fiveOfDiamonds();
        gameBloc.secondDrawedCard = CardModel.nineOfSpades();
        gameBloc.thirdDrawedCard = CardModel.sevenOfDiamonds();
        gameBloc.fourthDrawedCard = CardModel.tenOfHearts();
        gameBloc.fifthDrawedCard = CardModel.threeOfClubs();
        final results = gameBloc.calculateResults();
        expect(results['result'].hasOnePair, true);
        expect(results['result'].pairOf, 1);
        expect(results['hand'], 'Um Par');
        expect(results['winner'], gameBloc.playerTwo);
      });
    });
  });
}
