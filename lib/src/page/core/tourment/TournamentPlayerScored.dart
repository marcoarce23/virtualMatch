import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/PartidosPorTorneoModel.dart';
import 'package:virtual_match/src/service/core/PartidosPorTorneoService.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart'; 

class TournamentPlayerScored extends StatefulWidget {
    final int idTorneo;

    const TournamentPlayerScored({Key key, @required this.idTorneo})
      : super(key: key);

  @override
  _TournamentPlayerScoredState createState() => _TournamentPlayerScoredState();
}

class _TournamentPlayerScoredState extends State<TournamentPlayerScored> {

PartidosPorTorneoModel entity = new PartidosPorTorneoModel();
  PartidosPorTorneoService entityService;
  PartidosPorTorneoService entityGet = PartidosPorTorneoService();


  @override
  Widget build(BuildContext context) {
    return futureBuilder(context);
  }


Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getPartidosTorneoX(new PartidosPorTorneoModel(),widget.idTorneo  ),
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
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        PartidosPorTorneoModel entity = snapshot.data[index];
        return showScored(entity);
      },
    );
  }



 Widget showScored(PartidosPorTorneoModel entity ) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Column(
        children: <Widget>[
          avatarCircle(entity.iFoto, 35.0),
          Text(entity.iJugador),
        ],
      ),
      Column(
        children: <Widget>[
          Text( entity.iGoles.toString()+' - '+entity.dGoles.toString()),   
          Text(entity.estadoPartido),
          Text(new DateFormat.yMMMMd('es_BO').format(entity.fechaPartido)),          
          Text(entity.nombreTorneo.toString()),          
        ],
      ),
      Column(
        children: <Widget>[
          avatarCircle(entity.dFoto, 35.0),
          Text(entity.iJugador),
        ],
      ),
      
      

    ],
  );
  }
}