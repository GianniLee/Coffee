import 'package:flutter/material.dart';
import '../const/margins.dart'; // 마진 상수 파일 import

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: basicMargin,
            ),
            _buildBrandText(context), // Starbucks 텍스트 부분
            _buildCardListView(context), // 카드 뷰 부분
            // 추가적인 내용을 여기에 구현할 수 있습니다.
          ],
        ),
      ),
    );
  }

  // 상단 브랜드 텍스트를 생성하는 함수
  Widget _buildBrandText(BuildContext context) {
    return Padding(
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

  // 카드 리스트 뷰를 생성하는 함수
  Widget _buildCardListView(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 화면 너비를 가져옵니다.

    // 가로 스크롤 가능한 카드 리스트
    return Container(
      height: 300, // 카드 리스트 뷰의 높이 설정
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10, // 예시로 10개의 카드를 나타내기 위해 설정
        itemBuilder: (context, index) {
          // 각 카드 아이템을 생성합니다.
          return _buildCardItem(context, screenWidth);
        },
      ),
    );
  }

  // 개별 카드 아이템을 생성하는 함수
  Widget _buildCardItem(BuildContext context, double screenWidth) {
    // Container의 너비를 화면 너비의 절반으로 고정합니다.
    double cardWidth = screenWidth / 2 - 2 * horizontalMargin - 16;

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.25 - horizontalMargin - 8, // 좌우 마진 조정
        vertical: 8,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 컨텐츠에 맞게 높이 조절
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Container로 감싼 음료 사진
                Container(
                  width: cardWidth, // 고정된 너비를 설정합니다.
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/sample/starbucks.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // 즐겨찾기 하트 아이콘
                Positioned(
                  top: 4,
                  right: 4,
                  child: Icon(Icons.favorite_border, color: Colors.grey),
                ),
              ],
            ),
            // 메뉴 이름
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '바닐라 크림 프라푸치노',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
