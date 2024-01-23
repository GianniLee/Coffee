import '../models/coffee.dart';

class CoffeeRecord {
  final String date;
  final String time;
  final int size;
  Coffee coffee;

  CoffeeRecord({
    required this.date,
    required this.time,
    required this.size,
    required this.coffee,
  });
}
