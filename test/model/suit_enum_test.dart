import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/model/suit_enum.dart';

void main() {
  test('getSuitFromEnum', () {
    expect(getSuitFromEnum(SuitEnum.spades), 'spades');
    expect(getSuitFromEnum(SuitEnum.clubs), 'clubs');
    expect(getSuitFromEnum(SuitEnum.hearts), 'hearts');
    expect(getSuitFromEnum(SuitEnum.diamonds), 'diamonds');
  });
}
