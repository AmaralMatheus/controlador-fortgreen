import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../colors.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final double size;

  final Map<int, List<bool>> _stars = {
    0: [false, false, false, false, false],
    1: [true, false, false, false, false],
    2: [true, true, false, false, false],
    3: [true, true, true, false, false],
    4: [true, true, true, true, false],
    5: [true, true, true, true, true],
  };

  StarRating({this.rating, this.size});

  @override
  Widget build(BuildContext context) {
    final Widget _starIcon =
        Icon(Icons.star, color: Palette.greenMossDark, size: size);
    final Widget _starBorderIcon =
        Icon(Icons.star_border, color: Palette.greenMossDark, size: size);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _stars[rating]
          .map<Widget>((item) => item ? _starIcon : _starBorderIcon)
          .toList(),
    );
  }
}
