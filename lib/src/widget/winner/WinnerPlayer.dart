import 'package:flutter/material.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';
import 'package:virtual_match/src/widget/util/Util.dart';

class WinnerPlayer extends StatelessWidget {
  String nombreTorneo;
  String url1erGanador;
  String nombre1erGanador;
  String url2doGanador;
  String nombre2doGanador;
  String url3erGanador;
  String nombre3erGanador;

  WinnerPlayer({
    this.nombreTorneo,
    this.url1erGanador,
    this.nombre1erGanador,
    this.url2doGanador,
    this.nombre2doGanador,
    this.url3erGanador,
    this.nombre3erGanador,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width - 75,
        height: 170,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: (MediaQuery.of(context).size.width / 2) - 100,
              top: 0,
              child: Center(
                child: Text(
                  nombreTorneo.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: AppTheme.themeWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 150,
                top: 25,
                height: 68,
                width: 68,
                child: _cardJugador(false, url3erGanador)), // 3er lugar
            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 20,
                top: 20,
                height: 90,
                width: 90,
                child: _cardJugador(false, url2doGanador)), // 2do lugar
            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 100,
                top: 20,
                height: 110,
                width: 110,
                child: _cardJugador(true, url1erGanador)), // 1erlugar

            Positioned(
              left: (MediaQuery.of(context).size.width / 2) - 160,
              top: 115,
              height: 80,
              width: 80,
              child: Column(
                children: [
                  Text(
                    '3º LUGAR',
                    style: TextStyle(
                      color: AppTheme.themeWhite,
                    ),
                  ),
                  Text(
                    nombre3erGanador,
                    style: TextStyle(
                      color: AppTheme.themeWhite,
                    ),
                  ),
                ],
              ),
            ), // 3er lugar
            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 10,
                top: 125,
                height: 90,
                width: 90,
                child: Column(
                  children: [
                    Text(
                      '2º LUGAR',
                      style: TextStyle(
                        color: AppTheme.themeWhite,
                      ),
                    ),
                    Text(
                      nombre2doGanador,
                      style: TextStyle(
                        color: AppTheme.themeWhite,
                      ),
                    ),
                  ],
                )), // 2do lugar
            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 90,
                top: 140,
                height: 110,
                width: 100,
                child: Column(
                  children: [
                    Text(
                      '1º LUGAR',
                      style: TextStyle(
                        color: AppTheme.themeWhite,
                      ),
                    ),
                    Text(
                      nombre1erGanador,
                      style: TextStyle(
                        color: AppTheme.themeWhite,
                      ),
                    ),
                  ],
                )),

            //Positioned(                          left: (MediaQuery.of(context).size.width / 2) - 50,                          child: _cardJugador()), //2do lugar
            //Positioned(                          left: (MediaQuery.of(context).size.width / 2),                          child: _cardJugador()), // 1er lugar
            //_ganadores((MediaQuery.of(context).size.width / 2) - 25),
            //_ganadores((MediaQuery.of(context).size.width / 2) + 25),
          ],
        ),
      ),
    );
  }

  Widget _cardJugador(bool remarcar, String url) {
    if (remarcar) {
      return RadialProgress(
        progressColor: Colors.purple,
        progressBackgroundColor: AppTheme.themeDefault,
        width: 4,
        goalCompleted: 0.85,
        child: Container(
            child: ImageOvalNetwork(
                imageNetworkUrl: url, sizeImage: Size(100, 100))),
      );
    } else {
      return ImageOvalNetwork(
        imageNetworkUrl: url,
        sizeImage: Size(100, 100),
      );
    }
  }
}
