// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../const/color.dart';
import '../service/coffee_service.dart';
import '../models/coffee.dart';
import 'package:intl/intl.dart';

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
  int? selectedCoffeeIndex; // 사용자가 선택한 커피의 인덱스
  Coffee? selectedCoffee; // 사용자가 선택한 커피 객체

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
            imageUrl: getCoffeeImage(0),
            brandName: 'Liked',
            menuName: 'liked 커피 데이터 1',
            isHot: 1,
            tall: 100,
            grande: 200,
            venti: 300),
        Coffee(
            coffeeIndex: 2,
            imageUrl: getCoffeeImage(0),
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
            imageUrl: getCoffeeImage(0),
            brandName: 'Recent',
            menuName: 'recent 커피 데이터 1',
            isHot: 1,
            tall: 100,
            grande: 200,
            venti: 300),
        Coffee(
            coffeeIndex: 4,
            imageUrl: getCoffeeImage(0),
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
    Widget leadingIcon;

    // 로고를 사용해야 하는 탭인 경우 로고 이미지 위젯 사용
    if (tab.title == 'Starbucks') {
      leadingIcon = _buildLogoIcon('assets/icons/icon_Starbucks.png');
    } else if (tab.title == 'Angelinus') {
      leadingIcon = _buildLogoIcon('assets/icons/icon_Angelinus.webp');
    } else {
      // 그 외의 경우 기존 아이콘 사용
      leadingIcon =
          Icon(tab.icon, color: isSelected ? Colors.white : Colors.black);
    }

    return Container(
      color: isSelected ? Colors.black : Colors.transparent,
      child: ListTile(
        leading: leadingIcon,
        onTap: () => _updateSelectedCoffeeData(index),
        selected: isSelected,
      ),
    );
  }

  Widget _buildLogoIcon(String imagePath) {
    return SizedBox(
      width: 24, // 적절한 너비 설정
      height: 24, // 적절한 높이 설정
      child: ClipOval(
        child: Image.asset(imagePath, fit: BoxFit.cover),
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
                return _buildCoffeeListItem(coffee, index);
              },
            ),
          ),
        ],
      ),
      bottomSheet:
          selectedCoffee != null ? _buildFloatingSelectedCoffeeCard() : null,
    );
  }

  Widget _buildCoffeeListItem(Coffee coffee, int index) {
    bool isSelected = index == selectedCoffeeIndex;

    return ListTile(
        leading: Image.network(coffee.imageUrl, width: 100, height: 100),
        title: Text(
          coffee.menuName,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          'caffeine: ${coffee.tall}, ${coffee.grande}, ${coffee.venti}',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        tileColor: isSelected ? Colors.black : Colors.white, // 배경색 반전
        onTap: () => _onCoffeeSelected(coffee, index) // 여기서 인덱스도 전달
        );
  }

  // 커피 아이템이 탭될 때 호출되는 메소드
  void _onCoffeeSelected(Coffee coffee, int index) {
    setState(() {
      if (selectedCoffee == coffee) {
        selectedCoffee = null;
        selectedCoffeeIndex = null; // 선택 해제 시 인덱스도 null로 설정
      } else {
        selectedCoffee = coffee;
        selectedCoffeeIndex = index; // 새로운 커피 선택 시 인덱스 설정
      }
    });
  }

  Widget _buildFloatingSelectedCoffeeCard() {
    return Card(
      color: MyColor.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.close, color: MyColor.white),
              onPressed: () => setState(() {
                selectedCoffee = null;
                selectedCoffeeIndex = null;
              }),
            ),
            Image.network(selectedCoffee!.imageUrl, width: 56, height: 56),
            Text(
              selectedCoffee!.menuName,
              style: TextStyle(color: MyColor.white),
            ),
            // '추가' 버튼 구현
            TextButton(
              onPressed: () => _showAddDialog(),
              child: Text('추가', style: TextStyle(color: MyColor.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog() {
    // 초기 상태 설정
    String selectedSize = 'Grande'; // 기본값으로 'Grande' 설정
    int caffeineAmount = selectedCoffee?.grande ?? 0; // 'Grande' 카페인 양으로 초기화

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // 다이얼로그 상태를 위한 지역 변수
        String localSelectedSize = selectedSize;
        int localCaffeineAmount = caffeineAmount;

        // 다이얼로그 상태 변경을 위한 함수
        void updateLocalState(String? size) {
          if (size != null) {
            localSelectedSize = size;
            switch (size) {
              case 'Tall':
                localCaffeineAmount = selectedCoffee?.tall ?? 0;
                break;
              case 'Grande':
                localCaffeineAmount = selectedCoffee?.grande ?? 0;
                break;
              case 'Venti':
                localCaffeineAmount = selectedCoffee?.venti ?? 0;
                break;
            }
          }
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(selectedCoffee!.menuName),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Image.network(selectedCoffee!.imageUrl,
                        width: 150, height: 150),
                    SizedBox(height: 16),
                    Text(
                      selectedCoffee!.menuName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Caffeine: $localCaffeineAmount mg'), // 카페인 양 표시
                    SizedBox(height: 16),
                    ...['Tall', 'Grande', 'Venti']
                        .map((size) => RadioListTile<String>(
                              title: Text(size),
                              value: size,
                              groupValue: localSelectedSize,
                              onChanged: (value) {
                                setState(() {
                                  updateLocalState(value);
                                });
                              },
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 0), // 패딩 조절
                            )),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('취소'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text('추가'),
                  onPressed: () async {
                    // 사용자가 선택한 커피의 인덱스와 사이즈 인덱스를 기반으로 서버에 기록을 생성합니다.
                    // 여기서는 userIndex를 예시로 1로 설정했으나, 실제 사용자 인덱스를 사용해야 합니다.
                    // 또한, 날짜와 시간도 현재 날짜와 시간을 사용하여 포맷해야 합니다.
                    int userIndex = 1; // 예제로 사용자 인덱스를 1로 설정함
                    int coffeeIndex =
                        selectedCoffee!.coffeeIndex; // 선택된 커피의 인덱스
                    int sizeIndex = ['Tall', 'Grande', 'Venti']
                        .indexOf(localSelectedSize); // 사이즈 인덱스
                    String date = DateFormat('yyyyMMdd')
                        .format(DateTime.now()); // 오늘 날짜 포맷
                    String time =
                        DateFormat('HH:mm').format(DateTime.now()); // 현재 시간 포맷

                    try {
                      await createDrinkedCoffee(
                          userIndex, coffeeIndex, sizeIndex, date, time);
                      // 성공 메시지나 로그를 표시하거나 필요한 UI 업데이트를 수행할 수 있습니다.
                      logger.i("Coffee record successfully uploaded.");
                      Navigator.of(context).pop(); // 다이얼로그 닫기
                    } catch (e) {
                      // 에러 처리
                      logger.e("Error creating coffee record: $e");
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
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
