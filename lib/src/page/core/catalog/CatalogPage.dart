import 'package:flutter/material.dart';
import 'package:virtual_match/src/widget/card/CardSwiperWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class CatalogPage extends StatelessWidget {
  //final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    // peliculasProvider.getPopulares();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Catalogo de Productos'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //   showSearch(
                //     context: context,
                //  //   delegate: DataSearch(),
                //     // query: 'Hola'
                //     );
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTarjetas(), _footer(context)],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      // future: (){},// peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(height: 400.0, child: Center(child: loading()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 5.0),

          // StreamBuilder(
          //   stream: (){},// peliculasProvider.popularesStream,
          //   builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

          //     if ( snapshot.hasData ) {
          //       return MovieHorizontal(
          //         peliculas: snapshot.data,
          //         siguientePagina: peliculasProvider.getPopulares,
          //       );
          //     } else {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
