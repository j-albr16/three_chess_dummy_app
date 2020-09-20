import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;



enum PieceType{Pawn, Rook, Knight, Bishop, King, Queen}
enum PlayerColor{white, black, red}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dummy App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<PieceType, Map<PlayerColor, ui.Image>> images = {
  };

  Future<void> addImages() async {
    await ImageData.assetPaths.entries.forEach((typeElement) {
      typeElement.value.entries.forEach((colorElement) {
        loadUiImage(colorElement.value).then((value) => images[typeElement.key][colorElement.key] = value);
      });
    });
  }

  Future <ui.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final image = await loadImage(new Uint8List.view(data.buffer));
    return image;
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
}



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Piece'),
      ),
      body: widgets.FutureBuilder(
        future: addImages(),
        builder: (context, snapshot) =>
          snapshot.connectionState == widgets.ConnectionState.waiting ? Center(child: CircularProgressIndicator(),) :
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/black/bishop_black.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: CustomPaint(
                    painter: DummyPainter(images: snapshot.data,),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class DummyPainter extends CustomPainter {
  final images;

  DummyPainter({this.images});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()..color = Colors.brown;
    print(images.toString());
    images.map((image2) => image2.value.map((image) {
      print(image);
      return canvas.drawImage(image.value, Offset((10).toDouble(), (10).toDouble()), paint);
    }));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw true;
  }
}





class ImageData{


  static const Map<PieceType, Map<PlayerColor, String>> assetPaths ={
    PieceType.Pawn:{
      PlayerColor.black:'assets/pieces/black/pawn_black.png',
      PlayerColor.white:'assets/pieces/white/pawn_white.png',
      PlayerColor.red:'assets/pieces/black/pawn_black.png',
    },
    PieceType.Bishop:{
      PlayerColor.black:'assets/pieces/black/bishop_black.png',
      PlayerColor.white:'assets/pieces/white/bishop_white.png',
      PlayerColor.red:'assets/pieces/black/bishop_black.png',
    },
    PieceType.Knight:{
      PlayerColor.black:'assets/pieces/black/knight_black.png',
      PlayerColor.white:'assets/pieces/white/knight_white.png',
      PlayerColor.red:'assets/pieces/black/knight_black.png',
    },
    PieceType.Rook:{
      PlayerColor.black:'assets/pieces/black/rook_black.png',
      PlayerColor.white:'assets/pieces/white/rook_white.png',
      PlayerColor.red:'assets/pieces/black/rook_black.png',
    },
    PieceType.Queen:{
      PlayerColor.black:'assets/pieces/black/queen_black.png',
      PlayerColor.white:'assets/pieces/white/queen_white.png',
      PlayerColor.red:'assets/pieces/black/queen_black.png',
    },
    PieceType.King:{
      PlayerColor.black:'assets/pieces/black/king_black.png',
      PlayerColor.white:'assets/pieces/white/king_white.png',
      PlayerColor.red:'assets/pieces/black/king_black.png',
    },

  };

}




