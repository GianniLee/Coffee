import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/coffee.dart';
import '../models/coffee_record.dart';

class CaffeineGraphPainter extends CustomPainter {
  final double decayConstant;
  final List<CoffeeRecord> coffeeRecords; // CoffeeRecord 리스트로 변경

  CaffeineGraphPainter({
    required this.decayConstant,
    required this.coffeeRecords, // CoffeeRecord 리스트를 받음
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawTimeAxisLines(canvas, size);
    _drawGraph(canvas, size);
    _drawPeakPoints(canvas, size);
    _drawCurrentPoint(canvas, size);
    _drawTimeAxis(canvas, size);
  }

  // 시간축에 대한 세로 직선을 그리는 메소드
  void _drawTimeAxisLines(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    final startTime = DateTime.now().subtract(Duration(hours: 6));
    final totalDuration =
        DateTime.now().add(Duration(hours: 6)).difference(startTime).inMinutes;

    // 한 시간마다 세로 선을 그립니다.
    for (var i = 0; i <= totalDuration; i += 60) {
      final time = startTime.add(Duration(minutes: i));
      final concentration = _caffeineConcentrationAtTime(time);
      final x = (i / totalDuration) * size.width;
      // 그래프의 높이를 계산합니다.
      final graphHeight = size.height -
          (concentration / _maxCaffeineConcentration()) * size.height;
      // 세로 선을 그 시점에서의 그래프 지점까지만 그립니다.
      canvas.drawLine(
          Offset(x, graphHeight), Offset(x, size.height), linePaint);
    }
  }

  // 시간축 선분을 그리는 메소드
  void _drawTimeAxis(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    // 시간축 선분을 그래프 아래 가장자리에 그립니다.
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);
  }

  // 그래프 그리기 메소드
  void _drawGraph(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final startTime = DateTime.now().subtract(Duration(hours: 6));
    final endTime = DateTime.now().add(Duration(hours: 6));
    final totalDuration = endTime.difference(startTime).inMinutes;

    for (var i = 0; i <= totalDuration; i += 5) {
      final time = startTime.add(Duration(minutes: i));
      final concentration = _caffeineConcentrationAtTime(time);
      final x = (i / totalDuration) * size.width;
      final y = size.height -
          (concentration / _maxCaffeineConcentration()) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  // 점과 레이블을 함께 그리는 메소드
  void _drawPointWithLabel(
      Canvas canvas, Offset point, Color color, double radius, String label) {
    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(point, radius, pointPaint);

    final textSpan = TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 12),
      text: label,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center, // 텍스트를 가운데 정렬합니다.
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    // 텍스트 위치를 조정하여 점 위 중앙에 오도록 설정합니다.
    final textOffset =
        Offset(point.dx - (textPainter.width / 2), point.dy - radius - 20);
    textPainter.paint(canvas, textOffset);
  }

  // 피크 값에 검은 점 찍기 메소드
  void _drawPeakPoints(Canvas canvas, Size size) {
    final startTime = DateTime.now().subtract(Duration(hours: 6));
    final endTime = DateTime.now();
    final totalDuration =
        DateTime.now().add(Duration(hours: 6)).difference(startTime).inMinutes;

    for (var record in coffeeRecords) {
      // CoffeeRecord의 date와 time을 결합하여 DateTime을 생성
      DateTime intakeTime = DateTime.parse('${record.date}T${record.time}');
      // 피크 시간은 섭취 후 15분으로 가정
      DateTime peakTime = intakeTime.add(Duration(minutes: 15));
      final peakConcentration = _caffeineConcentrationAtTime(peakTime);
      if (peakTime.isAfter(startTime) && peakTime.isBefore(endTime)) {
        final minutesSinceStart = peakTime.difference(startTime).inMinutes;
        final peakX = (minutesSinceStart / totalDuration) * size.width;
        final peakY = size.height -
            (peakConcentration / _maxCaffeineConcentration()) * size.height;

        // 점과 레이블을 그립니다.
        _drawPointWithLabel(canvas, Offset(peakX, peakY), Colors.black, 2.5,
            '${peakConcentration.floor()} mg');
      }
    }
  }

  // 현재 지점에 빨간 점 찍기 메소드 (수정됨)
  void _drawCurrentPoint(Canvas canvas, Size size) {
    final currentConcentration = _caffeineConcentrationAtTime(DateTime.now());
    final currentX = (3 * 60) / (6 * 60) * size.width; // 중간 지점
    final currentY = size.height -
        (currentConcentration / _maxCaffeineConcentration()) * size.height;
    _drawPointWithLabel(canvas, Offset(currentX, currentY), Colors.red, 5.0,
        '${currentConcentration.floor()} mg');
  }

  // 카페인 농도를 계산하는 함수
  double _caffeineConcentrationAtTime(DateTime time) {
    double totalConcentration = 0.0;
    for (var record in coffeeRecords) {
      // CoffeeRecord의 date와 time을 결합하여 DateTime을 생성
      DateTime intakeTime = DateTime.parse('${record.date}T${record.time}');
      //int amount = record.coffee.caffeineAmount; // Coffee 객체의 caffeineAmount 사용

      int amount = 0;
      if (record.size == 0) {
        amount = record.coffee.tall;
      } else if (record.size == 1) {
        amount = record.coffee.grande;
      } else {
        amount = record.coffee.venti;
      }

      final t = time.difference(intakeTime).inMinutes.toDouble();

      if (t >= 0) {
        double concentration = 0.0;
        if (t < 15) {
          concentration = (amount / 15) * t; // 15분 동안 선형 증가
        } else {
          concentration =
              amount * math.exp(-decayConstant * (t - 15) / 60); // 지수 감소
        }
        totalConcentration += concentration;
      }
    }
    return totalConcentration;
  }

  // 최대 카페인 농도를 계산하는 함수
  double _maxCaffeineConcentration() {
    double maxConcentration = 0.0;
    final startTime = DateTime.now().subtract(Duration(hours: 6));
    final endTime = DateTime.now().add(Duration(hours: 6));
    final totalDuration = endTime.difference(startTime).inMinutes;

    for (var i = 0; i <= totalDuration; i += 5) {
      final time = startTime.add(Duration(minutes: i));
      maxConcentration =
          math.max(maxConcentration, _caffeineConcentrationAtTime(time));
    }

    return maxConcentration;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
