import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokergame/bloc/bloc.dart';
import 'package:pokergame/widget/poker_card.dart';
import 'package:pokergame/widget/poker_hand.dart';

import 'card_placeholder.dart';
import 'player_info.dart';
import 'poker_back_card.dart';

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF35654d),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                PlayerInfo(context.bloc<GameBloc>().playerOne),
                PokerHand(context.bloc<GameBloc>().playerOneHand),
                Spacer(),
                PlayerInfo(context.bloc<GameBloc>().playerTwo),
                PokerHand(context.bloc<GameBloc>().playerTwoHand),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => context.bloc<GameBloc>().add(TapOnDeck()),
                  child: PokerBackCard(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 2),
                    switchInCurve: Curves.fastOutSlowIn,
                    child: context.bloc<GameBloc>().firstDrawedCard != null
                        ? PokerCard(context.bloc<GameBloc>().firstDrawedCard)
                        : CardPlaceholder(),
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 2),
                    switchInCurve: Curves.fastOutSlowIn,
                    child: context.bloc<GameBloc>().secondDrawedCard != null
                        ? PokerCard(context.bloc<GameBloc>().secondDrawedCard)
                        : CardPlaceholder(),
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 2),
                    switchInCurve: Curves.fastOutSlowIn,
                    child: context.bloc<GameBloc>().thirdDrawedCard != null
                        ? PokerCard(context.bloc<GameBloc>().thirdDrawedCard)
                        : CardPlaceholder(),
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 2),
                    switchInCurve: Curves.fastOutSlowIn,
                    child: context.bloc<GameBloc>().fourthDrawedCard != null
                        ? PokerCard(context.bloc<GameBloc>().fourthDrawedCard)
                        : CardPlaceholder(),
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 2),
                    switchInCurve: Curves.fastOutSlowIn,
                    child: context.bloc<GameBloc>().fifthDrawedCard != null
                        ? PokerCard(context.bloc<GameBloc>().fifthDrawedCard)
                        : CardPlaceholder(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
