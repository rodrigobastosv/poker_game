import 'package:bloc_test/bloc_test.dart';
import 'package:pokergame/bloc/bloc.dart';

class MockGameBloc extends MockBloc<GameEvent, GameState> implements GameBloc {}
