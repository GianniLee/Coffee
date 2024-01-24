import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();
const String apiUrl = "http://172.10.5.174:80";

Future<int> getHalfLife(int userIndex) async {
  var url = Uri.parse('$apiUrl/users/${userIndex}/half-life');
  // HTTP 요청 전 로그

  final response = await http.get(url);
  print("half life");
  if (response.statusCode == 200) {
    // HTTP 응답이 성공적이면, 응답 본문에서 int 값을 추출합니다.
    return int.parse(response.body);
  } else {
    // 오류 처리: 적절한 예외를 던지거나 기본값을 반환할 수 있습니다.
    throw Exception('Failed to load half-life initial data');
  }
}

Future<int> updateHalfLife(int userIndex, int newHalfLife) async {
  print(
      'updateHalfLife called with userIndex: $userIndex, newHalfLife: $newHalfLife');
  var url =
      Uri.parse('$apiUrl/users/${userIndex}/update-half-life/${newHalfLife}');
  // HTTP 요청 전 로그

  final response = await http.put(url);
  print("got response");
  print(response);
  if (response.statusCode == 200) {
    // HTTP 응답이 성공적이면, 응답 본문에서 int 값을 추출합니다.
    return int.parse(response.body);
  } else {
    // 오류 처리: 적절한 예외를 던지거나 기본값을 반환할 수 있습니다.
    throw Exception('Failed to load half-life data');
  }
}
