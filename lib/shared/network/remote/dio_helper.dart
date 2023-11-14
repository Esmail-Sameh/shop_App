import 'package:dio/dio.dart';

class DioHelper {
   static var dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
      ),
    );
  }

  // get method
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,

  }) async {

    dio.options.headers = {
    'Content-Type': 'application/json',
    'lang': lang,
    'Authorization': token??'',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  // post method
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

}
