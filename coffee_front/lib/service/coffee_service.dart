import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/coffee.dart'; // Coffee 모델 클래스 import
import '../models/coffee_record.dart';
import 'package:logger/logger.dart';

var logger = Logger();

String getCoffeeImage(int coffeeIndex) {
  return 'http://172.10.5.174:80/$coffeeIndex.jpg';
}

Future<List<Coffee>> fetchCoffeeDataByBrand(String brandName) async {
  var url = Uri.parse('http://172.10.5.174:80/coffee/by-brand/$brandName');
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
  var url = Uri.parse('http://172.10.5.174:80/drinked-coffees/by-user/$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    var now = DateTime.now();
    var decodedResponse = utf8.decode(response.bodyBytes);
    List<dynamic> jsonData = jsonDecode(decodedResponse);
    return jsonData.map((json) {
      Coffee coffee = Coffee.fromJson(json['coffee']);
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
