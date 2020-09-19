import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_match/src/model/util/Resource.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';

class ItemBottomMenu {
  Function onPressed;
  IconData icon;

  ItemBottomMenu({@required this.icon, @required this.onPressed});
}

class BottomMenu extends StatefulWidget {
  BottomMenu({Key key}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  List<ItemBottomMenu> items = [
    ItemBottomMenu(
        icon: Icons.search,
        onPressed: () {
          print('search');
        }),
    ItemBottomMenu(
        icon: Icons.access_alarm,
        onPressed: () {
          print('alarm');
        }),
    ItemBottomMenu(
        icon: Icons.access_time,
        onPressed: () {
          print('time');
        }),
  ];

  @override
  Widget build(BuildContext context) {
    return buildMenus();
  }

  Widget buildMenus() {
    return ChangeNotifierProvider(
      create: (context) => _MenuModel(),
      child: _MenuItemBackGround(
        child: _MenuItems(
          menuItems: items,
        ),
      ),
    );
  }
}

class _MenuItemBackGround extends StatelessWidget {
  Widget child;

  _MenuItemBackGround({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black38, blurRadius: 10, spreadRadius: -5)
          ]),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<ItemBottomMenu> menuItems;
  const _MenuItems({Key key, this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          menuItems.length, (index) => _MenuButton(index, menuItems[index])),
    );
  }
}

class _MenuButton extends StatelessWidget {
  int index;
  ItemBottomMenu item;

  _MenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado =
            index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(item.icon,
            size: (itemSeleccionado == index) ? 40 : 25,
            color: (itemSeleccionado == index) ? Colors.blue : Colors.purple),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  int get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado(int index) {
    this._itemSeleccionado = index;
    notifyListeners();
  }
}
