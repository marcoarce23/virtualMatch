import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:virtual_match/src/model/entity/EntityMap.dart';

class CardSwiper extends StatelessWidget {
  final List<ProductModel> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          // peliculas[index].idBrandModel= '${ peliculas[index].idBrandModel.toString() }-tarjeta';

          return Hero(
            tag: peliculas[index].idBrandModel,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'Detalle',
                      arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].photo),
                    placeholder: AssetImage('assets/image/mario_logo.png'),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
        itemCount: peliculas.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}
