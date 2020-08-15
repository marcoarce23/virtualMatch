import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoJugadoresModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class EquipmentPlayersTournament extends StatefulWidget {
  final int idTorneo;

  const EquipmentPlayersTournament({Key key, @required this.idTorneo})
      : super(key: key);

  @override
  _EquipmentPlayersTournamentState createState() =>
      _EquipmentPlayersTournamentState();
}

class _EquipmentPlayersTournamentState
    extends State<EquipmentPlayersTournament> {
  ListadoJugadoresModel entity = new ListadoJugadoresModel();
  EquipmentService entityService;
  EquipmentService entityGet = EquipmentService();

  @override
  Widget build(BuildContext context) {
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getTodosJugadores(
            new ListadoJugadoresModel(), widget.idTorneo),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return listView(context, snapshot);
          }
        });
  }

  Widget listView(BuildContext context, AsyncSnapshot snapshot) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          ListadoJugadoresModel entity = snapshot.data[index];
          return showPlayers(entity);
        },
      ),
    );
  }

  Widget showPlayers(ListadoJugadoresModel entity) {
    final size = MediaQuery.of(context).size;
    sizedBox(0, 7);
    return Container(
      width: size.width * 0.95,
      margin: EdgeInsets.symmetric(vertical: 3.0),
      decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          sizedBox(0, 7),
          gfListTile(
              Text(entity.nombreEquipo),
              _showPlayerDetail(entity),
              _showAvatarDetail(entity),
              null,
              avatarCircle((entity.fotoEquipo ?? IMAGE_LOGO), 35),
              EdgeInsets.all(5.0),
              EdgeInsets.all(3.0)),
          sizedBox(0, 7),
        ],
      ),
    );
    //Text(entity.nombreEquipo);
  }

  Widget _showPlayerDetail(ListadoJugadoresModel entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(entity.detalleEquipo),
        //sizedBox(5, 0),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.trophy,
              size: 10,
              color: Colors.green,
            ),
            Text('20 ganados'),
            FaIcon(
              FontAwesomeIcons.handPointDown,
              size: 10,
              color: Colors.red,
            ),
            Text('10 Perdidos'),
          ],
        ),
        //sizedBox(5, 0),
      ],
    );
  }

  Widget _showAvatarDetail(ListadoJugadoresModel entity) {
    return Row(
      children: <Widget>[
        avatarCircle(
            (entity.fotoJugador == null ? IMAGE_LOGO : entity.fotoJugador), 15),
        Text(entity.nombreJugador + ' ' + entity.apellidoJugador),
      ],
    );
  }
}
