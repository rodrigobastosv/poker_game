import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Driver tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      print(health.status);
    });

    test('should land on InitialPage', () async {
      expect(driver.waitFor(find.byType('InitialPage')), completes);
    });

    test('should init the game', () async {
      final tutorialButton = find.text('INICIAR');
      await driver.tap(tutorialButton);
      expect(driver.waitFor(find.byType('BoardPage')), completes);
      driver.waitUntilNoTransientCallbacks();
    });

    test('should draw cards as clicking on the deck', () async {
      final deck = find.byValueKey('deck');
      await driver.tap(deck);
      driver.waitUntilNoTransientCallbacks();
      await driver.tap(deck);
      driver.waitUntilNoTransientCallbacks();
      await driver.tap(deck);
      driver.waitUntilNoTransientCallbacks();
      await driver.tap(deck);
      driver.waitUntilNoTransientCallbacks();
      await driver.tap(deck);
      driver.waitUntilNoTransientCallbacks();
      await driver.tap(deck);
      driver.waitUntilNoTransientCallbacks();
    });
  });
}
