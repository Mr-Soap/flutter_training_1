import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_training_1/features/auth/auth_service.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late AuthService authService;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();

    authService = AuthService(mockApiClient);
  });

  group('AuthService Login Test -', () {
    test('Harus mengembalikan pesan error jika email kosong', () async {
      //act
      final result = await authService.loginUser('', 'password123');

      //assert
      expect(result, "Email dan Password tidak boleh kosong!");

      verifyNever(() => mockApiClient.loginKeServer(any(), any()));
    });

    test('Harus mengembalikan "Login Berhasil" jika API membalas true', () async {
      //arrange
      when (() => mockApiClient.loginKeServer('admin@utd.id', 'rahasia123')).thenAnswer((_) async => true);

      //act
      final result = await authService.loginUser('admin@utd.id', 'rahasia123');

      //assert
      expect(result, "Login Berhasil!");

      verify(() => mockApiClient.loginKeServer('admin@utd.id', 'rahasia123')).called(1);
    });

    test('Harus mengembalikan "Terjadi Kesalahan Jaringan" jika API error/mati', () async {
      // arrange
      when(() => mockApiClient.loginKeServer(any(), any())).thenThrow(Exception('No Internet'));

      // act
      final result = await authService.loginUser('user@utd.id', 'pass123');

      // assert
      expect(result, "Terjadi Kesalahan Jaringan!");
    });
  });
}