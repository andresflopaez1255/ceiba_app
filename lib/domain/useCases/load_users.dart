import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/domain/repositories/local_repositories/local_user_repository.dart';
import 'package:prueba_ceiba/domain/repositories/network_repositories.dart/user_repository.dart';

class LoadUsersUseCaseRepository {
  final LocalUserRepository localUserRepository;
  final NetWorkUserRepository networkUserRepository;

  LoadUsersUseCaseRepository(
      {required this.localUserRepository, required this.networkUserRepository});

  Future<List<User>> getUsers() async {
    final localUsers = await localUserRepository.getUsers();
    if (localUsers.isEmpty) {
      final networkUsers = await networkUserRepository.fetchUsers();
      await localUserRepository.saveUsers(networkUsers);
      return networkUsers;
    } else {
      return localUsers;
    }
  }
}
