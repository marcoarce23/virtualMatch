import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:virtual_match/src/model/Preference.dart';
import 'package:virtual_match/src/model/entity/EntityFromJson/ListaFechasTorneo.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'package:virtual_match/src/service/core/TournamentService.dart';
import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/appBar/AppBarWidget.dart';
import 'package:virtual_match/src/widget/card/CardVM.dart';
import 'package:virtual_match/src/widget/drawer/DrawerWidget.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class DateTournament extends StatefulWidget {
  final int idTorneo;
  final int idJugador;

  DateTournament({@required this.idTorneo, @required this.idJugador});

  @override
  _DateTournamentState createState() => _DateTournamentState();
}

class _DateTournamentState extends State<DateTournament> {
  final prefs = new Preferense();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String _fecha = DateTime.now().toString().substring(0, 10);

  TourmentService entityService = new TourmentService();
  TourmentService entityGet = TourmentService();
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar('FECHAS DE TORNEO'),
      body: SingleChildScrollView(
          child: Container(child: bodyContainer(context))),
      drawer: DrawerMenu(),
      floatingActionButton: floatButtonImage(AppTheme.themeDefault, context,
          FaIcon(FontAwesomeIcons.playstation), HomePage()),
    );
  }

  Widget bodyContainer(BuildContext context) {
    sizedBox(0, 7);
    return futureBuilder(context);
  }

  Widget futureBuilder(BuildContext context) {
    return FutureBuilder(
        future: entityGet.getFechasTorneo(
            new ListaFechasTorneo(), widget.idTorneo, widget.idJugador),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            default:
              return Column(
                children: <Widget>[
                  sizedBox(0, 10),
                  showInformationBasic(
                    context,
                    'FECHAS DE TORNEOS',
                    '',
                  ),
                  sizedBox(0, 5.0),
                  divider(),
                  listView(context, snapshot),
                  //     copyRigthBlack(),
                ],
              );
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
          ListaFechasTorneo entity = snapshot.data[index];
          return showDateTournament(context, entity);
        },
      ),
    );
  }

  Widget showDateTournament(BuildContext context, ListaFechasTorneo entity) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: CardVM(
            size: 100,
            imageAssets: 'assets/icono3.png',
            opciones: null,
            accesosRapidos: null,
            listWidgets: [
              Text('Nro: ${entity.nrO_FECHA}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppTheme.themeWhite)),
              Text('Torneo: ${entity.torneo}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppTheme.themeWhite)),
              Text('Fecha: ${(entity.fecha) ?? 'N/A'}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppTheme.themeWhite)),
            ],
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020, 4),
        lastDate: new DateTime(2025, 12),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _fecha = DateFormat("yyyy-MM-dd").format(picked);
        _inputFieldDateController.text = _fecha;
        showDialog(
            context: context,
            child: AlertDialog(content: Text('se cerro ${_fecha.toString()}')));
      });
    }
  }
}
