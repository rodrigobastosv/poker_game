import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/bloc/bloc.dart';

void main() {
  group('GameEvent tests', () {
    test('events', () {
      expect(StartGame(), StartGame());
      expect(TapOnDeck(), TapOnDeck());
      expect(EndGame(), EndGame());
    });
  });
}
