import 'package:avataaar_image/avataaar_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokergame/bloc/bloc.dart';
import 'package:pokergame/page/board_page_connected.dart';
import 'package:pokergame/widget/board.dart';

class BoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GameBloc, GameState>(
        listener: (_, state) {
          if (state is WinningPlayerAnnounced) {
            final results = state.results;
            Flushbar(
              dismissDirection: FlushbarDismissDirection.VERTICAL,
              icon: AvataaarImage(
                avatar: results['winner'].avatar,
                errorImage: Icon(Icons.error),
                width: 40,
              ),
              mainButton: FlatButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (_) => BoardPageConnected(),
                  ),
                ),
                child: Text(
                  'JOGAR NOVAMENTE',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              messageText: Text(
                '${results['winner'].name} ganhou com ${results['hand']}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            )..show(context);
          }
        },
        builder: (_, state) {
          if (state is InitialGameState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Board();
        },
      ),
    );
  }
}
