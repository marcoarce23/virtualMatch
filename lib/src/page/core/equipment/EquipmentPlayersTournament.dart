import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoJugadoresModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/CallWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/general/SenWidget.dart';
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
      width: size.width * 0.97,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          ListadoJugadoresModel entity = snapshot.data[index];
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: showPlayers(entity),
          );
        },
      ),
    );
  }

  Widget showPlayers(ListadoJugadoresModel entity) {
    final size = MediaQuery.of(context).size;
    // sizedBox(0, 7);
    return Container(
      width: size.width * 0.97,
      //   margin: EdgeInsets.all(3.0),
      decoration: boxDecoration(),
      child: Column(
        children: <Widget>[
          //  sizedBox(0, 7),
          gfListTile(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _showAvatarDetail(entity),
                  InkWell(
                    onTap: () {
                      callNumber(int.parse(entity.telefono));
                    },
                    child: FaIcon(FontAwesomeIcons.phone, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      sendSMS(int.parse(entity.telefono));
                    },
                    child: FaIcon(FontAwesomeIcons.sms, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      callWhatsApp1(int.parse(entity.telefono));
                    },
                    child:
                        FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
                  ),
                ],
              ),
              null,
              null, //_showPlayerDetail(entity),
              null,
              null, //avatarCircle((entity.fotoJugador ?? IMAGE_DEFAULT), 35),
              null,
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
        //sizedBox(5, 0),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.trophy,
              size: 10,
              color: Colors.green,
            ),
            Text('20 ganados', style: TextStyle(color: AppTheme.themeWhite)),
            FaIcon(
              FontAwesomeIcons.handPointDown,
              size: 10,
              color: Colors.red,
            ),
            Text('10 Perdidos', style: TextStyle(color: AppTheme.themeWhite)),
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
            (entity.fotoJugador == null ? IMAGE_LOGOB : entity.fotoJugador),
            24),
        sizedBox(10, 0),
        Text(entity.nombreJugador + ' ' + entity.apellidoJugador,
            style: TextStyle(color: AppTheme.themeWhite)),
      ],
    );
  }
}
