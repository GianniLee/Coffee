import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/coffee.dart'; // Coffee 모델 클래스 import
import 'package:logger/logger.dart';

var logger = Logger();

Future<List<Coffee>> fetchCoffeeDataByBrand(String brandName) async {
  var url = Uri.parse('http://172.10.7.70:80/coffee/by-brand/$brandName');

  // HTTP 요청 전 로그
  //logger.d('Requesting data for $brandName');
  //print("before response");
  final response = await http.get(url);
  //print("response get");
  // HTTP 응답 후 로그
  //logger.d('Response received for $brandName');

  if (response.statusCode == 200) {
    // UTF-8로 디코딩
    var decodedResponse = utf8.decode(response.bodyBytes);
    List<dynamic> jsonData = jsonDecode(decodedResponse);
    //logger.d(jsonData); // Debug 로그
    return jsonData.map((json) => Coffee.fromJson(json)).toList();
  } else {
    //logger.e('Failed to load coffee data for $brandName'); // Error 로그
    throw Exception('Failed to load coffee data for $brandName');
  }
}
