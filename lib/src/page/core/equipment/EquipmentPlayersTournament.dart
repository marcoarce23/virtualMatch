import 'package:auto_size_text/auto_size_text.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //  sizedBox(0, 7),
          gfListTile(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(flex: 7, child: _showAvatarDetail(entity)),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        callNumber(int.parse(entity.telefono));
                      },
                      child: FaIcon(FontAwesomeIcons.phone,
                          color: AppTheme.themePurple, size:27),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        sendSMS(int.parse(entity.telefono));
                      },
                      child: FaIcon(FontAwesomeIcons.sms,
                          color: AppTheme.themePurple, size:27),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        callWhatsApp1(int.parse(entity.telefono));
                      },
                      child: FaIcon(FontAwesomeIcons.whatsapp,
                          color: Colors.white, size:27),
                    ),
                  ),
                ],
              ),
              null,
              null, //_showPlayerDetail(entity),
              null,
              null, //avatarCircle((entity.fotoJugador ?? IMAGE_DEFAULT), 35),
              null,
              EdgeInsets.all(3.0)),
          // sizedBox(0, 7),
        ],
      ),
    );
    //Text(entity.nombreEquipo);
  }

  Widget _showPlayerDetail(ListadoJugadoresModel entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
            Text('10 Perdidos', style: TextStyle(color: AppTheme.themePurple)),
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
        Expanded(
          child: Column(
            //    mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(
                entity.nombreJugador,
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              AutoSizeText(
                entity.apellidoJugador,
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              AutoSizeText(
                'DPTO: ${entity.departamento}',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
              AutoSizeText(
                'IPSDN: ${entity.idJugador.toString()}',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
