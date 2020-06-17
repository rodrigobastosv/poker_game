import 'package:avataaar_image/avataaar_image.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokergame/bloc/bloc.dart';
import 'package:pokergame/model/card_model.dart';
import 'package:pokergame/model/hand_model.dart';
import 'package:pokergame/model/player_model.dart';
import 'package:pokergame/model/result_model.dart';
import 'package:pokergame/page/board_page.dart';
import 'package:pokergame/page/board_page_connected.dart';
import 'package:pokergame/widget/board.dart';
import 'package:pokergame/widget/play_again_button.dart';
import 'package:pokergame/widget/poker_back_card.dart';

import '../mock.dart';

void main() {
  MockGameBloc mockGameBloc;

  tearDown(() {
    mockGameBloc.close();
  });

  group('BoardPage tests', () {
    setUp(() {
      mockGameBloc = MockGameBloc();
    });

    testWidgets('shoul build without exploding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BoardPageConnected(),
        ),
      );
      expect(find.byType(BoardPage), findsOneWidget);
    });

    testWidgets('shoul build page without exploding', (tester) async {
      when(mockGameBloc.state).thenReturn(InitialGameState());
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<GameBloc>(
            create: (_) => mockGameBloc,
            child: BoardPage(),
          ),
        ),
      );
      expect(find.byType(BoardPage), findsOneWidget);
    });

    testWidgets('shoul show board when game starts', (tester) async {
      when(mockGameBloc.state).thenReturn(GameStarted());
      when(mockGameBloc.playerOne).thenReturn(
        PlayerModel(
          name: 'jogador 1',
          avatar: Avataaar.random(),
        ),
      );
      when(mockGameBloc.playerOneHand).thenReturn(
        HandModel(
          cards: [
            CardModel.aceOfClubs(),
            CardModel.tenOfSpades(),
          ],
        ),
      );
      when(mockGameBloc.playerTwo).thenReturn(
        PlayerModel(
          name: 'jogador 2',
        ),
      );
      when(mockGameBloc.playerTwoHand).thenReturn(
        HandModel(
          cards: [
            CardModel.sevenOfDiamonds(),
            CardModel.sevenOfHearts(),
          ],
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<GameBloc>(
            create: (_) => mockGameBloc,
            child: BoardPage(),
          ),
        ),
      );
      expect(find.byType(Board), findsOneWidget);
      final deck = find.byType(PokerBackCard);
      expect(deck, findsOneWidget);
      await tester.tap(deck);
      verify(mockGameBloc.add(TapOnDeck())).called(1);
    });

    testWidgets('shoul show snackbar announcing winner', (tester) async {
      final playerOne = PlayerModel(name: 'jogador 1');
      when(mockGameBloc.state).thenReturn(GameStarted());
      whenListen(
        mockGameBloc,
        Stream<GameState>.fromIterable([
          GameStarted(),
          WinningPlayerAnnounced(
            {
              'result': ResultModel(
                hasFlush: true,
              ),
              'winner': playerOne,
              'hand': 'Flush',
            },
          ),
        ]),
      );
      when(mockGameBloc.playerOne).thenReturn(playerOne);
      when(mockGameBloc.playerOneHand).thenReturn(
        HandModel(
          cards: [
            CardModel.aceOfClubs(),
            CardModel.tenOfSpades(),
          ],
        ),
      );
      when(mockGameBloc.playerTwo).thenReturn(
        PlayerModel(
          name: 'jogador 2',
        ),
      );
      when(mockGameBloc.playerTwoHand).thenReturn(
        HandModel(
          cards: [
            CardModel.sevenOfDiamonds(),
            CardModel.sevenOfHearts(),
          ],
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<GameBloc>(
            create: (_) => mockGameBloc,
            child: BoardPage(),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(Board), findsOneWidget);
      expect(find.byType(Flushbar), findsOneWidget);
      final playAgainBtn = find.byType(PlayAgainButton);
      expect(playAgainBtn, findsOneWidget);
    });

    testWidgets('shoul show snackbar announcing winner with avatar',
        (tester) async {
      final playerOne = PlayerModel(
        name: 'jogador 1',
        avatar: Avataaar.random(),
      );
      when(mockGameBloc.state).thenReturn(GameStarted());
      whenListen(
        mockGameBloc,
        Stream<GameState>.fromIterable([
          GameStarted(),
          WinningPlayerAnnounced(
            {
              'result': ResultModel(
                hasFlush: true,
              ),
              'winner': playerOne,
              'hand': 'Flush',
            },
          ),
        ]),
      );
      when(mockGameBloc.playerOne).thenReturn(playerOne);
      when(mockGameBloc.playerOneHand).thenReturn(
        HandModel(
          cards: [
            CardModel.aceOfClubs(),
            CardModel.tenOfSpades(),
          ],
        ),
      );
      when(mockGameBloc.playerTwo).thenReturn(
        PlayerModel(
          name: 'jogador 2',
        ),
      );
      when(mockGameBloc.playerTwoHand).thenReturn(
        HandModel(
          cards: [
            CardModel.sevenOfDiamonds(),
            CardModel.sevenOfHearts(),
          ],
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<GameBloc>(
            create: (_) => mockGameBloc,
            child: BoardPage(),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(Board), findsOneWidget);
      expect(find.byType(Flushbar), findsOneWidget);
      final playAgainBtn = find.byType(PlayAgainButton);
      expect(playAgainBtn, findsOneWidget);
    });

    testWidgets('shoul show drawed cards', (tester) async {
      final playerOne = PlayerModel(
        name: 'jogador 1',
        avatar: Avataaar.random(),
      );
      when(mockGameBloc.state).thenReturn(GameStarted());
      when(mockGameBloc.playerOne).thenReturn(playerOne);
      when(mockGameBloc.playerOneHand).thenReturn(
        HandModel(
          cards: [
            CardModel.aceOfClubs(),
            CardModel.tenOfSpades(),
          ],
        ),
      );
      when(mockGameBloc.playerTwo).thenReturn(
        PlayerModel(
          name: 'jogador 2',
        ),
      );
      when(mockGameBloc.playerTwoHand).thenReturn(
        HandModel(
          cards: [
            CardModel.sevenOfDiamonds(),
            CardModel.sevenOfHearts(),
          ],
        ),
      );
      when(mockGameBloc.firstDrawedCard).thenReturn(CardModel.sevenOfHearts());
      when(mockGameBloc.secondDrawedCard).thenReturn(CardModel.twoOfClubs());
      when(mockGameBloc.thirdDrawedCard).thenReturn(CardModel.fiveOfClubs());
      when(mockGameBloc.fourthDrawedCard).thenReturn(CardModel.fiveOfSpades());
      when(mockGameBloc.fifthDrawedCard).thenReturn(CardModel.tenOfClubs());
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<GameBloc>(
            create: (_) => mockGameBloc,
            child: BoardPage(),
          ),
        ),
      );
    });
  });
}
