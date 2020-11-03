import 'package:flutter/widgets.dart';

class CustomSlideTransition extends PageRouteBuilder {
  final WidgetBuilder builder;
  final RouteSettings settings;
  final Offset direction;
  CustomSlideTransition({this.builder, this.settings, this.direction})
      : super(
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              builder(context),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: direction,
                  end: Offset.zero,
                ).animate(animation), 
                child: child
              )
        );
}
