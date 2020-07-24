import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/widget/image/imageOvalWidget.dart';

class ClientListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[100],
      child: SafeArea(
        child: Container(
            //  margin: const EdgeInsets.only(top: kToolbarHeight),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Text(
                  //   'Mis Clientes virtual_match',
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //     fontSize: 22,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  //   CloseButton()
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
                                      'https://res.cloudinary.com/propia/image/upload/v1594756904/drgiin5zbal6d1pw99pc.jpg',
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
                                                  'Cliente: Marcelo Arce Valdivia',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextSpan(
                                            text: ' Telf:72038768 ',
                                          ),
                                          TextSpan(
                                            text:
                                                'correo: marcoarce23@gmail.com',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\nCliente: Potencial',
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
                                    child: Text('Editar',
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
                                    child: Text('Eliminar',
                                        style: TextStyle(
                                            color: Color(0xffF94D4D))),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone_android,
                                    size: 25.0,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  FaIcon(FontAwesomeIcons.whatsapp,
                                      color: Colors.green, size: 25.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.contact_mail,
                                    size: 25.0,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
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
                                      'https://res.cloudinary.com/propia/image/upload/v1594756886/r3gnj0fcuscdcub4moao.jpg',
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
                                                  'Cliente: Carolina Rocio Cantero FLores',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextSpan(
                                            text: ' Telf:76238768 ',
                                          ),
                                          TextSpan(
                                            text:
                                                'correo: carolinaCatenro@gmail.com',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\nCliente: Interesada',
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
                                    child: Text('Editar',
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
                                    child: Text('Eliminar',
                                        style: TextStyle(
                                            color: Color(0xffF94D4D))),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone_android,
                                    size: 25.0,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  FaIcon(FontAwesomeIcons.whatsapp,
                                      color: Colors.green, size: 25.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.contact_mail,
                                    size: 25.0,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

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
                                      'https://res.cloudinary.com/propia/image/upload/v1594355679/eb1cjot8d3cqee92fbfj.jpg',
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
                                                  'Cliente: Vivian Valverde Arzenica',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextSpan(
                                            text: ' Telf:72345435 ',
                                          ),
                                          TextSpan(
                                            text:
                                                'correo: vivian.valvarde@gmail.com',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\nCliente: Interesada',
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
                                    child: Text('Editar',
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
                                    child: Text('Eliminar',
                                        style: TextStyle(
                                            color: Color(0xffF94D4D))),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone_android,
                                    size: 25.0,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  FaIcon(FontAwesomeIcons.whatsapp,
                                      color: Colors.green, size: 25.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.contact_mail,
                                    size: 25.0,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

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
                                      'https://res.cloudinary.com/propia/image/upload/v1594756895/ndec79wqbh1kvu9pdpkd.jpg',
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
                                                  'Cliente: Genaro FLores Barrionuevo',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextSpan(
                                            text: ' Telf:77722532 ',
                                          ),
                                          TextSpan(
                                            text:
                                                'correo: genaro.flores@gmail.com',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '\nCliente: Información',
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
                                    child: Text('Editar',
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
                                    child: Text('Eliminar',
                                        style: TextStyle(
                                            color: Color(0xffF94D4D))),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone_android,
                                    size: 25.0,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  FaIcon(FontAwesomeIcons.whatsapp,
                                      color: Colors.green, size: 25.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.contact_mail,
                                    size: 25.0,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text('',
                                        style: TextStyle(color: Colors.black)),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Share your feedback.
                    // Track the product.
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
