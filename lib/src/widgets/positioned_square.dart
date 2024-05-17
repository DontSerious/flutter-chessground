import 'package:chessground/chessground.dart';
import 'package:flutter/widgets.dart';
import '../models.dart';

/// Board aware Positioned widget
///
/// Use to position things, such as [Piece], [Highlight] on the board.
/// Since it's a wrapper over a [Positioned] widget it must be a descendant of a
/// [Stack].
class PositionedSquare extends StatelessWidget {
  PositionedSquare({
    super.key,
    required this.child,
    required this.size,
    required this.orientation,
    required this.squareId,
  });

  final Widget child;
  final double size;
  final Side orientation;
  final SquareId squareId;

  @override
  Widget build(BuildContext context) {
    final offset = Coord.fromSquareId(squareId).offset(orientation, size);

    final isExtend = BS.extended;
    final offsetExtend = isExtend ? const Offset(128, 128) : Offset.zero;
    final newSize = isExtend ? size * 1280 / 1024 : size;
    
    return Positioned(
      width: newSize,
      height: newSize,
      left: offset.dx + offsetExtend.dx,
      top: offset.dy + offsetExtend.dy,
      child: child,
    );
  }
}
