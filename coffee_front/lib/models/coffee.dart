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
}

    // @Column(name = "tall")
    // private int tall;

    // @Column(name = "grande")
    // private int grande;

    // @Column(name = "venti")
    // private int venti;
