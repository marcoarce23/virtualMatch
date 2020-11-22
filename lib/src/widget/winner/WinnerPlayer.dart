import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';
import 'package:virtual_match/src/widget/util/Util.dart';
import 'package:confetti/confetti.dart';

class WinnerPlayer extends StatefulWidget {
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
  _WinnerPlayerState createState() => _WinnerPlayerState();
}

class _WinnerPlayerState extends State<WinnerPlayer> {
  ConfettiController _controllerCenter;

  ConfettiController _controllerCenterRight;

  ConfettiController _controllerCenterLeft;

  ConfettiController _controllerTopCenter;

  ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ConfettiWidget(
            confettiController: _controllerCenterRight,
            blastDirection: pi, // radial value - LEFT
            particleDrag: 0.05, // apply drag to the confetti
            emissionFrequency: 0.05, // how often it should emit
            numberOfParticles: 20, // number of particles to emit
            gravity: 0.05, // gravity - or fall speed
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink
            ], // manually specify the colors to be used
          ),
        ),
        Container(
          child: Container(
            decoration: containerImage2(),
            width: MediaQuery.of(context).size.width - 75,
            height: 190,
            child: Stack(
              children: <Widget>[
                Positioned(
                  //left: (MediaQuery.of(context).size.width / 2) - 130,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                        child:
                            //    Shimmer.fromColors(
                            // baseColor: AppTheme.themeWhite,
                            // highlightColor: AppTheme.themePurple,
                            // child:
                            AutoSizeText(
                      widget.nombreTorneo.toUpperCase(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppTheme.themeWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      //  ),
                    )),
                  ),
                ),
                Positioned(
                    left: (MediaQuery.of(context).size.width / 2) - 150,
                    top: 35,
                    height: 68,
                    width: 68,
                    child:
                        _cardJugador(false, widget.url3erGanador)), // 3er lugar
                Positioned(
                    left: (MediaQuery.of(context).size.width / 2) - 20,
                    top: 30,
                    height: 90,
                    width: 90,
                    child:
                        _cardJugador(false, widget.url2doGanador)), // 2do lugar
                Positioned(
                    left: (MediaQuery.of(context).size.width / 2) - 100,
                    top: 30,
                    height: 110,
                    width: 110,
                    child:
                        _cardJugador(true, widget.url1erGanador)), // 1erlugar

                Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 160,
                  top: 115,
                  height: 80,
                  width: 80,
                  child: Column(
                    children: [
                      AutoSizeText(
                        '3º LUGAR',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: AppTheme.themeWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.nombre3erGanador,
                        style: TextStyle(
                          color: AppTheme.themeWhite,
                        ),
                      ),
                    ],
                  ),
                ), // 3er lugar
                Positioned(
                    left: (MediaQuery.of(context).size.width / 2) + 10,
                    top: 125,
                    height: 90,
                    width: 90,
                    child: Center(
                      child: Column(
                        children: [
                          AutoSizeText(
                            '2º LUGAR',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 02.0,
                              color: AppTheme.themeWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.nombre2doGanador,
                            style: TextStyle(
                              color: AppTheme.themeWhite,
                            ),
                          ),
                        ],
                      ),
                    )), // 2do lugar
                Positioned(
                    left: (MediaQuery.of(context).size.width / 2) - 90,
                    top: 140,
                    height: 110,
                    width: 100,
                    child: Center(
                      child: Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppTheme.themeWhite,
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
                            widget.nombre1erGanador,
                            style: TextStyle(
                              color: AppTheme.themeWhite,
                            ),
                          ),
                        ],
                      ),
                    )),

                //Positioned(                          left: (MediaQuery.of(context).size.width / 2) - 50,                          child: _cardJugador()), //2do lugar
                //Positioned(                          left: (MediaQuery.of(context).size.width / 2),                          child: _cardJugador()), // 1er lugar
                //_ganadores((MediaQuery.of(context).size.width / 2) - 25),
                //_ganadores((MediaQuery.of(context).size.width / 2) + 25),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardJugador(bool remarcar, String url) {
    if (remarcar) {
      return RadialProgress(
        progressColor: Colors.purple,
        progressBackgroundColor: AppTheme.themeDefault,
        width: 5,
        goalCompleted: 0.85,
        child: Container(
            child: ImageOvalNetwork(
                imageNetworkUrl: url, sizeImage: Size(60, 60))),
      );
    } else {
      return ImageOvalNetwork(
        imageNetworkUrl: url,
        sizeImage: Size(60, 60),
      );
    }
  }
}
