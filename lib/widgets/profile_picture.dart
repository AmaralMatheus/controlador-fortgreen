import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../colors.dart';

class ProfilePicture extends StatelessWidget {
  final double width;
  final double height;

  ProfilePicture({this.height = 125, this.width = 125});

  @override
  Widget build(BuildContext context) {
    //Equivalente a -> (cooperado.imagemPerfilUrl.isEmpty || cooperado.imagemPerfilUrl == null)
    // mas nao quebra ao fazer '.isEmpty' quando a string for null

    return Container(
      width: this.height,
      height: this.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(50),
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        color: Palette.greenMedium,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'imagemPerfilUrl'
          ),
        )
      ),
      child: Center(
        child: Text(
          'cooperado',
          style: TextStyle(
            color: Colors.white,
            fontSize: this.height * 0.7,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
