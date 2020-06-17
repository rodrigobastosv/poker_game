import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/model/board_model.dart';

void main() {
  test('toString', () {
    expect(BoardModel([]).toString(), 'BoardModel{cardsOnBoard: []}');
  });
}
