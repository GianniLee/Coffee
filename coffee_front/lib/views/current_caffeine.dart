import 'dart:async';
import 'package:flutter/material.dart';
import '../views/caffeine_graph_painter.dart'; // 분리된 파일을 임포트합니다.
import '../models/coffee.dart';
import '../models/coffee_record.dart';

class currentCaffeineView extends StatefulWidget {
  const currentCaffeineView({super.key});

  @override
  _currentCaffeineView createState() => _currentCaffeineView();
}

class _currentCaffeineView extends State<currentCaffeineView> {
  late final List<CoffeeRecord> coffeeRecords; // CoffeeRecord 리스트를 저장할 변수

  @override
  void initState() {
    super.initState();
    coffeeRecords = createDummyData(); // CoffeeRecord 더미 데이터 생성

    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        // 그래프 업데이트
        // 여기서는 coffeeRecords가 변하지 않으므로 실제 앱에서는 이를 적절히 갱신할 필요가 있음
        // 예를 들면, 새로운 카페인 섭취 이벤트를 coffeeRecords 리스트에 추가할 수 있음
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double graphWidth = screenWidth - 32;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 32),
          Center(
            child: Container(
              width: graphWidth,
              height: 150,
              child: CustomPaint(
                size: Size(graphWidth, 150),
                painter: CaffeineGraphPainter(
                  decayConstant: 0.14,
                  coffeeRecords: coffeeRecords,
                ),
              ),
            ),
          ),
          SizedBox(height: 32), // 그래프와 리스트 사이의 간격
          Container(
            height: 200, // ListView가 차지할 명시적인 높이
            child: _buildCoffeeRecentList(coffeeRecords),
          ),
        ],
      ),
    );
  }

  Widget _buildCoffeeRecentList(List<CoffeeRecord> coffeeRecords) {
    // 현재 시간으로부터 각 커피 섭취 시간을 계산하는 함수
    String _getTimeAgo(DateTime dateTime) {
      final duration = DateTime.now().difference(dateTime);
      if (duration.inMinutes < 60) {
        return '${duration.inMinutes} mins ago';
      } else if (duration.inHours < 24) {
        return '${duration.inHours} hours ago';
      } else {
        return '${duration.inDays} days ago';
      }
    }

    // 커피 레코드를 최신 순으로 정렬합니다.
    coffeeRecords.sort((a, b) {
      DateTime dateTimeA = DateTime.parse('${a.date}T${a.time}');
      DateTime dateTimeB = DateTime.parse('${b.date}T${b.time}');
      return dateTimeB.compareTo(dateTimeA); // 최신 날짜가 먼저 오도록 정렬
    });

    return ListView.builder(
      shrinkWrap: true, // ScrollView 안에 ListView가 있을 때 필요합니다.
      physics:
          NeverScrollableScrollPhysics(), // 부모 ScrollView의 스크롤을 사용하기 위해 설정합니다.
      itemCount: coffeeRecords.length,
      itemBuilder: (context, index) {
        final record = coffeeRecords[index];
        DateTime intakeTime = DateTime.parse('${record.date}T${record.time}');

        return ListTile(
          leading: Container(
            width: 50, // 이미지의 너비를 제한합니다.
            height: 50, // 이미지의 높이를 제한합니다.
            child: Image.asset(record.coffee.imageUrl), // 로컬 이미지를 사용하는 경우
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // 컬럼의 크기를 자식들의 크기에 맞게 조절합니다.
            children: <Widget>[
              Text(record.coffee.menuName), // 커피 이름
              Text('${record.coffee.caffeineAmount}mg'), // 카페인 양
            ],
          ),
          trailing: Text(_getTimeAgo(intakeTime)), // 지난 시간
        );
      },
    );
  }

  // 더미 데이터 생성 함수
  List<CoffeeRecord> createDummyData() {
    // 더미 커피 데이터
    final coffee1 = Coffee(
      coffeeIndex: 1,
      imageUrl: 'lib/sample/starbucks.jpg',
      brandName: 'Brand A',
      menuName: 'Espresso',
      caffeineAmount: 100,
      isHot: 1,
      size: 1,
    );
    final coffee2 = Coffee(
      coffeeIndex: 2,
      imageUrl: 'lib/sample/MegaCoffee.jpg',
      brandName: 'Brand B',
      menuName: 'Latte',
      caffeineAmount: 150,
      isHot: 0,
      size: 2,
    );
    final coffee3 = Coffee(
      coffeeIndex: 3,
      imageUrl: 'lib/sample/starbucks.jpg',
      brandName: 'Brand C',
      menuName: 'Cappuccino',
      caffeineAmount: 80,
      isHot: 1,
      size: 1,
    );

    // 더미 커피 레코드 데이터
    final record1 = CoffeeRecord(
      date: '20240123',
      time: '06:00',
      coffee: coffee1,
    );
    final record2 = CoffeeRecord(
      date: '20240123',
      time: '09:00',
      coffee: coffee2,
    );
    final record3 = CoffeeRecord(
      date: '20240123',
      time: '12:40',
      coffee: coffee3,
    );

    return [record1, record2, record3];
  }

  // TODO: 1) 서버에 현재 UserID 를 보내고, 12시간 이내로 섭취한 모든 coffee_record list를 요청하는 함수 선언

  // TODO: 2) 받아온 coffee_record list를 /models/Coffee의 형식으로 전환, 역시 list로 만듦

  // TODO: 3) 만든 Coffee list를 caffeine_graph_painter에 제공, 그래프 작성

  // TODO: 4) 만든 Coffee list를 최근순으로 정렬해서 리스트로 보여줌.
}
