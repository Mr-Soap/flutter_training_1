import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_training_1/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('End-to-End: Alur Login Admin Sukses', (WidgetTester tester) async {
    //arrange
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    //act
    final fieldEmail = find.byKey(const Key('field_email'));
    await tester.enterText(fieldEmail, 'admin@utd.id');

    final fieldPassword = find.byKey(const Key('field_password'));
    await tester.enterText(fieldPassword, 'rahasia123');

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    final tombolLogin = find.byKey(const Key('tombol_login'));
    await tester.tap(tombolLogin);

    await tester.pumpAndSettle(const Duration(seconds: 3));
    
    //assert
    expect(find.text('Selamat Datang Admin!'), findsOneWidget);
    expect(find.text('LOGIN SEKARANG'), findsNothing);
  });
}