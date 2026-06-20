class SimpleCalculator {
  //fungsi 1 tambah
  int add(int a, int b) {
    return a + b;
  }

  //fungsi diskon
  double calculateDiscount(double price, double discountPercent) {
    if (discountPercent < 0 || discountPercent > 100) {
      throw ArgumentError('Discount tidak masuk akal!');
    }
    return price - (price * (discountPercent / 100));
  }
}