import 'package:flutter/material.dart';
import '../const/margins.dart'; // 마진 상수 파일 import
import '../models/coffee.dart'; // SelectedCoffee 모델 import
import '../const/color.dart';
import 'select_coffee.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  ValueNotifier<String> _brandNameNotifier =
      ValueNotifier("------"); // 초기 값으로 "Starbucks" 설정

  List<Coffee> coffeeList = [];
  int _temperatureOption = 0;
  int currentSize = 1; // 기본 사이즈를 1 (Grande)로 설정
  int _currentPageIndex = 0; // 현재 페이지 인덱스를 추적하는 변수
  // 각 사이즈별 카페인 양을 저장할 상태 변수
  int tallCaffeine = 0;
  int grandeCaffeine = 0;
  int ventiCaffeine = 0;

  @override
  void initState() {
    super.initState();
    coffeeList = createDummySelectedCoffeeList(); // 리스트를 초기화
    _brandNameNotifier.value = coffeeList[0].brandName; // 첫 번째 커피 브랜드명으로 초기화
    _temperatureOption = coffeeList[0].isHot; // 첫 번째 커피의 온도 옵션으로 초기화
    tallCaffeine = coffeeList[0].tall; // 첫 번째 커피의 카페인 양으로 초기화
    grandeCaffeine = coffeeList[0].grande;
    ventiCaffeine = coffeeList[0].venti;
    _currentPageIndex = 0; // 현재 페이지 인덱스를 0으로 초기화
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
    //List<Coffee> coffeeList =
    //createDummySelectedCoffeeList(); // TODO: 여기 사용자가 좋아요한 메뉴 + 최근메뉴 불러오는걸로 변경하셈

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: basicMargin,
            ),

            _buildBrandText(_brandNameNotifier), // Starbucks 텍스트 부분
            const SizedBox(
              height: basicMargin,
            ),
            _buildCoffeeCards(context, coffeeList), // 수정된 부분
            const SizedBox(
              height: basicMargin,
            ),
            _buildHotColdOption(_temperatureOption),
            const SizedBox(
              height: basicMargin,
            ),
            _buildSizeOption(),
            const SizedBox(
              height: basicMargin,
            ),
            _buildCaffeineOption(),
            const SizedBox(
              height: basicMargin * 4,
            ),
            _buildNavigateButton(),
            // 추가적인 내용을 여기에 구현할 수 있습니다.
          ],
        ),
      ),
    );
  }

  // 상단 브랜드 텍스트 생성 함수: 브랜드명 표시
  Widget _buildBrandText(brandNameNotifier) {
    // _brandNameNotifier =
    //     ValueNotifier(coffeeList[0].brandName); // TODO: 여기 리스트가 비어있는 경우도 생각해야함.
    return ValueListenableBuilder<String>(
      valueListenable: brandNameNotifier,
      builder: (context, brandName, child) {
        return Padding(
          padding: const EdgeInsets.only(
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
                  offset: const Offset(0, 0),
                  blurRadius: 2.0,
                  color: MyColor.black.withOpacity(0.25),
                ),
              ],
            ),
            child: Text(
              brandName, // 동적으로 업데이트되는 브랜드명
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
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
  Widget _buildCoffeeCards(BuildContext context, List<Coffee> coffeeList) {
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
          // 페이지가 바뀔 때마다 브랜드명을 업데이트합니다.
          setState(() {
            _brandNameNotifier.value = coffeeList[index].brandName;
            _temperatureOption = coffeeList[index].isHot;
            currentSize = 1; // 사이즈를 기본값으로 재설정
            // 해당 커피의 기본 카페인 값을 설정

            _updateCaffeineAmount(index);
          });
        },
      ),
    );
  }

  // 각 SelectedCoffee 객체에 대한 카드 생성 함수: 커피 이미지 및 메뉴 이름 등을 표시
  Widget _buildSelectedCoffee(
      BuildContext context, double cardWidth, Coffee coffee) {
    return Container(
      margin:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 전체 카드 여백
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // 모서리 둥글게 처리
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 4.0,
            color: MyColor.black.withOpacity(0.25),
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
              const SizedBox(height: 8), // 이미지와 메뉴명 사이 여백
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
  List<Coffee> createDummySelectedCoffeeList() {
    List<Coffee> coffeeList = [];

    coffeeList.add(createSelectedCoffee({
      'coffeeIndex': 1,
      'imageUrl': 'lib/sample/MegaCoffee.jpg',
      'brandName': '메가커피',
      'menuName': '라떼',
      'isHot': 0,
      'tall': 75,
      'grande': 150,
      'venti': 300,
    }));

    coffeeList.add(createSelectedCoffee({
      'coffeeIndex': 2,
      'imageUrl': 'lib/sample/starbucks.jpg',
      'brandName': '스타벅스',
      'menuName': '아이스 아메리카노',
      'isHot': 1,
      'tall': 100,
      'grande': 150,
      'venti': 200,
    }));

    coffeeList.add(createSelectedCoffee({
      'coffeeIndex': 3,
      'imageUrl': 'lib/sample/MegaCoffee.jpg',
      'brandName': '메가커피',
      'menuName': '라떼',
      'isHot': 2,
      'tall': -1,
      'grande': 150,
      'venti': 200,
    }));

    coffeeList.add(createSelectedCoffee({
      'coffeeIndex': 4,
      'imageUrl': 'lib/sample/MegaCoffee_1.jpg',
      'brandName': '메가커피',
      'menuName': '커피 프라페',
      'isHot': 3,
      'tall': -1,
      'grande': 150,
      'venti': -1,
    }));

    return coffeeList;
  }

  // 데이터로부터 SelectedCoffee 객체 생성
  Coffee createSelectedCoffee(Map<String, dynamic> data) {
    return Coffee(
      coffeeIndex: data['coffeeIndex'],
      imageUrl: data['imageUrl'],
      brandName: data['brandName'],
      menuName: data['menuName'],
      isHot: data['isHot'],
      tall: data['tall'],
      grande: data['grande'],
      venti: data['venti'],
    );
  }

  Widget _buildHotColdOption(int isHot) {
    List<Widget> buttons = [];
    List<bool> isSelected = [];

    if (isHot == 2) {
      // Only Hot
      buttons.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Hot'),
      ));
      isSelected = [true];
    } else if (isHot == 3) {
      // Only Cold
      buttons.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Cold'),
      ));
      isSelected = [true];
    } else {
      // Both Hot and Cold
      buttons.addAll([
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Hot'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Cold'),
        ),
      ]);
      isSelected = (isHot == 1) ? [false, true] : [true, false];
    }

    Color fillColor = (isHot == 0 || isHot == 2) ? Colors.red : Colors.blue;

    return ToggleButtons(
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
      selectedColor: MyColor.white,
      color: MyColor.black,
      fillColor: fillColor,
      borderColor: MyColor.grey,
      selectedBorderColor: MyColor.grey,
      children: buttons,
    );
  }

  Widget _buildSizeOption() {
    List<Widget> sizeButtons = [];
    List<bool> isSelected = [];

    // Check if tall size is available
    if (tallCaffeine != -1) {
      sizeButtons.add(
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Tall')),
      );
      isSelected
          .add(currentSize == 0); // Set to true if tall is the current size
    }

    // Check if grande size is available
    if (grandeCaffeine != -1) {
      sizeButtons.add(
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Grande')),
      );
      isSelected
          .add(currentSize == 1); // Set to true if grande is the current size
    }
    // Check if venti size is available
    if (ventiCaffeine != -1) {
      sizeButtons.add(
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Venti')),
      );
      isSelected
          .add(currentSize == 2); // Set to true if venti is the current size
    }

    return ToggleButtons(
      children: sizeButtons,
      isSelected: isSelected,
      onPressed: (int index) {
        setState(() {
          currentSize = index;
          if (_pageController.hasClients) {
            final currentPageIndex = _pageController.page!.round();
            _updateCaffeineAmount(currentPageIndex);
          }
        });
      },
      // 버튼 스타일 지정
      selectedColor: MyColor.white,
      color: MyColor.black,
      fillColor: MyColor.black,
      borderColor: MyColor.grey,
      selectedBorderColor: MyColor.grey,
    );
  }

  void _updateCaffeineAmount(int pageIndex) {
    setState(() {
      tallCaffeine = coffeeList[pageIndex].tall;
      grandeCaffeine = coffeeList[pageIndex].grande;
      ventiCaffeine = coffeeList[pageIndex].venti;
    });
  }

  // 카페인 옵션 위젯 생성 함수 수정
  Widget _buildCaffeineOption() {
    // 현재 선택된 사이즈에 따른 카페인 양을 상태 변수에서 가져와서 표시
    int caffeineAmount;
    switch (currentSize) {
      case 0:
        caffeineAmount = tallCaffeine;
        break;
      case 1:
        caffeineAmount = grandeCaffeine;
        break;
      case 2:
        caffeineAmount = ventiCaffeine;
        break;
      default:
        caffeineAmount = grandeCaffeine; // 기본값은 Grande
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Caffeine: $caffeineAmount mg",
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  // 커피 추가 버튼
  // 본 페이지에서 새 페이지로 이동하는 버튼
  Widget _buildNavigateButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectCoffeePage()),
        );
      },
      child: Text('Coffee List'),
    );
  }
}
