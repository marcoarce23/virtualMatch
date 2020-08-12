import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ClasificadorModel.dart';
import 'package:virtual_match/src/service/ClasificadorService.dart';
import 'package:virtual_match/src/style/Style.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/NotificactionService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/NotificacionModel.dart';

class NotificationListPage extends StatefulWidget {
  static final String routeName = 'notificationList';
  NotificationListPage({Key key}) : super(key: key);

  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
//DEFINICION DE BLOC Y MODEL
  NotificacionModel entity = new NotificacionModel();
  //NotificationService entityService = NotificationService();
  NotificationService entityGet = NotificationService();

  final prefs = new Preferense();
  var result;

  @override
  void initState() {
    prefs.lastPage = NotificationListPage.routeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    entityGet = Provider.of<NotificationService>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   toolbarOpacity: 0.7,
      //   iconTheme: IconThemeData(color: AppTheme.themeDefault, size: 12),
      //   elevation: 0,
      //   title: Text("NOTIFICACIONES", style: kTitleAppBar),
      // ),
      // drawer: Drawer(),
      body: SafeArea(
        child: Container(
          //  decoration: boxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //   SizedBox(height: 10.0),
              // Container(
              //   width: size.width * 0.96,
              //   margin: EdgeInsets.symmetric(vertical: 0.0),
              //   child: containerTitle(
              //     context,
              //     40.0,
              //     'ENCUENTRANOS AQUÍ',
              //     FaIcon(FontAwesomeIcons.handHoldingHeart,
              //         color: AppTheme.themeDefault),
              //   ),
              // ),
              divider(),
              futureItemsEntity(context),
              copyRigth(),
            ],
          ),
        ),
      ),
      floatingActionButton: floatButton(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget futureItemsEntity(BuildContext context) {
    return FutureBuilder(
        future: entityGet.get(new NotificacionModel()),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listItems(context, snapshot);
          }
        });
  }

  Widget listItems(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          NotificacionModel entity = snapshot.data[index];

          return Flexible(
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width * 0.97,
                  margin: EdgeInsets.symmetric(vertical: 0.0),
                  //   decoration: boxDecoration(),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        // leading: iconEntity(entity),
                        title: listEntity(context, entity),
                      ),
                    ],
                  ),
                ),
                sizedBox(0.0, 8.0),
                //  divider(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget listEntity(BuildContext context, NotificacionModel entity) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: AppTheme.themeDefault,
                        size: 15,
                      ),
                      Text('${entity.titulo} ', style: kTitleStyleBlack),
                    ],
                  )),

              Container(
                  child: Row(
                children: <Widget>[
                  Icon(
                    Icons.phone_android,
                    color: AppTheme.themeDefault,
                    size: 15,
                  ),
                  Text(
                    'Telefono: ${entity.detalle}',
                    style: kSubTitleCardStyle,
                  ),
                ],
              )),

              //  Text('Puedes contactactarte por aca',
              //             style: TextStyle(fontSize: 15, color: Colors.black87),
              //           ),
            ],
          ),
        ),
      ],
    );
  }

  Container iconEntity(NotificacionModel entity) {
    return Container(
        child: Column(
      children: <Widget>[
        ImageOvalNetwork(
            imageNetworkUrl: entity.foto, sizeImage: Size.fromWidth(50)),
        // SizedBox(
        //   height: 1.5,
        // ),
        // Text(
        //   '${entityItem.regPrioridad}',
        //   style: TextStyle(
        //       fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w400),
        // ),
      ],
    ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:virtual_match/src/model/util/Const.dart';
// import 'package:virtual_match/src/page/people/InfluencerListPage.dart';
// import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';

// class NotificationLocalPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.grey[100],
//       child: SafeArea(
//         child: Container(
//             margin: const EdgeInsets.only(top: kToolbarHeight),
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Notificaciones virtual_match',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   CloseButton()
//                 ],
//               ),
//               Flexible(
//                 child: ListView(
//                   children: <Widget>[
//                     // Request amount
//                     Container(
//                       padding: const EdgeInsets.all(13.0),
//                       margin: const EdgeInsets.symmetric(vertical: 4.0),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                       child: Column(
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               ImageOvalNetwork(
//                                   imageNetworkUrl:
//                                       'https://res.cloudinary.com/propia/image/upload/v1594742564/xohvmqv9xtwhgvppqnbb.jpg',
//                                   sizeImage: Size.fromWidth(70)),
//                               Flexible(
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                         style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           color: Colors.black,
//                                         ),
//                                         children: [
//                                           TextSpan(
//                                               text:
//                                                   'Zapatillas deportivas para niños y niñas ortopédicos', //  'Nuevo Terreno en Sector 4A - Urbanización GArdenias',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                               )),
//                                           TextSpan(
//                                             text: ' Precio de promoción ',
//                                           ),
//                                           TextSpan(
//                                             text: '\$45.25 mensual',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           )
//                                         ]),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.check_circle,
//                                     size: 14,
//                                     color: Colors.blue[700],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8.0),
//                                     child: Text('Crear Producto',
//                                         style:
//                                             TextStyle(color: Colors.blue[700])),
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.cancel,
//                                     size: 14,
//                                     color: Color(0xffF94D4D),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8.0),
//                                     child: Text('Declinar',
//                                         style: TextStyle(
//                                             color: Color(0xffF94D4D))),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     // Send amount
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 4.0),
//                       padding: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                       child: Column(
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               ImageOvalNetwork(
//                                   imageNetworkUrl:
//                                       'https://res.cloudinary.com/propia/image/upload/v1594742559/my0xpfznfp8anftntcbm.jpg',
//                                   sizeImage: Size.fromWidth(70)),
//                               Flexible(
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                         style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           color: Colors.black,
//                                         ),
//                                         children: [
//                                           TextSpan(
//                                               text:
//                                                   'Nueva temporada de ropa casula de invierno', //''Construcción de viviendas (Nuevo Servicio) ',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                               )),
//                                           TextSpan(
//                                             text:
//                                                 'Venta de ropa de varón', //' Construcción desde:',
//                                           ),
//                                           TextSpan(
//                                             text: '\$39.99',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           )
//                                         ]),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.check_circle,
//                                     size: 14,
//                                     color: Colors.blue[700],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8.0),
//                                     child: Text('Crear Producto',
//                                         style:
//                                             TextStyle(color: Colors.blue[700])),
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.cancel,
//                                     size: 14,
//                                     color: Color(0xffF94D4D),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8.0),
//                                     child: Text('Declinar',
//                                         style: TextStyle(
//                                             color: Color(0xffF94D4D))),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     // Share your feedback.
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 4.0),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(children: [
//                               SizedBox(
//                                 height: 110,
//                                 width: 110,
//                                 child: Stack(children: <Widget>[
//                                   Positioned(
//                                     left: 5.0,
//                                     bottom: -10.0,
//                                     child: SizedBox(
//                                       height: 100,
//                                       width: 100,
//                                       child: Transform.scale(
//                                         scale: 1.2,
//                                         child: ImageOvalNetwork(
//                                             imageNetworkUrl: '',
//                                             sizeImage: Size.fromWidth(35)),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 8.0,
//                                     left: 10.0,
//                                     child: SizedBox(
//                                       height: 80,
//                                       width: 80,
//                                       child: ImageOvalNetwork(
//                                           imageNetworkUrl: IMAGE_LOGO,
//                                           sizeImage: Size.fromWidth(35)),
//                                     ),
//                                   )
//                                 ]),
//                               ),
//                               Flexible(
//                                 child: Column(children: [
//                                   Text(
//                                       'Priorizar con los clientes la venta de los Servicios de  Delivery Express', //Construcción',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13)),
//                                   SizedBox(height: 4.0),
//                                   Text(
//                                       'Fidelizar al cliente con el monto de la promoción de la nueva moda deportiva.',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 12))
//                                 ]),
//                               )
//                             ]),
//                           ),
//                           InkWell(
//                             onTap: () => Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (_) => ClientListPage())),
//                             child: Container(
//                                 padding: const EdgeInsets.all(14.0),
//                                 decoration: BoxDecoration(
//                                     color: Color(0xffFDC054),
//                                     borderRadius: BorderRadius.only(
//                                         bottomRight: Radius.circular(5.0),
//                                         bottomLeft: Radius.circular(5.0))),
//                                 child: Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Text(
//                                       'Ingresar a la página Web virtual_match'
//                                           .toUpperCase(),
//                                       style: TextStyle(
//                                           color: Colors.green,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13),
//                                     ))),
//                           )
//                         ],
//                       ),
//                     ),
//                     // Track the product.
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 4.0),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(children: [
//                               SizedBox(
//                                 height: 110,
//                                 width: 110,
//                                 child: Stack(children: <Widget>[
//                                   Positioned(
//                                     left: 5.0,
//                                     bottom: -10.0,
//                                     child: SizedBox(
//                                       height: 100,
//                                       width: 100,
//                                       child: Transform.scale(
//                                         scale: 1.2,
//                                         child: Image.asset(
//                                             'assets/bottom_yellow.png'),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     top: 8.0,
//                                     left: 10.0,
//                                     child: SizedBox(
//                                       height: 80,
//                                       width: 80,
//                                       child: ImageOvalNetwork(
//                                           imageNetworkUrl: IMAGE_LOGO,
//                                           sizeImage: Size.fromWidth(35)),
//                                     ),
//                                   )
//                                 ]),
//                               ),
//                               Flexible(
//                                 child: Column(children: [
//                                   Text(
//                                       'Nueva promoción de vestimenta deportiva', //Servicios Funerales',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13)),
//                                   SizedBox(height: 4.0),
//                                   Text(
//                                       'Precio por promoción Sus. 30  mensual de los Sus. 45 atuales',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 12))
//                                 ]),
//                               )
//                             ]),
//                           ),
//                           InkWell(
//                             onTap: () => Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (_) => ClientListPage())),
//                             child: Container(
//                                 padding: const EdgeInsets.all(14.0),
//                                 decoration: BoxDecoration(
//                                     color: Color(0xffFDC054),
//                                     borderRadius: BorderRadius.only(
//                                         bottomRight: Radius.circular(5.0),
//                                         bottomLeft: Radius.circular(5.0))),
//                                 child: Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Text(
//                                       'Ingresar a la página Web virtual_match'
//                                           .toUpperCase(),
//                                       style: TextStyle(
//                                           color: Colors.green,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13),
//                                     ))),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ])),
//       ),
//     );
//   }
// }
