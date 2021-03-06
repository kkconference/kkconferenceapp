

import 'package:flutter/material.dart';
import 'package:kk_conferences/global/constants.dart';

class GradientButton extends StatelessWidget {
  Function onpress;
  double width;
  double height;
  String text;


  GradientButton({this.onpress, this.width, this.height,this.text=""});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: onpress,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        height: height,
        width:width ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: color_grid,
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
