
import 'package:prueba_ceiba/data/source_data/network_source.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';


class NetWorkUserRepository {
  final String endpoint = '/users';
  final NetworkSource networkSource;

  NetWorkUserRepository({required this.networkSource});

  Future<List<User>> fetchUsers() async {
    final response  = await networkSource.getRequest(endpoint);

    if (response.statusCode == 200) {
      
      List<dynamic> data = response.data;
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}