import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<dynamic> images;
  final BoxFit boxFit;
  final bool network;

  CarouselWithIndicator(
      {this.images, this.network = false, this.boxFit = BoxFit.cover});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState(
        images: this.images,
        network: this.network,
      );
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  final List<dynamic> images;
  int _current = 0;
  final bool network;
  final BoxFit boxFit;

  _CarouselWithIndicatorState({this.images, this.network, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: image['function'],
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: this.network
                            ? NetworkImage(image['path'].toString())
                            : AssetImage(image['path'].toString()),
                        fit: BoxFit.fitWidth
                      ),
                  ),
                ),
              );
            },
          );
        }).toList(),
        viewportFraction: 1.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.map((image) {
                return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.grey),
                        color: images.indexOf(image) == _current
                            ? Colors.grey
                            : Colors.transparent));
              }).toList()))
    ]);
  }
}
