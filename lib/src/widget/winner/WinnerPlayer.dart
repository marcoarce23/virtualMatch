import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.of(context).size.width - 75,
        height: 170,
        child: Stack(
          children: <Widget>[
            Positioned(
              //left: (MediaQuery.of(context).size.width / 2) - 130,
              top: 0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                    child: Shimmer.fromColors(
                  baseColor: AppTheme.themeDefault,
                  highlightColor: AppTheme.themePurple,
                  child: AutoSizeText(
                    nombreTorneo.toUpperCase(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
              ),
            ),
            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 150,
                top: 35,
                height: 68,
                width: 68,
                child: _cardJugador(false, url3erGanador)), // 3er lugar
            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 20,
                top: 30,
                height: 90,
                width: 90,
                child: _cardJugador(false, url2doGanador)), // 2do lugar
            Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 100,
                top: 30,
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
                  Shimmer.fromColors(
                    baseColor: AppTheme.themeDefault,
                    highlightColor: AppTheme.themePurple,
                    child: AutoSizeText(
                      '3º LUGAR',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                    Shimmer.fromColors(
                      baseColor: AppTheme.themeDefault,
                      highlightColor: AppTheme.themePurple,
                      child: AutoSizeText(
                        '2º LUGAR',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                    Shimmer.fromColors(
                      baseColor: AppTheme.themeDefault,
                      highlightColor: AppTheme.themePurple,
                      child: AutoSizeText(
                        '1º LUGAR',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
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
