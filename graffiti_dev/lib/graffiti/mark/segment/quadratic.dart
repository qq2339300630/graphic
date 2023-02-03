import 'dart:ui';

import 'segment.dart';
import 'cubic.dart';

List<Offset> quadraticToCubicControls(Offset start, Offset control, Offset end) => [
  start * (1 / 3) + control * (2 / 3),
  end * (1 / 3) + control * (2 / 3),
];

class QuadraticSegment extends Segment {
  QuadraticSegment({
    required this.control,
    required this.end,

    String? id,
  }) : super(
    id: id,
  );

  final Offset control;

  final Offset end;
  
  @override
  void drawPath(Path path) =>
    path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);

  @override
  QuadraticSegment lerpFrom(covariant QuadraticSegment from, double t) => QuadraticSegment(
    control: Offset.lerp(from.control, control, t)!,
    end: Offset.lerp(from.end, end, t)!,
    id: id,
  );

  @override
  CubicSegment toCubic(Offset start) {
    final controls = quadraticToCubicControls(start, control, end);
    return CubicSegment(
      control1: controls.first,
      control2: controls.last,
      end: end,
      id: id,
    );
  }
}
