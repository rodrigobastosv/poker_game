import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class StartGame extends GameEvent {
  @override
  List<Object> get props => [];
}

class TapOnDeck extends GameEvent {
  @override
  List<Object> get props => [];
}

class EndGame extends GameEvent {
  @override
  List<Object> get props => [];
}
