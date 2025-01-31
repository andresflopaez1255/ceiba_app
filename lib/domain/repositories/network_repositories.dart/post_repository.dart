
import 'package:prueba_ceiba/data/source_data/network_source.dart';
import 'package:prueba_ceiba/domain/entities/post.dart';


class PostRepository {
  final String endpoint = '/posts';
  final NetworkSource networkSource;

  PostRepository({required this.networkSource});
  Future<List<Post>> fetchPost( int id ) async {
    final response  = await networkSource.getRequest(endpoint, queryParameters: {
      'userId': id
    } );

    if (response.statusCode == 200) {
      
      List<dynamic> data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}