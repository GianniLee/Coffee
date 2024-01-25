import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/coffee.dart'; // Coffee 모델 클래스 import
import '../models/coffee_record.dart';
import 'package:logger/logger.dart';

var logger = Logger();
String apiUrl = 'http://172.10.5.174:80';

String getCoffeeImage(int coffeeIndex) {
  return '$apiUrl/$coffeeIndex.jpg';
}

Future<List<Coffee>> fetchCoffeeDataByBrand(String brandName) async {
  var url = Uri.parse('$apiUrl/coffee/by-brand/$brandName');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var decodedResponse = utf8.decode(response.bodyBytes);
    List<dynamic> jsonData = jsonDecode(decodedResponse);

    return jsonData.map((json) {
      Coffee coffee = Coffee.fromJson(json);
      coffee.imageUrl = getCoffeeImage(coffee.coffeeIndex); // 이미지 URL 설정
      return coffee;
    }).toList();
  } else {
    throw Exception('Failed to load coffee data for $brandName');
  }
}

Future<List<CoffeeRecord>> fetchDrinkedCoffees(int userId) async {
  var url = Uri.parse('$apiUrl/drinked-coffees/by-user/$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print("API Response: ${response.body}"); // API 응답 로그 출력
    var now = DateTime.now();
    var decodedResponse = utf8.decode(response.bodyBytes);
    List<dynamic> jsonData = jsonDecode(decodedResponse);
    return jsonData.map((json) {
      //print("API Response: ${json['coffee']}");
      Coffee coffee = Coffee.fromJson(json['coffee']);
      // print("Coffee Data: ${coffee.brandName}");
      // print("Coffee Data: ${coffee.coffeeIndex}");
      // 여기서 coffee.coffeeIndex를 사용하여 필요한 작업 수행
      return CoffeeRecord(
        date: json['date'],
        time: json['time'],
        size: json['size'],
        coffee: coffee,
      );
    }).where((record) {
      // 현재 시간 이후의 레코드는 제외
      var recordTime = DateTime.parse('${record.date}T${record.time}');
      return recordTime.isBefore(now);
    }).toList();
  } else {
    throw Exception('Failed to load drinked coffee data for user $userId');
  }
}

Future<void> createDrinkedCoffee(
    int userIndex, int coffeeIndex, int size, String date, String time) async {
  var url = Uri.parse(
      '$apiUrl/drinked-coffees/create/$userIndex/$coffeeIndex/$size/$date/$time');

  final response = await http.post(url);

  if (response.statusCode == 201) {
    // Created
    logger.i("Coffee record created: ${response.body}");
  } else {
    // Handle the error
    logger.e("Failed to create coffee record: ${response.statusCode}");
    throw Exception('Failed to create coffee record');
  }
}

Future<Coffee?> toggleCoffeeTemperature(int coffeeIndex, int isHot) async {
  if (isHot == 2 || isHot == 3) {
    // 2와 3은 온도 변경 불가능
    print("Temperature option is fixed. Cannot change.");
    return null;
  }

  var endpoint = isHot == 0 ? 'hot-to-cold' : 'cold-to-hot';
  var url = Uri.parse('$apiUrl/coffee/$endpoint/$coffeeIndex');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return Coffee.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to toggle coffee temperature');
  }
}
