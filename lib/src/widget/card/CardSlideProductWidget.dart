import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/Patrocinador.dart';
import 'package:virtual_match/src/service/MultimediaService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class CardSlideWidget extends StatefulWidget {
  @override
  _CardSlideWidgetState createState() => _CardSlideWidgetState();
}

class _CardSlideWidgetState extends State<CardSlideWidget> {
  Patrocinador patrocinador = new Patrocinador();
  MultimediaService entityService = new MultimediaService();
  MultimediaService entityGet = MultimediaService();
  List<Patrocinador> lista = new List<Patrocinador>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getPatrocinador(new Patrocinador()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              lista = new List<Patrocinador>();
              return loading();
              break;
            default:
              if (snapshot.data.length > 0) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  lista.add((snapshot.data[i] as Patrocinador));
                }
                return listView(lista);
              }
          }
        });
  }

  Widget listView(List<Patrocinador> lista) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: AppTheme.themeDefault,
          highlightColor: AppTheme.themePurple,
          child: AutoSizeText(
            'patrocinadores'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GFCarousel(
          autoPlay: true,
          aspectRatio: 4.5,
          items: lista.map(
            (url) {
              return Container(
                margin: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(
                    url.url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ).toList(),
          onPageChanged: (index) {
            index;
          },
        ),
      ],
    );
  }
}

class CardSlideBalckWidget extends StatefulWidget {
  @override
  _CardSlideBalckWidgetState createState() => _CardSlideBalckWidgetState();
}

class _CardSlideBalckWidgetState extends State<CardSlideBalckWidget> {
  Patrocinador patrocinador = new Patrocinador();
  MultimediaService entityService = new MultimediaService();
  MultimediaService entityGet = MultimediaService();
  List<Patrocinador> lista = new List<Patrocinador>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getPatrocinador(new Patrocinador()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              lista = new List<Patrocinador>();
              return loading();
              break;
            default:
              if (snapshot.data.length > 0) {
                for (var i = 0; i < snapshot.data.length; i++) {
                  lista.add((snapshot.data[i] as Patrocinador));
                }
                return listView(lista);
              }
          }
        });
  }

  Widget listView(List<Patrocinador> lista) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: AppTheme.themeWhite,
          highlightColor: AppTheme.themePurple,
          child: AutoSizeText(
            'patrocinadores'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GFCarousel(
          autoPlay: true,
          aspectRatio: 4.5,
          items: lista.map(
            (url) {
              return Container(
                margin: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(
                    url.url,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ).toList(),
          onPageChanged: (index) {
            index;
          },
        ),
      ],
    );
  }
}
