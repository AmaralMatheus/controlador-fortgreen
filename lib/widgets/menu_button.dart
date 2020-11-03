import 'package:flutter/material.dart';

import '../colors.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final String image;
  final Color color;
  final Function onPressed;

  MenuButton(
      {this.label,
      this.image,
      this.color = Palette.greenMossLight,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double width040 = MediaQuery.of(context).size.width * 0.4;
    final double width010 = MediaQuery.of(context).size.width * 0.1;

    return Container(
      width: width040,
      height: width040,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [BoxShadow(color: Colors.grey[200], blurRadius: 20.0)],
      ),
      child: RaisedButton(
        elevation: 0,
        color: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        onPressed: this.onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: width040,
          height: MediaQuery.of(context).size.width * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: width010,
                width: width010,
                child: Image.asset('assets/png/icons/' + this.image, width: 30),
              ),
              Container(
                height: width010 * 2,
                alignment: Alignment.bottomLeft,
                child: Text(
                  this.label,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.036,
                    fontWeight: FontWeight.bold,
                    color: Palette.lightGrey,
                  ),
                ),
              ),
              Container(
                height: 3,
                width: width010 * 1.5,
                decoration: BoxDecoration(
                  color: this.color,
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
