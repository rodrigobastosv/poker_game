import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokergame/bloc/bloc.dart';
import 'package:pokergame/page/board_page.dart';

class BoardPageConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameBloc()..add(StartGame()),
      child: SafeArea(
        child: BoardPage(),
      ),
    );
  }
}
