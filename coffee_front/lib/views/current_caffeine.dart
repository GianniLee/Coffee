import 'dart:async';
import 'package:flutter/material.dart';
import 'caffeine_graph_painter.dart'; // 분리된 파일을 임포트합니다.

class currentCaffeineView extends StatefulWidget {
  const currentCaffeineView({super.key});

  @override
  _currentCaffeineView createState() => _currentCaffeineView();
}

class _currentCaffeineView extends State<currentCaffeineView> {
  late final List<CaffeineIntake> intakeRecords; // 카페인 섭취 기록 목록

  @override
  void initState() {
    super.initState();
    intakeRecords = createDummyData(); // 더미 데이터 생성

    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        // 그래프 업데이트
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double graphWidth = screenWidth - 32;

    return Center(
      child: Container(
        width: graphWidth,
        height: 150,
        child: CustomPaint(
          size: Size(graphWidth, 150),
          painter: CaffeineGraphPainter(
            decayConstant: 0.14,
            intakeRecords: intakeRecords,
          ),
          child: Center(child: Text('카페인 그래프')),
        ),
      ),
    );
  }
}
