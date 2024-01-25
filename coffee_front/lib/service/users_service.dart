import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

var logger = Logger();
const String apiUrl = "http://172.10.5.174:80";

Future<bool> login(String id, String pwd) async {
  final url = 'http://your-server.com/users/login/$id/$pwd'; // 서버의 URL로 변경
  try {
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final userIndex = int.parse(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userIndex', userIndex);
      return true; // 로그인 성공
    }
  } catch (e) {
    print('Login error: $e');
  }
  return false; // 로그인 실패
}

Future<int> getUserIndex() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userIndex') ?? 0; // 'userIndex'가 없다면 기본값으로 0 반환
}

Future<double> getHalfLife(int userIndex) async {
  var url = Uri.parse('$apiUrl/users/${userIndex}/half-life');
  // HTTP 요청 전 로그

  final response = await http.get(url);
  print("half life");
  if (response.statusCode == 200) {
    // HTTP 응답이 성공적이면, 응답 본문에서 int 값을 추출합니다.
    return double.parse(response.body);
  } else {
    // 오류 처리: 적절한 예외를 던지거나 기본값을 반환할 수 있습니다.
    throw Exception('Failed to load half-life initial data');
  }
}

Future<double> updateHalfLife(int userIndex, double newHalfLife) async {
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
    return double.parse(response.body);
  } else {
    // 오류 처리: 적절한 예외를 던지거나 기본값을 반환할 수 있습니다.
    throw Exception('Failed to load half-life data');
  }
}

