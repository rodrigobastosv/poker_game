import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class InitialGameState extends GameState {
  @override
  List<Object> get props => [];
}

class GameStarted extends GameState {
  @override
  List<Object> get props => [];
}

class FirstCardDrawed extends GameState {
  @override
  List<Object> get props => [];
}

class SecondCardDrawed extends GameState {
  @override
  List<Object> get props => [];
}

class ThirdCardDrawed extends GameState {
  @override
  List<Object> get props => [];
}

class FourthCardDrawed extends GameState {
  @override
  List<Object> get props => [];
}

class FifthCardDrawed extends GameState {
  @override
  List<Object> get props => [];
}

class WinningPlayerAnnounced extends GameState {
  WinningPlayerAnnounced(this.results);

  final Map<String, dynamic> results;

  @override
  List<Object> get props => [results];
}
