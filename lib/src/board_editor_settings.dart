import 'package:flutter/widgets.dart';

import 'board_color_scheme.dart';
import 'models.dart';
import 'piece_set.dart';

/// Board editor settings that control the theme, behavior and purpose of the board editor.
///
/// This is meant for fixed settings that don't change while editing the board. Sensible
/// defaults are provided.
@immutable
class BoardEditorSettings {
  /// Creates a new [BoardEditorSettings] with the provided values.
  const BoardEditorSettings({
    // theme
    this.colorScheme = ChessboardColorScheme.brown,
    this.pieceAssets = PieceSet.cburnettAssets,
    // visual settings
    this.borderRadius = BorderRadius.zero,
    this.boxShadow = const <BoxShadow>[],
    this.enableCoordinates = true,
    this.dragFeedbackScale = 2.0,
    this.dragFeedbackOffset = const Offset(0.0, -1.0),
  });

  /// Theme of the board.
  final ChessboardColorScheme colorScheme;

  /// Piece set.
  final PieceAssets pieceAssets;

  /// Border radius of the board.
  final BorderRadiusGeometry borderRadius;

  /// Box shadow of the board.
  final List<BoxShadow> boxShadow;

  /// Whether to show board coordinates.
  final bool enableCoordinates;

  // Scale up factor for the piece currently under drag.
  final double dragFeedbackScale;

  // Offset for the piece currently under drag.
  final Offset dragFeedbackOffset;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is BoardEditorSettings &&
        other.colorScheme == colorScheme &&
        other.pieceAssets == pieceAssets &&
        other.borderRadius == borderRadius &&
        other.boxShadow == boxShadow &&
        other.enableCoordinates == enableCoordinates &&
        other.dragFeedbackScale == dragFeedbackScale &&
        other.dragFeedbackOffset == dragFeedbackOffset;
  }

  @override
  int get hashCode => Object.hash(
        colorScheme,
        pieceAssets,
        borderRadius,
        boxShadow,
        enableCoordinates,
        dragFeedbackScale,
        dragFeedbackOffset,
      );

  /// Creates a copy of this [BoardEditorSettings] but with the given fields replaced with the new values.
  BoardEditorSettings copyWith({
    ChessboardColorScheme? colorScheme,
    PieceAssets? pieceAssets,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    bool? enableCoordinates,
    double? dragFeedbackScale,
    Offset? dragFeedbackOffset,
  }) {
    return BoardEditorSettings(
      colorScheme: colorScheme ?? this.colorScheme,
      pieceAssets: pieceAssets ?? this.pieceAssets,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      enableCoordinates: enableCoordinates ?? this.enableCoordinates,
      dragFeedbackScale: dragFeedbackScale ?? this.dragFeedbackScale,
      dragFeedbackOffset: dragFeedbackOffset ?? this.dragFeedbackOffset,
    );
  }
}