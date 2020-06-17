enum SuitEnum {
  clubs,
  diamonds,
  hearts,
  spades,
}

String getSuitFromEnum(SuitEnum suit) {
  switch (suit) {
    case SuitEnum.clubs:
      return 'clubs';
    case SuitEnum.diamonds:
      return 'diamonds';
    case SuitEnum.hearts:
      return 'hearts';
    case SuitEnum.spades:
      return 'spades';
  }
  return '';
}
