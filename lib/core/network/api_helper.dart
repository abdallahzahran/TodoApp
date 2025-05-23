import 'package:dio/dio.dart';
import 'package:todoapp/features/auth/views/login_screen.dart';
import '../cache/cache_data.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_keys.dart';
import '../helper/my_navigator.dart';
import 'api_response.dart';
import 'end_points.dart';


class ApiHelper
{
  // singleton
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() {
    _instance.initDio();
    return _instance;
  }

  ApiHelper._init();
  Dio dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      )
  );
  void initDio() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          print("--- Headers : ${options.headers.toString()}");
          print("--- endpoint : ${options.path.toString()}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("--- Response : ${response.data.toString()}");
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          print("--- Error : ${error.response?.data.toString()}");
          if (error.response?.data['message']?.toString().contains('expired') ?? false) {
            try {
              ApiResponse apiResponse = await _instance.postRequest(
                  endPoint: EndPoints.refreshToken,
                  sendRefreshToken: true,
                  isProtected: true
              );
              if (apiResponse.status) {
                CacheData.accessToken = apiResponse.data['access_token'];
                await CacheHelper.saveData(key: CacheKeys.accessToken, value: CacheData.accessToken);

                final options = error.requestOptions;
                options.headers['Authorization'] = 'Bearer ${CacheData.accessToken}';
                final response = await dio.fetch(options);
                return handler.resolve(response);
              } else {
                CacheHelper.removeData(key: CacheKeys.accessToken);
                CacheHelper.removeData(key: CacheKeys.refreshToken);
                MyNavigator.goTo(screen: ()=>LoginScreen(), isReplace: true);
                return handler.next(error);
              }
            } catch (e) {
              CacheHelper.removeData(key: CacheKeys.accessToken);
              CacheHelper.removeData(key: CacheKeys.refreshToken);
              MyNavigator.goTo(screen: ()=>LoginScreen(), isReplace: true);
              return handler.next(error);
            }
          }
          return handler.next(error);
        }
    ));

  }
  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
    bool sendRefreshToken = false
  }) async
  {
    return ApiResponse.fromResponse(await dio.post(
        endPoint,
        data: isFormData? FormData.fromMap(data??{}): data,
        options: Options(
            headers:
            {
              if(isProtected) 'Authorization': 'Bearer ${sendRefreshToken? CacheHelper.getData(key: CacheKeys.refreshToken): CacheHelper.getData(key: CacheKeys.accessToken)}',
            }
        )
    ));
  }
  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false
  }) async
  {
    return ApiResponse.fromResponse(await dio.get(
        endPoint,
        data: isFormData? FormData.fromMap(data??{}): data,
        options: Options(
            headers:
            {
              if(isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
            }
        )
    ));
  }

  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    return ApiResponse.fromResponse(await dio.put(
      endPoint,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if (isProtected)
            'Authorization':
                'Bearer ${CacheHelper.getData(key: CacheKeys.accessToken) ?? CacheData.accessToken}',
        },
      ),
    ));
  }

  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    return ApiResponse.fromResponse(await dio.delete(
      endPoint,
      data: isFormData ? FormData.fromMap(data ?? {}) : data,
      options: Options(
        headers: {
          if (isProtected)
            'Authorization':
                'Bearer ${CacheHelper.getData(key: CacheKeys.accessToken) ?? CacheData.accessToken}',
        },
      ),
    ));
  }
}
