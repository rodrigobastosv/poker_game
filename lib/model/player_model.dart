import 'package:avataaar_image/avataaar_image.dart';
import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  PlayerModel({this.name, this.avatar});

  final String name;
  final Avataaar avatar;

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'PlayerModel{name: $name}';
  }
}
