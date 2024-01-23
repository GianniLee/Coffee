class Coffee {
  final int coffeeIndex;
  final String imageUrl;
  final String brandName;
  final String menuName;
  final int caffeineAmount;
  final int isHot;
  final int size;
  bool liked = false;

  Coffee({
    required this.coffeeIndex,
    required this.imageUrl,
    required this.brandName,
    required this.menuName,
    required this.caffeineAmount,
    required this.isHot,
    required this.size,
  });
}
