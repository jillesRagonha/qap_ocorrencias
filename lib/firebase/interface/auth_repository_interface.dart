import '../responses/response_default.dart';

abstract class IAuthRepository {
  Future<ResponseDefault> doLoginGoogle();

  Future<ResponseDefault> doLoginEmailPassword(String email, String senha);

  Future<ResponseDefault> registerEmailPassword(
      {String email, String senha});

  Future<ResponseDefault> getUser();

  Future<ResponseDefault> logout();
}
