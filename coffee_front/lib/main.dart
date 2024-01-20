import 'package:flutter/material.dart';
import 'views/calendar.dart';
import 'views/mainview.dart';
import 'views/myPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1; // 현재 선택된 탭 인덱스

  // 각 탭에 매칭되는 위젯 리스트
  final List<Widget> _children = [
    CalendarView(),
    MainView(),
    MainView(),
    MyPageView(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // 현재 선택된 탭에 맞는 위젯을 표시
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // 탭 선택 시 호출
        currentIndex: _currentIndex, // 현재 선택된 탭 인덱스
        backgroundColor: Colors.black, // 배경색을 검은색으로 설정
        selectedItemColor: Colors.black, // 선택된 아이템의 색상을 흰색으로 설정
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이템의 색상을 회색으로 설정

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Add Coffee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Page',
          ),
        ],
      ),
    );
  }
}
