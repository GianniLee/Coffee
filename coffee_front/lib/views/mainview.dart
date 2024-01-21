import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/margins.dart'; // 마진 상수 파일 import
import '../models/selected_coffee.dart'; // SelectedCoffee 모델 import

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  ValueNotifier<String> _brandNameNotifier =
      ValueNotifier("------"); // 초기 값으로 "Starbucks" 설정

  List<SelectedCoffee> coffeeList = [];
  int _temperatureOption = 0;

  @override
  void initState() {
    super.initState();
    coffeeList = createDummySelectedCoffeeList();
    _temperatureOption = coffeeList[0].isHot;
    ValueNotifier<String> _brandNameNotifier =
        ValueNotifier(coffeeList[0].brandName); // 초기 값으로 "Starbucks" 설정
  }

  @override
  void dispose() {
    _pageController.dispose();
    _brandNameNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 더미 데이터 리스트 생성
    List<SelectedCoffee> coffeeList =
        createDummySelectedCoffeeList(); // TODO: 여기 사용자가 좋아요한 메뉴 + 최근메뉴 불러오는걸로 변경하셈

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: basicMargin,
            ),

            _buildBrandText(), // Starbucks 텍스트 부분
            SizedBox(
              height: basicMargin,
            ),
            _buildCoffeeCards(context, coffeeList), // 수정된 부분
            SizedBox(
              height: basicMargin,
            ),
            _buildHotColdOption(_temperatureOption),
            // 추가적인 내용을 여기에 구현할 수 있습니다.
          ],
        ),
      ),
    );
  }

  // 상단 브랜드 텍스트 생성 함수: 브랜드명 표시
  Widget _buildBrandText() {
    _brandNameNotifier =
        ValueNotifier(coffeeList[0].brandName); // TODO: 여기 리스트가 비어있는 경우도 생각해야함.
    return ValueListenableBuilder<String>(
      valueListenable: _brandNameNotifier,
      builder: (context, brandName, child) {
        return Padding(
          padding: EdgeInsets.only(
            top: horizontalMargin / 2,
            left: horizontalMargin,
            right: horizontalMargin,
          ),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12), // 모서리 둥글게 처리
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 2.0,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
            child: Text(
              brandName, // 동적으로 업데이트되는 브랜드명
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  // 커피 카드 리스트 뷰 생성 함수: SelectedCoffee 객체의 리스트를 페이지 뷰로 표시
  // 리스트뷰가 바뀔때마다 현재 페이지의 다른 위젯들에 들어가는 데이터를 업데이트
  Widget _buildCoffeeCards(
      BuildContext context, List<SelectedCoffee> coffeeList) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemCount: coffeeList.length,
        itemBuilder: (context, index) {
          return _buildSelectedCoffee(context,
              MediaQuery.of(context).size.width / 2, coffeeList[index]);
        },
        onPageChanged: (index) {
          // 페이지가 바뀔 때마다 브랜드명을 업데이트하고 온도 옵션을 업데이트합니다.
          setState(() {
            _temperatureOption = coffeeList[index].isHot;
            _brandNameNotifier.value = coffeeList[index].brandName;
          });
        },
      ),
    );
  }

  // 각 SelectedCoffee 객체에 대한 카드 생성 함수: 커피 이미지 및 메뉴 이름 등을 표시
  Widget _buildSelectedCoffee(
      BuildContext context, double cardWidth, SelectedCoffee coffee) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 전체 카드 여백
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // 모서리 둥글게 처리
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 4.0,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center, // 스택의 자식들을 중앙에 배치
        children: [
          Column(
            mainAxisSize: MainAxisSize.min, // 내용에 맞게 높이 조절
            children: [
              // 커피 이미지 (카드 중앙에 정렬)
              SizedBox(
                width: cardWidth - 16, // 좌우 패딩 고려
                child: AspectRatio(
                  aspectRatio: 3 / 4, // 이미지 종횡비
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), // 이미지 모서리 둥글게 처리
                      image: DecorationImage(
                        image: AssetImage(coffee.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8), // 이미지와 메뉴명 사이 여백
              // 메뉴 이름 (카드 중앙에 정렬)
              Text(
                coffee.menuName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // 좋아요 아이콘 (우측 상단에 고정)
          Positioned(
            top: 8, // 상단 여백
            right: 8, // 우측 여백
            child: IconButton(
              icon: Icon(
                coffee.liked ? Icons.favorite : Icons.favorite_border,
                color: coffee.liked ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                // TODO: 좋아요 상태 변경 로직 구현
              },
            ),
          ),
        ],
      ),
    );
  }

  // 더미 데이터로 SelectedCoffee 객체 리스트 생성 함수: 테스트 목적으로 사용
  List<SelectedCoffee> createDummySelectedCoffeeList() {
    List<SelectedCoffee> coffeeList = [];

    // // 더미 데이터를 이용하여 SelectedCoffee 객체 생성
    // for (int i = 0; i < 2; i++) {
    //   coffeeList.add(createSelectedCoffee({
    //     'imageUrl': 'lib/sample/starbucks.jpg',
    //     'brandName': '스타벅스',
    //     'menuName': '아이스 아메리카노',
    //     'caffeineAmount': 200,
    //     'isHot': 1,
    //     'size': 'M',
    //   }));
    // }

    coffeeList.add(createSelectedCoffee({
      'imageUrl': 'lib/sample/MegaCoffee.jpg',
      'brandName': '메가커피',
      'menuName': '라떼',
      'caffeineAmount': 230,
      'isHot': 0,
      'size': 'M',
    }));

    coffeeList.add(createSelectedCoffee({
      'imageUrl': 'lib/sample/starbucks.jpg',
      'brandName': '스타벅스',
      'menuName': '아이스 아메리카노',
      'caffeineAmount': 200,
      'isHot': 1,
      'size': 'M',
    }));

    coffeeList.add(createSelectedCoffee({
      'imageUrl': 'lib/sample/MegaCoffee.jpg',
      'brandName': '메가커피',
      'menuName': '라떼',
      'caffeineAmount': 230,
      'isHot': 2,
      'size': 'M',
    }));

    coffeeList.add(createSelectedCoffee({
      'imageUrl': 'lib/sample/MegaCoffee_1.jpg',
      'brandName': '메가커피',
      'menuName': '커피 프라페',
      'caffeineAmount': 230,
      'isHot': 3,
      'size': 'M',
    }));

    return coffeeList;
  }

  // 데이터로부터 SelectedCoffee 객체 생성
  SelectedCoffee createSelectedCoffee(Map<String, dynamic> data) {
    return SelectedCoffee(
      imageUrl: data['imageUrl'],
      brandName: data['brandName'],
      menuName: data['menuName'],
      caffeineAmount: data['caffeineAmount'],
      isHot: data['isHot'],
      size: data['size'],
    );
  }

  String getTemperatureOption(int isHot) {
    switch (isHot) {
      case 0:
        return 'Hot';
      case 1:
        return 'Cold';
      case 2:
        return 'Only Hot';
      case 3:
        return 'Only Cold';
      default:
        return 'Hot'; // Default case, can adjust based on requirements
    }
  }

  Widget _buildHotColdOption(int isHot) {
    List<Widget> buttons = [];
    List<bool> isSelected = [];

    if (isHot == 2) {
      // Only Hot
      buttons.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Hot'),
      ));
      isSelected = [true];
    } else if (isHot == 3) {
      // Only Cold
      buttons.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Cold'),
      ));
      isSelected = [true];
    } else {
      // Both Hot and Cold
      buttons.addAll([
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Hot'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Cold'),
        ),
      ]);
      isSelected = (isHot == 1) ? [false, true] : [true, false];
    }

    Color fillColor = (isHot == 0 || isHot == 2) ? Colors.red : Colors.blue;

    return ToggleButtons(
      children: buttons,
      isSelected: isSelected,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            isSelected[buttonIndex] = buttonIndex == index;
          }
        });
      },
      selectedColor: Colors.white,
      color: Colors.black,
      fillColor: fillColor,
      borderColor: Colors.grey,
      selectedBorderColor: Colors.grey,
    );
  }
}
