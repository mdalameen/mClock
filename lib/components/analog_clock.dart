import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mclock/common/app_colors.dart';

import 'dart:ui' as ui;

class AnalogClock extends StatelessWidget {
  final DateTime time;
  final bool displaySecond;
  AnalogClock(this.time, this.displaySecond);

  static final dateFomat = DateFormat.Hms();
  @override
  Widget build(BuildContext context) => CustomPaint(painter: _ClockPainter(time.hour, time.minute, time.second, time.hour < 12));
}

class _ClockPainter extends CustomPainter {
  int hour;
  int minute;
  int second;
  bool isAm;
  _ClockPainter(this.hour, this.minute, this.second, this.isAm);

  static final hourNumbers = <String>['12', ...List.generate(12, (index) => '${index + 1}')];
  @override
  void paint(Canvas canvas, Size size) {
    print(hour);
    final _outerCirclePaint = Paint()
      ..color = AppColors.clockOuter
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    final _outerCircleShadowPaint = Paint()
      ..color = Colors.black.withAlpha(50)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20)
      ..strokeWidth = 1;
    final _innerCirclePaint = Paint()..color = AppColors.clockInner;
    final innerCircleShadowPaint = Paint()
      ..color = Colors.black.withAlpha(10)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);
    final indicatorLine = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    final strongIndicatorLine = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    final hourHandPainter = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;

    final minuteHandPainter = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 2;

    final secondsHandPainter = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 1.5;

    bool isLarge = size.width > 200;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width < size.height ? size.width : size.height) / 2;
    final innerCircleRadius = radius * (isLarge ? 0.7 : 0.6);

    canvas.drawCircle(center, radius, _outerCircleShadowPaint);
    canvas.drawCircle(center, radius, _outerCirclePaint);
    canvas.drawCircle(center, innerCircleRadius, innerCircleShadowPaint);
    canvas.drawCircle(center, innerCircleRadius, _innerCirclePaint);

    _drawText(canvas, isAm ? 'AM' : 'PM', isLarge ? 14 : 12, size.width, Offset(center.dx, center.dy + radius / (isLarge ? 2 : 3)));

    canvas.save();

    final lineMargin = radius / (isLarge ? 10 : 5);
    final lineHeight = radius / 40;
    final stringLineHeight = radius / 20;

    for (int i = 0; i < 60; i++) {
      bool isStrong = i % 5 == 0;
      canvas.drawLine(
          Offset(
            center.dx,
            lineMargin,
          ),
          Offset(center.dx, lineMargin + (isStrong ? stringLineHeight : lineHeight)),
          isStrong ? strongIndicatorLine : indicatorLine);

      if (isStrong) {
        _drawText(canvas, hourNumbers[i ~/ 5], 11, size.width, Offset(center.dx, lineMargin + stringLineHeight + 5));
      }

      _rotate(canvas, center, 360 / 60);
    }
    canvas.restore();

    canvas.save();
    print('---> hour $hour');

    _rotate(canvas, center, (360 / 12) * (hour + (minute / 60)));
    canvas.drawLine(center, Offset(center.dx, center.dy - radius / 2), hourHandPainter);
    canvas.restore();

    canvas.save();
    _rotate(canvas, center, (360 / 60) * (minute + (second / 60)));
    canvas.drawLine(center, Offset(center.dx, center.dy - radius / 1.6), minuteHandPainter);
    canvas.restore();

    canvas.save();
    _rotate(canvas, center, (360 / 60) * second);
    canvas.drawLine(Offset(center.dx, center.dy + 10), Offset(center.dx, center.dy - radius / 1.4), secondsHandPainter);
    canvas.restore();

    canvas.drawCircle(center, radius / 30, secondsHandPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  _rotate(Canvas canvas, Offset center, double degree) {
    canvas.translate(center.dx, center.dy);
    canvas.rotate(_getRadian(degree));
    canvas.translate(-center.dx, -center.dy);
  }

  _drawText(Canvas canvas, String text, double fontSize, double width, Offset offset) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: ui.TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: width,
    );
    final moffset = Offset(offset.dx - textPainter.width / 2, offset.dy);
    textPainter.paint(canvas, moffset);
  }

  double _getRadian(double degree) => degree * pi / 180;
}
