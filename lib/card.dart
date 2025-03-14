import 'package:flutter/material.dart';

class PlayingCard {
  bool facingFront;
  AssetImage frontImage;
  AssetImage backImage = AssetImage("assets/zback.jpg");
  PlayingCard({required this.frontImage, this.facingFront = false});

  void flip() {
    facingFront = !facingFront;
  }

  AssetImage get image => facingFront ? frontImage : backImage;
}
