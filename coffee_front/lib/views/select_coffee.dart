// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../const/color.dart';
import '../service/coffee_service.dart';

class CoffeeTab {
  String title;
  IconData icon;
  List<String> coffeeData;

  CoffeeTab({
    required this.title,
    required this.icon,
    required this.coffeeData,
  });
}

class SelectCoffeePage extends StatefulWidget {
  const SelectCoffeePage({Key? key}) : super(key: key);

  @override
  _SelectCoffeePageState createState() => _SelectCoffeePageState();
}

class _SelectCoffeePageState extends State<SelectCoffeePage> {
  int selectedTabIndex = 0;
  List<String> selectedCoffeeData = [];

  @override
  void initState() {
    super.initState();
    // 초기 상태에서 "Liked Coffees" 탭의 데이터를 로드
    selectedCoffeeData = coffeeTabs[0].coffeeData;
  }

  List<CoffeeTab> coffeeTabs = [
    CoffeeTab(
      title: 'Liked Coffees',
      icon: Icons.favorite,
      coffeeData: ['liked 커피 데이터 1', 'liked 커피 데이터 2', 'liked 커피 데이터 3'],
    ),
    CoffeeTab(
      title: 'Recent Coffees',
      icon: Icons.access_time,
      coffeeData: ['recent 커피 데이터 1', 'recent 커피 데이터 2', 'recent 커피 데이터 3'],
    ),
    CoffeeTab(
      title: 'Starbucks',
      icon: Icons.store,
      coffeeData: [], // 초기 데이터는 비어있음
    ),
    // 더 많은 커피 브랜드 탭을 여기에 추가할 수 있습니다.
  ];

  void _updateSelectedCoffeeData(int tabIndex) {
    setState(() {
      selectedTabIndex = tabIndex;
      selectedCoffeeData = coffeeTabs[tabIndex].coffeeData;

      // Starbucks 탭 선택 시 데이터 로드
      if (tabIndex == 2) {
        _fetchCoffeeData(coffeeTabs[tabIndex].title);
      }
    });
  }

  Widget _buildTabItem(CoffeeTab tab, int index) {
    bool isSelected = index == selectedTabIndex;
    return Container(
      color: isSelected ? Colors.black : Colors.transparent,
      child: ListTile(
        leading: Icon(
          tab.icon,
          color: isSelected ? Colors.white : Colors.black,
        ),
        onTap: () => _updateSelectedCoffeeData(index),
        selected: isSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.black,
        title: Text('Add Coffee',
            style:
                TextStyle(color: MyColor.white)), // 텍스트 색상을 MyColor.white로 설정
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: MyColor.white), // 아이콘 색상을 MyColor.white로 설정
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        children: <Widget>[
          // 왼쪽 사이드바 구역
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: coffeeTabs.length,
              itemBuilder: (context, index) {
                return _buildTabItem(coffeeTabs[index], index);
              },
            ),
          ),
          // 오른쪽 메인 컨텐츠 구역
          Expanded(
            flex: 6,
            child: ListView.builder(
              itemCount: selectedCoffeeData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedCoffeeData[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // _fetchCoffeeData 메소드 수정
  Future<void> _fetchCoffeeData(String brandName) async {
    try {
      var coffeeData = await fetchCoffeeDataByBrand(brandName);
      setState(() {
        // 필요한 경우 다른 로직 추가
        coffeeTabs[2].coffeeData =
            coffeeData.map((coffee) => coffee.menuName).toList();
      });
    } catch (e) {
      // 에러 처리
    }
  }
}
