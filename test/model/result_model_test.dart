import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/model/result_model.dart';

void main() {
  test('toString', () {
    expect(ResultModel().toString(),
        'ResultModel{hasOnePair: null, hasTwoPairs: null, hasThreeCards: null, hasSequence: null, hasFlush: null, hasFullHouse: null, hasFourCards: null, hasStraightFlush: null, hasRoyalStraightFlush: null, highestCard: null}');
  });
}
