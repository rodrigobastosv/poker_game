import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:pokergame/model/player_model.dart';

class PlayerInfo extends StatelessWidget {
  PlayerInfo(this.player, {GlobalKey key}) : super(key: key);

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        player.avatar != null
            ? AvataaarImage(
                avatar: player.avatar,
                errorImage: Icon(Icons.error),
                placeholder: CircularProgressIndicator(),
                width: 40,
              )
            : CircleAvatar(
                child: Icon(
                  Icons.person_pin,
                  size: 40,
                ),
              ),
        const SizedBox(height: 8),
        Text(
          player.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
