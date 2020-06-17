#!/bin/bash

cd ..
echo '############################### Cleaning stuff ###############################'
flutter clean
flutter pub get
echo '############################### Running tests ################################'
flutter test --coverage
echo '############################### Removing generated files #####################'
flutter pub global run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '.g.dart$'
echo '############################### Generating coverage ##########################'
genhtml coverage/lcov.info -o coverage/html
