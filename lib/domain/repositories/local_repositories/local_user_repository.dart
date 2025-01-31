import 'package:hive/hive.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';

class LocalUserRepository {
  final Box<User> userBox;

  LocalUserRepository({required this.userBox});
  

  Future<void> saveUsers(List<User> users) async {
    await userBox.clear();
    for (var user in users) {
      await userBox.put(user.id, user);
    }
  }

  Future<List<User>> getUsers() async {
    return userBox.values.toList();
  }
}