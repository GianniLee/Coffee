import '../models/coffee.dart';

class CoffeeRecord {
  final String date;
  final String time;
  Coffee coffee;

  CoffeeRecord({
    required this.date,
    required this.time,
    required this.coffee,
  });
}
