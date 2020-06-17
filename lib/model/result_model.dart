class ResultModel {
  ResultModel({
    this.hasOnePair,
    this.pairOf,
    this.hasTwoPairs,
    this.hasThreeCards,
    this.hasSequence,
    this.hasFlush,
    this.hasFullHouse,
    this.hasFourCards,
    this.hasStraightFlush,
    this.hasRoyalStraightFlush,
    this.highestCard,
  });

  final bool hasOnePair;
  final int pairOf;
  final bool hasTwoPairs;
  final bool hasThreeCards;
  final bool hasSequence;
  final bool hasFlush;
  final bool hasFullHouse;
  final bool hasFourCards;
  final bool hasStraightFlush;
  final bool hasRoyalStraightFlush;
  final int highestCard;

  @override
  String toString() {
    return 'ResultModel{hasOnePair: $hasOnePair, hasTwoPairs: $hasTwoPairs, hasThreeCards: $hasThreeCards, hasSequence: $hasSequence, hasFlush: $hasFlush, hasFullHouse: $hasFullHouse, hasFourCards: $hasFourCards, hasStraightFlush: $hasStraightFlush, hasRoyalStraightFlush: $hasRoyalStraightFlush, highestCard: $highestCard}';
  }
}
