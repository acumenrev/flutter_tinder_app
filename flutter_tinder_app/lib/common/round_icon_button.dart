import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  RoundIconButton.large({
    this.icon,
    this.iconColor,
    this.onPressed
  }) : size = 60.0;


  RoundIconButton.small({
    this.icon,
    this.iconColor,
    this.onPressed
  }) : size = 50.0;

  RoundIconButton({
    this.icon,
    this.iconColor,
    this.size,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          new BoxShadow(
            color: const Color(0x11000000),
            blurRadius: 10.0
          )
        ],
      ),
      child: new RawMaterialButton(
          onPressed: onPressed,
        shape: new CircleBorder(),
        child: new Icon(
          icon,
          color: iconColor,
        ),
      ),
    );    
  }
}
