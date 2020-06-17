import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokergame/page/board_page_connected.dart';

class PlayAgainButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: const ValueKey('play-again-btn'),
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
    );
  }
}
