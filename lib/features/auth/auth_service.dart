abstract class ApiClient {
  Future<bool> loginKeServer(String email, String password);
}

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future<String> loginUser(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return "Email dan Password tidak boleh kosong!";
    }

    try {
      final isSuccess = await apiClient.loginKeServer(email, password);

      if (isSuccess) {
        return "Login Berhasil!";
      } else {
        return "Kredensial Salah!";
      }
    } catch (e) {
      return "Terjadi Kesalahan Jaringan!";
    }
  }
}