import 'package:flutter/material.dart';

class Coffee {
  final int coffeeIndex;
  final String imageUrl; //이건 따로 받아와야함
  final String brandName;
  final String menuName;
  //final int caffeineAmount;
  final int isHot;
  //final int size;
  final int tall;
  final int grande;
  final int venti;
  bool liked = false;

  Coffee({
    required this.coffeeIndex,
    required this.imageUrl,
    required this.brandName,
    required this.menuName,
    //required this.caffeineAmount,
    required this.isHot,
    //required this.size,
    required this.tall,
    required this.grande,
    required this.venti,
  });

  // JSON 데이터를 받아 Coffee 객체를 생성하는 팩토리 생성자
  factory Coffee.fromJson(Map<String, dynamic> json) {
    int coffeeIndex = json['coffeeIndex'] ?? 0;
    String imageUrl = 'http://172.10.7.70:80/$coffeeIndex.jpg'; // 이미지 URL 생성

    return Coffee(
      coffeeIndex: coffeeIndex,
      imageUrl: imageUrl, // 생성된 이미지 URL 사용
      brandName: json['brandName'] ?? '',
      menuName: json['coffeeName'] ?? '',
      isHot: json['isHot'] ?? 0,
      tall: json['tall'] ?? 0,
      grande: json['grande'] ?? 0,
      venti: json['venti'] ?? 0,
    );
  }
}

    // @Column(name = "tall")
    // private int tall;

    // @Column(name = "grande")
    // private int grande;

    // @Column(name = "venti")
    // private int venti;
