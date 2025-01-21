import 'package:crowfunding_app_with_bloc/app/constants/app_string.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/provider_wrapper.dart';
import 'package:dio/dio.dart';

import '../../exceptions.dart';

const baseUrl = ConfigApi.API_VER1;

class RestAPIClient extends ProviderWrapper {
  final Dio httpClient;
  final Map<String, dynamic> _defaultBody = {};
  final LocalDataSource localDataSource;
  static RestAPIClient? _instance;

  RestAPIClient._({
    required this.httpClient,
    required this.localDataSource,
  }) : super(localDataSource: localDataSource);

  static RestAPIClient getInstance({
    required Dio httpClient,
    required LocalDataSource localDataSource,
  }) {
    _instance ??= RestAPIClient._(
      httpClient: httpClient,
      localDataSource: localDataSource,
    );
    return _instance!;
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    return await super.executeWithRetry<Map<String, dynamic>?>(() async {
      try {
        String? token = await localDataSource.getToken();
        httpClient.options.headers["Authorization"] = "Bearer $token";
        final response = await httpClient.get(
          baseUrl + endpoint,
          queryParameters: queryParams,
          options: Options(
            contentType: Headers.jsonContentType,
          ),
        );
        return response.data;
      } catch (exception) {
        return null;
      }
    });
  }

  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic> postData = const {},
  }) async {
    return await super.executeWithRetry<dynamic>(() async {
      try {
        String? token = await localDataSource.getToken();
        httpClient.options.headers["Authorization"] = "Bearer $token";
        Map<String, dynamic> submit = Map<String, dynamic>();
        submit.addAll(_defaultBody);
        submit.addAll(postData);
        final response = await httpClient.post(
          baseUrl + endpoint,
          data: submit,
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
        return response.data;
      } catch (exception) {
        return null;
      }
    });
  }

  postFile(Map<String, dynamic> postData) async {
    try {
      final FormData formData = FormData.fromMap(postData);
      var response = await httpClient.post('$baseUrl/upload', data: formData);
      return response.data;
    } catch (exception) {
      print(exception);
      throw ApiException();
    }
  }

  postFileList(Map<String, dynamic> postData) async {
    try {
      Map<String, dynamic> submit = Map<String, dynamic>();
      submit.addAll(_defaultBody);
      submit.addAll(postData);

      final FormData formData = FormData.fromMap(submit);
      var response = await httpClient.post(
        baseUrl,
        data: formData,
      );
      return response.data;
    } catch (exception) {
      print(exception);
      throw ApiException();
    }
  }
}
