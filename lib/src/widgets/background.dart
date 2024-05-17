import 'package:flutter/widgets.dart';
import '../models.dart';

/// Base widget for the background of the chessboard.
///
/// See [SolidColorBackground] and [ImageBackground] for concrete implementations.
abstract class Background extends StatelessWidget {
  const Background({
    super.key,
    this.coordinates = false,
    this.orientation = Side.white,
    required this.lightSquare,
    required this.darkSquare,
    this.isExtend = false,
  });

  final bool coordinates;
  final Side orientation;
  final Color lightSquare;
  final Color darkSquare;
  final bool isExtend;
}

/// A chessboard background with solid color squares.
class SolidColorBackground extends Background {
  const SolidColorBackground({
    super.key,
    super.coordinates,
    super.orientation,
    required super.lightSquare,
    required super.darkSquare,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: List.generate(
          8,
          (rank) => Expanded(
            child: Row(
              children: List.generate(
                8,
                (file) => Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: (rank + file).isEven ? lightSquare : darkSquare,
                    child: coordinates
                        ? _Coordinate(
                            rank: rank,
                            file: file,
                            orientation: orientation,
                            color:
                                (rank + file).isEven ? darkSquare : lightSquare,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A chessboard background made of an image.
class ImageBackground extends Background {
  const ImageBackground({
    super.key,
    super.coordinates,
    super.orientation,
    required super.lightSquare,
    required super.darkSquare,
    required this.image,
    super.isExtend = false,
  });

  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Image(image: image),
          if (coordinates)
            Center(
              child: FractionallySizedBox(
                widthFactor: isExtend ? 1024 / 1280 : 1.0,
                heightFactor: isExtend ? 1024 / 1280 : 1.0,
                child: Column(
                  children: List.generate(
                    8,
                    (rank) => Expanded(
                      child: Row(
                        children: List.generate(
                          8,
                          (file) => Expanded(
                            child: SizedBox.expand(
                              child: _Coordinate(
                                rank: rank,
                                file: file,
                                orientation: orientation,
                                color:
                                    (rank + file).isEven ? darkSquare : lightSquare,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Coordinate extends StatelessWidget {
  const _Coordinate({
    required this.rank,
    required this.file,
    required this.color,
    required this.orientation,
  });

  final int rank;
  final int file;
  final Color color;
  final Side orientation;

  @override
  Widget build(BuildContext context) {
    final coordStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 11.0,
      color: color,
      fontFamily: 'Roboto',
    );
    return Stack(
      children: [
        if (file == 7)
          Align(
            alignment: Alignment.topRight,
            child: Text(
              orientation == Side.white ? '${8 - rank}' : '${rank + 1}',
              style: coordStyle,
            ),
          ),
        if (rank == 7)
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              orientation == Side.white
                  ? String.fromCharCode(97 + file)
                  : String.fromCharCode(97 + 7 - file),
              style: coordStyle,
            ),
          ),
      ],
    );
  }
}
