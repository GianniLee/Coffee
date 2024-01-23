import 'dart:async';
import 'package:flutter/material.dart';
import '../views/caffeine_graph_painter.dart'; // 분리된 파일을 임포트합니다.
import '../models/coffee.dart';
import '../models/coffee_record.dart';
import '../service/coffee_service.dart';

class currentCaffeineView extends StatefulWidget {
  const currentCaffeineView({super.key});

  @override
  _currentCaffeineView createState() => _currentCaffeineView();
}

class _currentCaffeineView extends State<currentCaffeineView> {
  // 서버에서 가져온 커피 기록 데이터를 저장할 Future 객체
  Future<List<CoffeeRecord>>? _coffeeRecordsFuture;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 서버에서 사용자의 마신 커피 기록을 비동기적으로 가져옵니다.
    _coffeeRecordsFuture = fetchDrinkedCoffees(1);

    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        // 그래프 업데이트
        // 여기서는 coffeeRecords가 변하지 않으므로 실제 앱에서는 이를 적절히 갱신할 필요가 있음
        // 예를 들면, 새로운 카페인 섭취 이벤트를 coffeeRecords 리스트에 추가할 수 있음
      });
    });
  }

  @override
  void dispose() {
    // 위젯이 dispose될 때 Timer를 취소합니다.
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double graphWidth = screenWidth - 32;

    // FutureBuilder를 사용하여 비동기 데이터를 처리합니다.
    return FutureBuilder<List<CoffeeRecord>>(
      future: _coffeeRecordsFuture,
      builder: (context, snapshot) {
        // 데이터 로딩 중이라면 로딩 인디케이터를 표시
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 데이터 로딩 중 오류 발생 시 오류 메시지를 표시
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
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
                        coffeeRecords: snapshot.data!,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  height: 200,
                  child: _buildCoffeeRecentList(snapshot.data!),
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
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

        int caffeineAmount = 0;
        if (record.size == 0) {
          caffeineAmount = record.coffee.tall;
        } else if (record.size == 1) {
          caffeineAmount = record.coffee.grande;
        } else {
          caffeineAmount = record.coffee.venti;
        }

        return ListTile(
          leading: Container(
            width: 50, // 이미지의 너비를 제한합니다.
            height: 50, // 이미지의 높이를 제한합니다.
            child: Image.network(record.coffee.imageUrl), // 로컬 이미지를 사용하는 경우
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // 컬럼의 크기를 자식들의 크기에 맞게 조절합니다.
            children: <Widget>[
              Text(record.coffee.menuName), // 커피 이름
              Text('${caffeineAmount}mg'), // 카페인 양
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
      isHot: 1,
      tall: 75,
      grande: 150,
      venti: 300,
    );
    final coffee2 = Coffee(
      coffeeIndex: 2,
      imageUrl: 'lib/sample/MegaCoffee.jpg',
      brandName: 'Brand B',
      menuName: 'Latte',
      isHot: 0,
      tall: 75,
      grande: 150,
      venti: 300,
    );
    final coffee3 = Coffee(
      coffeeIndex: 3,
      imageUrl: 'lib/sample/starbucks.jpg',
      brandName: 'Brand C',
      menuName: 'Cappuccino',
      isHot: 1,
      tall: 100,
      grande: 200,
      venti: 250,
    );

    // 더미 커피 레코드 데이터
    final record1 = CoffeeRecord(
      date: '20240123',
      time: '06:00',
      size: 0,
      coffee: coffee1,
    );
    final record2 = CoffeeRecord(
      date: '20240123',
      time: '09:00',
      size: 1,
      coffee: coffee2,
    );
    final record3 = CoffeeRecord(
      date: '20240123',
      time: '19:20',
      size: 2,
      coffee: coffee3,
    );

    return [record1, record2, record3];
  }
}
