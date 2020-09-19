import 'package:flutter/material.dart';

import './custom_painter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3 Chess App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool wasTabbed = false;
  double xInitial = 50;
  double yInitial = 50;
  double size = 100;
  double xInitial2 = 200;
  double yInitial2= 200;
  bool isPicked = false;

  void _changeWasTabbed() {
    print(wasTabbed);
    return setState(() => wasTabbed = !wasTabbed);
  }

  void _dragWidget(BuildContext context, details){
    while (isPicked){
      setState(() {
        yInitial2 = details.globalPosition.dy;
        xInitial2 =details.globalPosition.dx;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    print(wasTabbed);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: () => setState(() {
            xInitial += 10;
          })),
          IconButton(icon: Icon(Icons.keyboard_arrow_left), onPressed: () => setState(() {
            xInitial -= 10;
          })),
          IconButton(icon: Icon(Icons.keyboard_arrow_up), onPressed: () => setState(() {
            yInitial -= 10;
          })),
          IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: () => setState(() {
            yInitial += 10;
          })),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _changeWasTabbed,
            child: SizedBox(
              height: 300.0,
              width: 300.0,
              child: CustomPaint(
                size: Size(200,200),
                painter: DummyDrawing(wasTabbed: wasTabbed, xInitial: xInitial, yInitial: yInitial,),
              ),
            ),
          ),
          GestureDetector(
            dragStartBehavior: ,
            onTapUp: (details) {
              setState(() => isPicked = false);
              _dragWidget(context, details);
            },
            onTapDown: (details) {
              setState(() => isPicked = true);
              _dragWidget(context, details);
            },
            child: SizedBox(
              height: 300.0,
              width: 300.0,
              child: CustomPaint(
                size: Size(200,200),
                painter: DummyDrawing(wasTabbed: wasTabbed, xInitial: xInitial2, yInitial: yInitial2,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckDistance with ChangeNotifier {
}
