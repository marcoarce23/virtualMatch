import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_match/src/page/home/HomePage.dart';
import 'dart:math';

import 'package:virtual_match/src/theme/Theme.dart';
import 'package:virtual_match/src/widget/general/GeneralWidget.dart';
import 'package:virtual_match/src/widget/gfWidget/GfWidget.dart';

class FoldablePage extends StatefulWidget {
  @override
  _FoldableState createState() => _FoldableState();
}

class _FoldableState extends State<FoldablePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.themeOrange,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _controller.forward(from: 0.0);
            },
            icon: Icon(Icons.arrow_upward),
          ),
          IconButton(
            onPressed: () {
              _controller.reverse();
            },
            icon: Icon(Icons.arrow_downward),
          )
        ],
      ),
      floatingActionButton: floatButton(AppTheme.themeOrange, context,
          FaIcon(FontAwesomeIcons.home), HomePage()),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  textSimple1(
                      FaIcon(FontAwesomeIcons.home, color: Colors.orange),
                      'Productos exclusivos'.toUpperCase(),
                      Colors.deepPurple),
                  Text('Venta de proyectos exclusivos para mostrar al cliente.',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  sizedBox(0.0, 10.0),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Container(
                          color: AppTheme.themeOrange,
                          padding: EdgeInsets.all(8.0),
                          child: Image.network(
                            "https://res.cloudinary.com/propia/image/upload/v1594743791/a0ceajjzzdayfparkayw.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        FoldableItem(
                          lastChild: Container(
                            color: AppTheme.themeOrange,
                            child: Image.network(
                              "https://res.cloudinary.com/propia/image/upload/v1594750950/gzikny5up1aqzm2vfdna.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          animation:
                              Tween<double>(begin: 90.0, end: 0.0).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(0.6, 1.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: FoldableItem(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          "https://res.cloudinary.com/propia/image/upload/v1594743796/wmeydp1xf762znipobjb.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      animation: Tween<double>(begin: 0.0, end: 90).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(0.3, 0.6),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoldableItem(
                      first: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          "https://res.cloudinary.com/propia/image/upload/v1594743778/yh8n7nas9canepxfav94.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      animation: Tween<double>(begin: 0.0, end: 180).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(0.0, 0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _loadingProduct() {
  //   return Column(
  //     children: <Widget>[
  //       Expanded(
  //         child: Stack(
  //           fit: StackFit.expand,
  //           children: <Widget>[
  //             Container(
  //               color: AppTheme.themeOrange,
  //               padding: EdgeInsets.all(8.0),
  //               child: Image.network(
  //                 "https://www.educaciontrespuntocero.com/wp-content/uploads/2018/01/machu-picchu.jpg",
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             FoldableItem(
  //               lastChild: Container(
  //                 color: AppTheme.themeOrange,
  //                 child: FlutterLogo(),
  //               ),
  //               animation: Tween<double>(begin: 90.0, end: 0.0).animate(
  //                 CurvedAnimation(
  //                   parent: _controller,
  //                   curve: Interval(0.6, 1.0),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         child: FoldableItem(
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Image.network(
  //               "https://www.educaciontrespuntocero.com/wp-content/uploads/2018/01/chichen-itza.jpg",
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           animation: Tween<double>(begin: 0.0, end: 90).animate(
  //             CurvedAnimation(
  //               parent: _controller,
  //               curve: Interval(0.3, 0.6),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         child: FoldableItem(
  //           first: true,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Image.network(
  //               "https://www.educaciontrespuntocero.com/wp-content/uploads/2018/01/cristo-redentor-1.jpg",
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           animation: Tween<double>(begin: 0.0, end: 180).animate(
  //             CurvedAnimation(
  //               parent: _controller,
  //               curve: Interval(0.0, 0.3),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class FoldableItem extends AnimatedWidget {
  final Animation<double> animation;
  final Widget child;
  final Widget lastChild;
  final bool first;
  final double fullAngle = 180.0;
  final double halfAngle = 180.0 / 2.0;
  bool get hasLastChild => lastChild != null;

  FoldableItem({
    this.animation,
    this.child,
    this.first = false,
    this.lastChild,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return animation.value == fullAngle && !hasLastChild
        ? SizedBox.shrink()
        : Transform(
            alignment:
                hasLastChild ? Alignment.bottomCenter : Alignment.topCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX((pi / fullAngle) *
                  (hasLastChild ? animation.value : -animation.value)),
            child: Container(
              color: (animation.value < halfAngle && first) ||
                      (!first && animation.value == 0.0)
                  ? AppTheme.themeOrange
                  : Colors.red[800],
              child: (first && animation.value < halfAngle ||
                      (animation.value == 0.0 && !hasLastChild))
                  ? child
                  : lastChild,
            ),
          );
  }
}
