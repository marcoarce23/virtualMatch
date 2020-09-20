import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListadoJugadoresModel.dart';
import 'package:virtual_match/src/model/util/Const.dart';
import 'package:virtual_match/src/service/core/EquipmentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CardVM(
          size: 120,
          imageAssets: 'assets/icono3.png',
          opciones: avatarCircle(
              (entity.fotoJugador == null ? IMAGE_LOGOB : entity.fotoJugador),
              30),
          accesosRapidos: opcionesLlamada(entity),
          listWidgets: [
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
        // sizedBox(0, 7),
      ],
    );
    //Text(entity.nombreEquipo);
  }

  List<Widget> opcionesLlamada(ListadoJugadoresModel entity) {
    return [
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          callNumber(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.phone, color: Colors.white, size: 27),
      ),
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          sendSMS(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.sms, color: Colors.white, size: 27),
      ),
      sizedBox(30, 0),
      InkWell(
        onTap: () {
          callWhatsApp1(int.parse(entity.telefono));
        },
        child: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 27),
      ),
    ];
  }
}
