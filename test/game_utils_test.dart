import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/model/board_model.dart';
import 'package:pokergame/model/card_model.dart';
import 'package:pokergame/model/hand_model.dart';
import 'package:pokergame/utils/game_utils.dart';

void main() {
  group('Game utils tests', () {
    test('generateRandomHand', () {
      final hand = generateRandomHand();
      expect(hand, isA<HandModel>());
    });

    group('cardMakesPair tests', () {
      test('first', () {
        final pair = cardMakesPair(
          CardModel.aceOfClubs(),
          BoardModel(
            [
              CardModel.aceOfHearts(),
              CardModel.threeOfHearts(),
              CardModel.fiveOfHearts(),
              CardModel.sevenOfHearts(),
              CardModel.tenOfHearts(),
            ],
          ),
        );
        expect(pair, isTrue);
      });
      test('second', () {
        final pair = cardMakesPair(
          CardModel.aceOfClubs(),
          BoardModel(
            [
              CardModel.threeOfHearts(),
              CardModel.aceOfHearts(),
              CardModel.fiveOfHearts(),
              CardModel.sevenOfHearts(),
              CardModel.tenOfHearts(),
            ],
          ),
        );
        expect(pair, isTrue);
      });
      test('third', () {
        final pair = cardMakesPair(
          CardModel.aceOfClubs(),
          BoardModel(
            [
              CardModel.threeOfHearts(),
              CardModel.fiveOfHearts(),
              CardModel.aceOfHearts(),
              CardModel.sevenOfHearts(),
              CardModel.tenOfHearts(),
            ],
          ),
        );
        expect(pair, isTrue);
      });
      test('fourth', () {
        final pair = cardMakesPair(
          CardModel.aceOfClubs(),
          BoardModel(
            [
              CardModel.threeOfHearts(),
              CardModel.fiveOfHearts(),
              CardModel.sevenOfHearts(),
              CardModel.aceOfHearts(),
              CardModel.tenOfHearts(),
            ],
          ),
        );
        expect(pair, isTrue);
      });
      test('fifth', () {
        final pair = cardMakesPair(
          CardModel.aceOfClubs(),
          BoardModel(
            [
              CardModel.threeOfHearts(),
              CardModel.fiveOfHearts(),
              CardModel.sevenOfHearts(),
              CardModel.tenOfHearts(),
              CardModel.aceOfHearts(),
            ],
          ),
        );
        expect(pair, isTrue);
      });
    });
  });
}
