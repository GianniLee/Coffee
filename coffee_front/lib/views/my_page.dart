import 'package:flutter/material.dart';
import '../service/users_service.dart';
import 'dart:math' as math;

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int user_index = 1;
  double _currentValue = 0.1; // 초기 값

  @override
  void initState() {
    super.initState();
    _initializeHalfLife();
  }

  // 초기 half-life 값을 가져와서 설정
  void _initializeHalfLife() async {
    int halfLife = await getHalfLife(user_index);
    setState(() {
      // -1/t * ln(1/2) 계산
      _currentValue = -1 / halfLife * math.log(1/2);
    });
  }

  // '확인' 버튼 클릭시 호출될 메서드
  void _onConfirm() async {
    print("here");
    try {
      // _currentValue에서 n 값을 계산하고 반올림하여 int로 변환
      int calculatedHalfLife = (-1 / (_currentValue * math.log(1/2))).round();
      int changedHalfLife = await updateHalfLife(user_index, calculatedHalfLife);
      print('Changed Half Life: $changedHalfLife');
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: _currentValue,
            min: 0.1,
            max: 0.23,
            divisions: 130, // 0.001 단위로 조절 가능
            label: _currentValue.toStringAsFixed(3),
            onChanged: (double newValue) {
              setState(() {
                _currentValue = newValue;
              });
            },
          ),
          Text('Current Value: ${_currentValue.toStringAsFixed(3)}'),
          // 다른 위젯들...
          ElevatedButton(
            onPressed: _onConfirm,
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}
