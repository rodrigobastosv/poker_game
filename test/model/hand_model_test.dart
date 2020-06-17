import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/model/hand_model.dart';

void main() {
  group('HandModel tests', () {
    test('toString', () {
      expect(HandModel(cards: []).toString(), 'HandModel{cards: []}');
    });

    test('equals', () {
      expect(HandModel(cards: []), HandModel(cards: []));
    });
  });
}
