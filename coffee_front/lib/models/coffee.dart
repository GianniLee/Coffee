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
    return Coffee(
      coffeeIndex: json['coffeeIndex'],
      imageUrl: json['imageUrl'] ??
          'lib/sample/MegaCoffee_1.jpg', // 이미지 URL이 없는 경우 기본값 설정
      brandName: json['brandName'],
      menuName: json['menuName'],
      isHot: json['isHot'],
      tall: json['tall'],
      grande: json['grande'],
      venti: json['venti'],
    );
  }
}

    // @Column(name = "tall")
    // private int tall;

    // @Column(name = "grande")
    // private int grande;

    // @Column(name = "venti")
    // private int venti;
