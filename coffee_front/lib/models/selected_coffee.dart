class SelectedCoffee {
  final String imageUrl;
  final String brandName;
  final String menuName;
  final int caffeineAmount;
  final bool isHot;
  final String size;
  bool liked = false;

  SelectedCoffee({
    required this.imageUrl,
    required this.brandName,
    required this.menuName,
    required this.caffeineAmount,
    required this.isHot,
    required this.size,
  });
}
