import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/model/player_model.dart';

void main() {
  group('PlayerModel tests', () {
    test('equatable', () {
      expect(PlayerModel(name: 'rodrigo'), PlayerModel(name: 'rodrigo'));
      expect(PlayerModel(name: 'rodrigo') == PlayerModel(name: 'not rodrigo'),
          false);
    });

    test('toString', () {
      expect(PlayerModel(name: 'rodrigo').toString(),
          'PlayerModel{name: rodrigo}');
    });
  });
}
