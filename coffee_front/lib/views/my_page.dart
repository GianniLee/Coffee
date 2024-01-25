import 'package:flutter/material.dart';
import '../service/users_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  int userIndex = 1;
  final List<String> _medications = [
    '시프란',
    '시프로신',
    '루복스',
    '파베린',
    '에리스로신',
    '에리스로마이신',
    '메르시론',
    '야즈민',
    '다이앤-35',
    '테오-듀르',
    '유니필'
  ];

  int? _selectedWeight;
  int? _selectedHeight;
  int? _selectedAge;
  String? _selectedMedication;
  bool _hasLiverDisease = false; // 기본값으로 false를 할당
  bool _isSmoker = false; // 기본값으로 false를 할당

  // 약의 선택 상태를 저장하는 Map
  Map<String, bool> _selectedMedications = {};

  @override
  void initState() {
    super.initState();
    // _initializeUserIndex();
    _medications.forEach((medication) {
      _selectedMedications[medication] = false;
    });
    _loadPreferences();
  }

  // void _initializeUserIndex() async {
  //   userIndex = await getUserIndex();
  //   // 필요한 경우 여기에서 추가적인 초기화 작업을 수행
  // }

  _saveMedicationPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedMedications.forEach((key, value) {
      prefs.setBool('medication_$key', value);
    });
  }

  _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedWeight = prefs.getInt('weight');
      _selectedHeight = prefs.getInt('height');
      _selectedAge = prefs.getInt('age');
      _selectedMedication = prefs.getString('medication') ?? _medications.first;
      _hasLiverDisease = prefs.getBool('liverDisease') ?? false;
      _isSmoker = prefs.getBool('smoker') ?? false;
    });
  }

  _savePreferences(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int?) {
      if (value != null) {
        prefs.setInt(key, value);
      } else {
        prefs.remove(key);
      }
    } else if (value is String?) {
      if (value != null && value != _medications.first) {
        prefs.setString(key, value);
      } else {
        prefs.remove(key);
      }
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  Future<double> calculateDecayConstant() async{
    double baseDecay = await getHalfLife(userIndex);  // 기본 Decay Constant 값
    double maxDecay = 0.23;  // 최대 Decay Constant 값

    // 각 항목에 대한 가중치 설정
    double weightFactor = (_selectedWeight ?? 70) / 1000;  // 예: 70kg이면 0.07
    double heightFactor = (_selectedHeight ?? 175) / 1000; // 예: 175cm이면 0.175
    double ageFactor = (_selectedAge ?? 30) / 1000;        // 예: 30세이면 0.03
    double liverDiseaseFactor = _hasLiverDisease ? 0.01 : 0.0; // 간 질환이 있으면 0.01
    double smokerFactor = _isSmoker ? 0.01 : 0.0;             // 흡연자면 0.01
    double medicationFactor = _selectedMedications.length * 0.005; // 약 복용 수에 따른 가중치

    // 가중치를 사용하여 decayConstant 계산
    double decayConstant = baseDecay - (weightFactor + ageFactor + liverDiseaseFactor + smokerFactor + medicationFactor) + heightFactor;

    // decayConstant가 정해진 범위 내에 있도록 조정
    if (decayConstant < baseDecay) decayConstant = baseDecay;
    if (decayConstant > maxDecay) decayConstant = maxDecay;

    return decayConstant;
    updateHalfLife(userIndex, decayConstant);
  }

  // 복용 중인 약을 위한 새로운 위젯 생성 메서드
  Widget _buildMedicationChips() {
    return Wrap(
      spacing: 8.0,
      children: _medications.map((medication) {
        return FilterChip(
          label: Text(medication),
          selected: _selectedMedications[medication]!,
          onSelected: (bool selected) {
            setState(() {
              // '선택 안함' 옵션을 처리
              if (medication == '선택 안함') {
                _selectedMedications.forEach((key, value) {
                  _selectedMedications[key] = false;
                });
              } else {
                // 다른 약이 선택된 경우 '선택 안함' 옵션을 해제
                _selectedMedications['선택 안함'] = false;
              }
              _selectedMedications[medication] = selected;
              Future<double> newDecayConstant = calculateDecayConstant();
            });
            _saveMedicationPreferences();
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double currentDecayConstant = 0.14;
    // 반감기 시간 계산
    int halfLifeTime = (currentDecayConstant != 0)
        ? ((-math.log(1/2) / currentDecayConstant).round()).toInt()
        : 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('MY PAGE'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('내 반감기', style: TextStyle(fontSize: 20)),
                // 반감기 시간 표시
                Text('${halfLifeTime} 시간',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          _buildDropdown('몸무게', _selectedWeight, 44, 100, (newValue) {
            setState(() => _selectedWeight = newValue);
            _savePreferences('weight', newValue);
            print("weight: ${newValue}");
          }),
          _buildDropdown('키', _selectedHeight, 155, 190, (newValue) {
            setState(() => _selectedHeight = newValue);
            _savePreferences('height', newValue);
            print("height: ${newValue}");
          }),
          _buildDropdown('나이', _selectedAge, 18, 100, (newValue) {
            setState(() => _selectedAge = newValue);
            _savePreferences('age', newValue);
            print("age: ${newValue}");
          }),
          _buildToggleButtons('간 질환', _hasLiverDisease, (newValue) {
            setState(() => _hasLiverDisease = newValue);
            _savePreferences('liverDisease', newValue);
            print("liverDisease: ${newValue}");
          }),
          _buildToggleButtons('흡연 여부', _isSmoker, (newValue) {
            setState(() => _isSmoker = newValue);
            _savePreferences('smoker', newValue);
            print("smoker: ${newValue}");
          }),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('복용 중인 약',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          _buildMedicationChips(),
        ],
      ),
    );
  }

  Widget _buildDropdown(String title, dynamic selectedValue, int min, int max,
      ValueChanged<dynamic> onChanged) {
    List<int> values = List.generate(max - min + 1, (index) => min + index);
    List<DropdownMenuItem<int>> menuItems =
        values.map<DropdownMenuItem<int>>((value) {
      return DropdownMenuItem<int>(
        value: value,
        child: Text(value.toString()),
      );
    }).toList();

    return ListTile(
      title: Text(title),
      subtitle: DropdownButton<int>(
        value: selectedValue,
        items: menuItems,
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }

  Widget _buildToggleButtons(
      String title, bool isSelected, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: ToggleButtons(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16), child: Text('예')),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('아니오')),
        ],
        onPressed: (int index) {
          onChanged(index == 0);
        },
        isSelected: [isSelected, !isSelected],
        color: Colors.grey,
        selectedColor: Colors.black,
        fillColor: Colors.lightBlueAccent,
        borderColor: Colors.grey,
        selectedBorderColor: Colors.black,
      ),
    );
  }
  // int user_index = 1;
  // double _currentValue = 0.1; // 초기 값
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _initializeHalfLife();
  // }
  //
  // // 초기 half-life 값을 가져와서 설정
  // void _initializeHalfLife() async {
  //   double halfLife = await getHalfLife(user_index);
  //   setState(() {
  //     // -1/t * ln(1/2) 계산
  //     _currentValue = halfLife;
  //   });
  // }
  //
  // // '확인' 버튼 클릭시 호출될 메서드
  // void _onConfirm() async {
  //   print("here");
  //   try {
  //     // _currentValue에서 n 값을 계산하고 반올림하여 int로 변환
  //     double changedHalfLife = await updateHalfLife(user_index, _currentValue);
  //     print('Changed Half Life: $changedHalfLife');
  //   } catch (e) {
  //     print('An error occurred: $e');
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Slider(
  //           value: _currentValue,
  //           min: 0.1,
  //           max: 0.23,
  //           divisions: 130, // 0.001 단위로 조절 가능
  //           label: _currentValue.toStringAsFixed(3),
  //           onChanged: (double newValue) {
  //             setState(() {
  //               _currentValue = newValue;
  //             });
  //           },
  //         ),
  //         Text('Current Value: ${_currentValue.toStringAsFixed(3)}'),
  //         // 다른 위젯들...
  //         ElevatedButton(
  //           onPressed: _onConfirm,
  //           child: Text('확인'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
