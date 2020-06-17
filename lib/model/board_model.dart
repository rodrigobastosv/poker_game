import 'package:pokergame/model/card_model.dart';

class BoardModel {
  BoardModel(this.cardsOnBoard);

  final List<CardModel> cardsOnBoard;

  @override
  String toString() {
    return 'BoardModel{cardsOnBoard: $cardsOnBoard}';
  }
}
