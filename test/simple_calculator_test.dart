import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training_1/features/calculator/simple_calculator.dart';

void main() {
  group('Pengujian SimpleCalculator-', () {
    late SimpleCalculator calculator;

    setUp(() {
      calculator = SimpleCalculator();
    });

    //robot 1 = menguji pertambahan
    test('Fungsi add() harus mengembalikan hasil 5 jika 2 ditambah 3', () {
      // act
      final result = calculator.add(2, 3);

      //assert
      expect(result, 5);
    });

    //robot 2 = perhitungan diskon
    test(
      'Fungsi calculateDiscount() harus mengembalikan 8000 jika harga 10000 diskon 20%',
      () {
        //act
        final result = calculator.calculateDiscount(10000, 20);

        //asset
        expect(result, 8000);
      },
    );

    //robot 3 = menguji error
    test(
      'Fungsi calculateDiscount() harus melempar error jika diskon 150%',
      () {
        expect(
          //act
          () => calculator.calculateDiscount(10000, 150),

          //assert
          throwsArgumentError,
        );
      },
    );
  });
}
