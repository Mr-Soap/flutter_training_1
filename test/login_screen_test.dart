import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training_1/features/auth/presentation/pages/login_screen.dart';

void main() {
  testWidgets('Harus memunculkan error merah jika login diklik saat form kosong', (WidgetTester tester) async {
    //arrange
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    expect(find.text('Email dan Password wajib diisi!'), findsNothing);

    //act
    final tombolLogin = find.byKey(const Key('tombol_login'));
    await tester.tap(tombolLogin);
    await tester.pumpAndSettle();

    //assert
    expect(find.text('Email dan Password wajib diisi!'), findsOneWidget);
  });
}