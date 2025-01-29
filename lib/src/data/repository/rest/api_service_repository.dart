import 'dart:io';

import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/data/adapters/repository_adapter.dart';
import 'package:crowfunding_app_with_bloc/src/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/src/data/provider/rest/rest.dart';
import 'package:crowfunding_app_with_bloc/src/models/events/events.model.dart';
import 'package:crowfunding_app_with_bloc/src/models/upload_image.model.dart';
import 'package:dio/dio.dart';

class ApiServiceRepository implements IApiServiceRepository {
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

  Future<String?> registerQueue() async {
    try {
      final response = await _restAPIClient.post(
        endpoint: ConfigApi.REGISTER_QUEUE,
      );
      if (response != null) {
        if (response['success']) {
          return response['queue_id'];
        }
        throw ApiException();
      }
    } catch (e) {
      print(e);
      throw ApiException();
    }
    return null;
  }

  Future<Events?> getEvents({
    required String queueId,
    required int lastEventId,
  }) async {
    try {
      final response = await _restAPIClient.get(
        endpoint: ConfigApi.GET_EVENTS,
        queryParams: {
          "queue_id": queueId,
          "last_event_id": lastEventId,
        },
      );
      if (response != null) {
        if (response['success']) {
          return Events.fromJson(response);
        }
        throw ApiException();
      }
    } catch (e) {
      print(e);
      throw ApiException();
    }
    return null;
  }
}
