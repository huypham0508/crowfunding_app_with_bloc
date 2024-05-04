import 'dart:io';

import 'package:crowfunding_app_with_bloc/app/data/adapters/repository_adapter.dart';
import 'package:crowfunding_app_with_bloc/app/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/rest/rest.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/upload_image_response.dart';
import 'package:dio/dio.dart';

class ApiServiceRepository implements IApiDeviceRepository {
  final RestAPIClient _restAPIClient;

  ApiServiceRepository(this._restAPIClient);

  Future<UploadFileResponse> uploadImage({required File image}) async {
    String fileName = image.path.split('/').last;

    final multipartFile = await MultipartFile.fromFile(
      image.path,
      filename: fileName,
    );

    Map<String, dynamic> payload = {'file': multipartFile};

    try {
      final response = await _restAPIClient.postFile(payload);
      if (response != null) {
        if (response['success']) {
          return UploadFileResponse.fromJson(response);
        }
        throw ApiException();
      }
      throw ApiException();
    } catch (e) {
      throw ApiException();
    }
  }
}
