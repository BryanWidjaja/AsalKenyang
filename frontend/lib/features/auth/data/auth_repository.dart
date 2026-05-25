import '../../../core/storage/token_storage.dart';
import 'auth_models.dart';
import 'auth_remote_data_source.dart';

class AuthRepository {
  AuthRepository(this._remote, this._tokens);

  final AuthRemoteDataSource _remote;
  final TokenStorage _tokens;

  Future<User> register(String email, String password) async {
    final res = await _remote.register(email, password);
    await _tokens.write(res.token);
    return res.user;
  }

  Future<User> login(String email, String password) async {
    final res = await _remote.login(email, password);
    await _tokens.write(res.token);
    return res.user;
  }

  Future<void> logout() => _tokens.clear();

  Future<bool> hasSession() async {
    final token = await _tokens.read();
    return token != null && token.isNotEmpty;
  }
}
