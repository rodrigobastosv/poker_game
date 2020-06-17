import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokergame/page/board_page_connected.dart';

import 'tutorial_page.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/poker.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 64),
              child: Text(
                'Poker Game',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 48,
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(38),
                      child: RaisedButton(
                        key: const ValueKey('iniciar-btn'),
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => BoardPageConnected(),
                          ),
                        ),
                        child: Text('INICIAR'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(38),
                      child: RaisedButton(
                        key: const ValueKey('tutorial-btn'),
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => TutorialPage(),
                          ),
                        ),
                        child: Text('TUTORIAL'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
