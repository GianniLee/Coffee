import 'package:coffee_front/service/users_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 전역 변수 선언
int? userIndex;
double? globalDecayConstant;

// 비동기 함수를 사용하여 값을 설정
Future<void> initializeGlobalValues() async {
  final prefs = await SharedPreferences.getInstance();
  userIndex = prefs.getInt('userIndex');
  if (userIndex != null) {
    globalDecayConstant = await getHalfLife(userIndex!); // getHalfLife가 비동기 함수라고 가정
  }
}