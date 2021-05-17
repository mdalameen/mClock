import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mclock/common/app_colors.dart';
import 'package:mclock/components/clock_viewmodel.dart';
import 'package:mclock/injector.dart';

import 'dart:ui' as ui;

class AnalogClock extends StatelessWidget {
  final int offset;
  AnalogClock(this.offset);

  final vm = inject<ClockViewmodel>();
  static final dateFomat = DateFormat.Hms();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (_, d) {
        var now = DateTime.now();
        now = now.subtract(now.timeZoneOffset);
        now = now.add(Duration(milliseconds: offset));
        return CustomPaint(painter: _ClockPainter(now.hour, now.minute, now.second));
        return Text(dateFomat.format(now));
      },
      stream: vm.stream,
    );
  }
}

class _ClockPainter extends CustomPainter {
  int hour;
  int minute;
  int second;
  _ClockPainter(this.hour, this.minute, this.second);

  static final hourNumbers = <String>['12', ...List.generate(12, (index) => '${index + 1}')];
  static final hourRoman = <String>['XII', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI'];
  @override
  void paint(Canvas canvas, Size size) {
    final _outerCirclePaint = Paint()
      ..color = Color(0xFFDFE9F3)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    final _outerCircleShadowPaint = Paint()
      ..color = Colors.black.withAlpha(50)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20)
      ..strokeWidth = 1;
    final _innerCirclePaint = Paint()..color = Color(0xFFEBF0F4);
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

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width < size.height ? size.width : size.height) / 2;
    final innerCircleRadius = radius * 0.7;

    canvas.drawCircle(center, radius, _outerCircleShadowPaint);
    canvas.drawCircle(center, radius, _outerCirclePaint);
    canvas.drawCircle(center, innerCircleRadius, innerCircleShadowPaint);
    canvas.drawCircle(center, innerCircleRadius, _innerCirclePaint);
    canvas.save();
    final lineMargin = radius / 10;
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
        final textStyle = TextStyle(
          color: Colors.black,
          fontSize: 11,
        );
        final textSpan = TextSpan(
          text: hourNumbers[i ~/ 5],
          style: textStyle,
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: ui.TextDirection.ltr,
        );

        textPainter.layout(
          minWidth: 0,
          maxWidth: size.width,
        );
        final offset = Offset(center.dx - textPainter.width / 2, lineMargin + stringLineHeight + 5);
        textPainter.paint(canvas, offset);
      }

      canvas.translate(center.dx, center.dy);
      canvas.rotate(_getRadian(360 / 60));
      canvas.translate(-center.dx, -center.dy);
    }
    canvas.restore();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(_getRadian((360 / 60) * (hour + minute / 10)));
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(center, Offset(center.dx, center.dy - radius / 2), hourHandPainter);
    canvas.restore();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(_getRadian((360 / 60) * (minute + second / 60)));
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(center, Offset(center.dx, center.dy - radius / 1.6), minuteHandPainter);
    canvas.restore();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(_getRadian((360 / 60) * second));
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(Offset(center.dx, center.dy + 10), Offset(center.dx, center.dy - radius / 1.4), secondsHandPainter);
    canvas.restore();

    canvas.drawCircle(center, radius / 30, secondsHandPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double _getRadian(double degree) => degree * pi / 180;
}
