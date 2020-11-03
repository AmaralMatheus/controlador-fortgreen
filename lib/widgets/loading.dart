import 'package:flutter/material.dart';

class CenteredLoadingItem extends StatelessWidget {
  final Color color, animationColor;

  CenteredLoadingItem(
      {this.color = Colors.transparent, this.animationColor = Colors.black});

  @override
  Widget build(BuildContext context) => Container(
        color: this.color,
        child: Center(
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(this.animationColor))),
      );
}

class CenteredLoadingPage extends StatelessWidget {
  final Color color;
  final bool isClose;

  CenteredLoadingPage({
    this.color = Colors.white,
    this.isClose = true,
  });

  Widget _buildClose(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 96.0),
        child: FloatingActionButton(
          child: Icon(Icons.close, size: 20.0),
          backgroundColor: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          mini: true,
          tooltip: 'Fechar',
        ),
      );

  Widget _buildBack(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 96.0),
        child: FloatingActionButton(
          child: Icon(Icons.arrow_back, size: 20.0),
          backgroundColor: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          mini: true,
          tooltip: 'Voltar',
        ),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          backgroundColor: this.color,
          body: Center(
              child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green))),
          floatingActionButton: this.isClose
              ? this._buildClose(context)
              : this._buildBack(context),
          floatingActionButtonLocation: this.isClose
              ? FloatingActionButtonLocation.endTop
              : FloatingActionButtonLocation.startTop,
        ),
      );
}
