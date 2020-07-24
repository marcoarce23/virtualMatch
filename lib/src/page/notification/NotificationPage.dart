
import 'package:flutter/material.dart';


class NotificationPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context).settings.arguments;
    //print('valro obtenido: $arg');
     
   

     return Scaffold(
      appBar: AppBar(
        title: Text('NOTIFICACIONES'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('valor optenido $arg'),
          ],
        ),//arg),
      ),
    );
  }
}