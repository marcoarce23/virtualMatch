import 'package:flutter/material.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/page/people/InfluencerListPage.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';

class NotificationLocalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[100],
      child: SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Notificaciones virtual_match',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CloseButton()
                ],
              ),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    // Request amount
                    Container(
                      padding: const EdgeInsets.all(13.0),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ImageOvalNetwork(
                                  imageNetworkUrl:
                                      'https://res.cloudinary.com/propia/image/upload/v1594742564/xohvmqv9xtwhgvppqnbb.jpg',
                                  sizeImage: Size.fromWidth(70)),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                              text:
                                                  'Zapatillas deportivas para niños y niñas ortopédicos', //  'Nuevo Terreno en Sector 4A - Urbanización GArdenias',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextSpan(
                                            text: ' Precio de promoción ',
                                          ),
                                          TextSpan(
                                            text: '\$45.25 mensual',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: Colors.blue[700],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('Crear Producto',
                                        style:
                                            TextStyle(color: Colors.blue[700])),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.cancel,
                                    size: 14,
                                    color: Color(0xffF94D4D),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('Declinar',
                                        style: TextStyle(
                                            color: Color(0xffF94D4D))),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Send amount
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ImageOvalNetwork(
                                  imageNetworkUrl:
                                      'https://res.cloudinary.com/propia/image/upload/v1594742559/my0xpfznfp8anftntcbm.jpg',
                                  sizeImage: Size.fromWidth(70)),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                              text:
                                                  'Nueva temporada de ropa casula de invierno', //''Construcción de viviendas (Nuevo Servicio) ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextSpan(
                                            text:
                                                'Venta de ropa de varón', //' Construcción desde:',
                                          ),
                                          TextSpan(
                                            text: '\$39.99',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: Colors.blue[700],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('Crear Producto',
                                        style:
                                            TextStyle(color: Colors.blue[700])),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.cancel,
                                    size: 14,
                                    color: Color(0xffF94D4D),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('Declinar',
                                        style: TextStyle(
                                            color: Color(0xffF94D4D))),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Share your feedback.
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              SizedBox(
                                height: 110,
                                width: 110,
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    left: 5.0,
                                    bottom: -10.0,
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: ImageOvalNetwork(
                                            imageNetworkUrl: '',
                                            sizeImage: Size.fromWidth(35)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8.0,
                                    left: 10.0,
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: ImageOvalNetwork(
                                          imageNetworkUrl: IMAGE_LOGO,
                                          sizeImage: Size.fromWidth(35)),
                                    ),
                                  )
                                ]),
                              ),
                              Flexible(
                                child: Column(children: [
                                  Text(
                                      'Priorizar con los clientes la venta de los Servicios de  Delivery Express', //Construcción',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  SizedBox(height: 4.0),
                                  Text(
                                      'Fidelizar al cliente con el monto de la promoción de la nueva moda deportiva.',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12))
                                ]),
                              )
                            ]),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => ClientListPage())),
                            child: Container(
                                padding: const EdgeInsets.all(14.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffFDC054),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5.0),
                                        bottomLeft: Radius.circular(5.0))),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Ingresar a la página Web virtual_match'
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ))),
                          )
                        ],
                      ),
                    ),
                    // Track the product.
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              SizedBox(
                                height: 110,
                                width: 110,
                                child: Stack(children: <Widget>[
                                  Positioned(
                                    left: 5.0,
                                    bottom: -10.0,
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: Image.asset(
                                            'assets/bottom_yellow.png'),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8.0,
                                    left: 10.0,
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: ImageOvalNetwork(
                                          imageNetworkUrl: IMAGE_LOGO,
                                          sizeImage: Size.fromWidth(35)),
                                    ),
                                  )
                                ]),
                              ),
                              Flexible(
                                child: Column(children: [
                                  Text(
                                      'Nueva promoción de vestimenta deportiva', //Servicios Funerales',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  SizedBox(height: 4.0),
                                  Text(
                                      'Precio por promoción Sus. 30  mensual de los Sus. 45 atuales',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12))
                                ]),
                              )
                            ]),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => ClientListPage())),
                            child: Container(
                                padding: const EdgeInsets.all(14.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffFDC054),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5.0),
                                        bottomLeft: Radius.circular(5.0))),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Ingresar a la página Web virtual_match'
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
