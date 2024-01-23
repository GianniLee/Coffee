// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../const/color.dart';
import '../service/coffee_service.dart';
import '../models/coffee.dart';

class CoffeeTab {
  String title;
  IconData icon;
  List<Coffee> coffeeData; // Coffee 객체의 리스트로 변경

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
    selectedCoffeeData =
        coffeeTabs[0].coffeeData.map((coffee) => coffee.menuName).toList();
  }

  List<CoffeeTab> coffeeTabs = [
    CoffeeTab(
      title: 'Liked Coffees',
      icon: Icons.favorite,
      coffeeData: [
        // 예시 데이터
        Coffee(
            coffeeIndex: 1,
            imageUrl: 'http://172.10.7.70:80/0.jpg',
            brandName: 'Liked',
            menuName: 'liked 커피 데이터 1',
            isHot: 1,
            tall: 100,
            grande: 200,
            venti: 300),
        Coffee(
            coffeeIndex: 2,
            imageUrl: 'http://172.10.7.70:80/0.jpg',
            brandName: 'Liked',
            menuName: 'liked 커피 데이터 2',
            isHot: 1,
            tall: 100,
            grande: 200,
            venti: 300),
      ],
    ),
    CoffeeTab(
      title: 'Recent Coffees',
      icon: Icons.access_time,
      coffeeData: [
        // 예시 데이터
        Coffee(
            coffeeIndex: 3,
            imageUrl: 'http://172.10.7.70:80/0.jpg',
            brandName: 'Recent',
            menuName: 'recent 커피 데이터 1',
            isHot: 1,
            tall: 100,
            grande: 200,
            venti: 300),
        Coffee(
            coffeeIndex: 4,
            imageUrl: 'http://172.10.7.70:80/0.jpg',
            brandName: 'Recent',
            menuName: 'recent 커피 데이터 2',
            isHot: 1,
            tall: 100,
            grande: 200,
            venti: 300),
      ],
    ),
    CoffeeTab(
      title: 'Starbucks',
      icon: Icons.store,
      coffeeData: [], // 초기 데이터는 비어있음
    ),
    CoffeeTab(
      title: 'Angelinus',
      icon: Icons.storefront_outlined,
      coffeeData: [],
    ),
    // 더 많은 커피 브랜드 탭을 여기에 추가할 수 있습니다.
  ];

  void _updateSelectedCoffeeData(int tabIndex) {
    setState(() {
      selectedTabIndex = tabIndex;
      selectedCoffeeData = coffeeTabs[tabIndex]
          .coffeeData
          .map((coffee) => coffee.menuName)
          .toList();

      if (tabIndex == 2 || tabIndex == 3) {
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
              itemCount: coffeeTabs[selectedTabIndex].coffeeData.length,
              itemBuilder: (context, index) {
                Coffee coffee = coffeeTabs[selectedTabIndex].coffeeData[index];
                return ListTile(
                  leading:
                      Image.network(coffee.imageUrl, width: 100, height: 100),
                  title: Text(coffee.menuName),
                  // subtitle: Text(
                  //     '${coffee.brandName}'),
                  subtitle: Text(
                      'caffeine: ${coffee.tall}, ${coffee.grande}, ${coffee.venti}'),
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
      print('Received data: $coffeeData'); // 서버로부터 받은 데이터 로그 출력

      setState(() {
        // selectedTabIndex를 사용하여 현재 선택된 탭의 coffeeData 업데이트
        coffeeTabs[selectedTabIndex].coffeeData = coffeeData;
        selectedCoffeeData =
            coffeeData.map((coffee) => coffee.menuName).toList();
      });
    } catch (e) {
      print('Error fetching data: $e'); // 에러 로그
    }
  }
}
