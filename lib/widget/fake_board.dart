import 'package:flutter/material.dart';
import 'package:pokergame/model/card_model.dart';
import 'package:pokergame/model/hand_model.dart';
import 'package:pokergame/model/player_model.dart';
import 'package:pokergame/model/suit_enum.dart';
import 'package:pokergame/page/board_page_connected.dart';
import 'package:pokergame/widget/poker_hand.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'card_placeholder.dart';
import 'player_info.dart';
import 'poker_back_card.dart';

class FakeBoard extends StatefulWidget {
  @override
  _FakeBoardState createState() => _FakeBoardState();
}

class _FakeBoardState extends State<FakeBoard> {
  List<TargetFocus> targets = [];

  GlobalKey initialKey = GlobalKey();
  GlobalKey playerOneKey = GlobalKey();
  GlobalKey playerOneCardKey = GlobalKey();
  GlobalKey playerTwoKey = GlobalKey();
  GlobalKey playerTwoCardKey = GlobalKey();
  GlobalKey deckKey = GlobalKey();
  GlobalKey placeholderKey = GlobalKey();

  @override
  void initState() {
    targets.add(
      TargetFocus(
        identify: "Target qqqqq",
        keyTarget: initialKey,
        contents: [
          ContentTarget(
            align: AlignContent.right,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Bem vindo ao POKER GAME!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Simule resultados de um jogo de poker :-)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: playerOneKey,
        contents: [
          ContentTarget(
            align: AlignContent.right,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Informações do jogador 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Aqui você observa informações do jogador 1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 11",
        keyTarget: playerOneCardKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Cartas do jogador 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: playerTwoKey,
        contents: [
          ContentTarget(
            align: AlignContent.left,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Informações do jogador 2',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Aqui você observa informações do jogador 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 22",
        keyTarget: playerTwoCardKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Cartas do jogador 2',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 3",
        keyTarget: deckKey,
        contents: [
          ContentTarget(
            align: AlignContent.right,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Deck de cartas',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Pressione o Deck para que uma nova carta possa ser entregue a mesa!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: placeholderKey,
        contents: [
          ContentTarget(
            align: AlignContent.right,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Ao virar uma nova carta ela vai se posicionar neste espaço da mesa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showTutorial(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('fake-board'),
      color: Color(0xFF35654d),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                PlayerInfo(
                  PlayerModel(
                    name: 'Jogador 1',
                  ),
                  key: playerOneKey,
                ),
                PokerHand(
                  HandModel(
                    cards: [
                      CardModel(
                        value: 2,
                        suit: SuitEnum.clubs,
                      ),
                      CardModel(
                        value: 9,
                        suit: SuitEnum.clubs,
                      ),
                    ],
                  ),
                  key: playerOneCardKey,
                ),
                Spacer(key: initialKey),
                PlayerInfo(
                  PlayerModel(
                    name: 'Jogador 2',
                  ),
                  key: playerTwoKey,
                ),
                PokerHand(
                  HandModel(
                    cards: [
                      CardModel(
                        value: 1,
                        suit: SuitEnum.diamonds,
                      ),
                      CardModel(
                        value: 12,
                        suit: SuitEnum.spades,
                      ),
                    ],
                  ),
                  key: playerTwoCardKey,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              key: ValueKey('row'),
              children: <Widget>[
                PokerBackCard(key: deckKey),
                const SizedBox(width: 16),
                Expanded(
                  child: CardPlaceholder(key: placeholderKey),
                ),
                Expanded(
                  child: CardPlaceholder(),
                ),
                Expanded(
                  child: CardPlaceholder(),
                ),
                Expanded(
                  child: CardPlaceholder(),
                ),
                Expanded(
                  child: CardPlaceholder(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showTutorial() {
    TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.lightBlue.withOpacity(0.5),
      textSkip: 'PULAR',
      finish: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BoardPageConnected(),
        ),
      ),
      clickSkip: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BoardPageConnected(),
        ),
      ),
    )..show();
  }
}
