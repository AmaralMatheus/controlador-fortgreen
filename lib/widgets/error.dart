import 'package:flutter/material.dart';

class CenteredErrorItem extends StatelessWidget {
  final Color color;

  CenteredErrorItem({
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) => Container(
        color: this.color,
        child: Center(child: Text('Ocorreu um erro.')),
      );
}

class CenteredErrorPage extends StatelessWidget {
  final Color color;
  final bool isClose;

  CenteredErrorPage({
    this.color = Colors.white,
    this.isClose = true,
  });

  Widget _buildClose(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 128.0),
        child: FloatingActionButton(
          child: Icon(Icons.close, size: 20.0),
          backgroundColor: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          mini: true,
          tooltip: 'Fechar',
        ),
      );

  Widget _buildBack(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 128.0),
        child: FloatingActionButton(
          child: Icon(Icons.close, size: 20.0),
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
          body: Center(child: Text('Ocorreu um erro.')),
          floatingActionButton: this.isClose
              ? this._buildClose(context)
              : this._buildBack(context),
          floatingActionButtonLocation: this.isClose
              ? FloatingActionButtonLocation.endTop
              : FloatingActionButtonLocation.startTop,
        ),
      );
}
