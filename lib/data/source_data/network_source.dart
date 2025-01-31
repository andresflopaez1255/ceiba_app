import 'package:dio/dio.dart';

class NetworkSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  

  Future<Response> getRequest(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
