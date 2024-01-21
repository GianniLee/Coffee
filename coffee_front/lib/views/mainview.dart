import 'package:flutter/material.dart';
import '../const/margins.dart'; // 마진 상수 파일 import
import '../models/selected_coffee.dart'; // SelectedCoffee 모델 import

class MainView extends StatelessWidget {
  const MainView({super.key});

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
            _buildBrandText(context), // Starbucks 텍스트 부분
            _buildCoffeeCards(context, coffeeList), // 수정된 부분
            // 추가적인 내용을 여기에 구현할 수 있습니다.
          ],
        ),
      ),
    );
  }

  // 상단 브랜드 텍스트 생성 함수: 브랜드명 표시
  Widget _buildBrandText(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
          left: horizontalMargin,
          right: horizontalMargin,
          top: horizontalMargin / 2),
      child: Text(
        'Starbucks',
        style: TextStyle(
            fontSize: 24, // 텍스트 크기 조정
            fontWeight: FontWeight.bold,
            height: 1.4), // 줄간격을 추가하여 디자인을 개선합니다.
        textAlign: TextAlign.center,
      ),
    );
  }

  // 커피 카드 리스트 뷰 생성 함수: SelectedCoffee 객체의 리스트를 페이지 뷰로 표시
  Widget _buildCoffeeCards(
      BuildContext context, List<SelectedCoffee> coffeeList) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Use a PageController with viewportFraction if you want to show a part of the adjacent cards
    PageController pageController = PageController(viewportFraction: 0.8);

    return Container(
      height: 300, // Adjust the height based on the content
      child: PageView.builder(
        controller: pageController,
        itemCount: coffeeList.length,
        itemBuilder: (context, index) {
          return _buildSelectedCoffee(
              context, screenWidth / 2, coffeeList[index]);
        },
      ),
    );
  }

  // 각 SelectedCoffee 객체에 대한 카드 생성 함수: 커피 이미지 및 메뉴 이름 등을 표시
  Widget _buildSelectedCoffee(
      BuildContext context, double cardWidth, SelectedCoffee coffee) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 전체 카드 여백
      child: Stack(
        alignment: Alignment.center, // 스택의 자식들을 중앙에 배치
        children: [
          // 커피 이미지와 메뉴 이름을 중앙에 정렬하기 위한 컬럼
          Column(
            mainAxisSize: MainAxisSize.min, // 내용에 맞게 높이 조절
            children: [
              // 커피 이미지 (카드 중앙에 정렬)
              SizedBox(
                width: cardWidth, // 카드 전체 너비
                child: AspectRatio(
                  aspectRatio: 3 / 4, // 이미지 종횡비
                  child: Container(
                    decoration: BoxDecoration(
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

    // 더미 데이터를 이용하여 세 개의 SelectedCoffee 객체 생성
    for (int i = 0; i < 3; i++) {
      coffeeList.add(createSelectedCoffee({
        'imageUrl': 'lib/sample/starbucks.jpg',
        'brandName': '스타벅스',
        'menuName': '아이스 아메리카노',
        'caffeineAmount': 200,
        'isHot': false,
        'size': 'M',
      }));
    }

    return coffeeList;
  }

  // 데이터로부터 SelectedCoffee 객체 생성 함수: 백엔드 데이터를 객체로 변환
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
}
