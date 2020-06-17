import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/bloc/bloc.dart';

void main() {
  group('GameState tests', () {
    test('states', () {
      expect(InitialGameState(), InitialGameState());
      expect(GameStarted(), GameStarted());
      expect(FirstCardDrawed(), FirstCardDrawed());
      expect(SecondCardDrawed(), SecondCardDrawed());
      expect(ThirdCardDrawed(), ThirdCardDrawed());
      expect(FourthCardDrawed(), FourthCardDrawed());
      expect(FifthCardDrawed(), FifthCardDrawed());
      expect(WinningPlayerAnnounced({}), WinningPlayerAnnounced({}));
    });
  });
}
