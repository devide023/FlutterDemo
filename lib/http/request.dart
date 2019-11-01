import 'package:dio/dio.dart';
import 'package:flutterproject/config/config.dart';

class request {
  String loadingText;
  bool outsideDismiss;
  Function dismissCallback;
  Future requestCallBack;
  Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.str_apiurl,
    sendTimeout: 1000 * 60,
    receiveTimeout: 5000 * 60,
    contentType: Headers.formUrlEncodedContentType,
  ));

  Dio get instance {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print('dio onrequest:${options.toString()}');
      return options;
    }, onResponse: (Response response) async {
      return response;
    }, onError: (DioError e) async {
      print("DioError:${e.message}");
      return e;
    }));
    return _dio;
  }
}
