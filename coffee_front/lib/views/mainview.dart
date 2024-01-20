import 'package:flutter/material.dart';
import '../const/margins.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: verticalMargin), // 상단 마진 적용
          Card(
            margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
            child: Container(
              height: 200, // 임시로 높이를 설정, 필요에 따라 조정 가능
            ),
          ),
          // 하단 카드
          Card(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin,
              vertical: verticalMargin / 2, // 하단 마진의 절반 적용
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(horizontalMargin), // 내부 패딩에 좌우 마진 적용
              child: Row(
                children: <Widget>[
                  // 왼쪽 텍스트와 이미지
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Starbucks',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('아이스 아메리카노'),
                        SizedBox(height: 8),
                        // 여기에 이미지 위젯을 추가하거나 이미지 자리를 비워 둘 수 있습니다.
                      ],
                    ),
                  ),
                  // 오른쪽 버튼
                  ElevatedButton(
                    onPressed: () {
                      // 버튼 클릭 이벤트
                    },
                    child: Text('버튼 1'),
                  ),
                ],
              ),
            ),
          ),
          // 추가적인 내용을 여기에 구현할 수 있습니다.
        ],
      ),
    );
  }
}
