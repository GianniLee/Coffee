import 'package:coffee_front/const/color.dart';
import 'package:coffee_front/views/current_caffeine.dart';
import 'package:flutter/material.dart';
import 'views/calendar.dart';
import 'views/main_view.dart';
import 'views/my_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0; // 현재 선택된 탭 인덱스

  // 각 탭에 매칭되는 위젯 리스트
  final List<Widget> _children = [
    const currentCaffeineView(),
    const MainView(),
    const CalendarView(),
    const MyPageView(),
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
        backgroundColor: MyColor.black, // 배경색을 검은색으로 설정
        selectedItemColor: MyColor.black, // 선택된 아이템의 색상을 흰색으로 설정
        unselectedItemColor: MyColor.grey, // 선택되지 않은 아이템의 색상을 회색으로 설정

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Add Coffee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
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
