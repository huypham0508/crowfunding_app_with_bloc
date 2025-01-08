import 'dart:io';
import 'package:crowfunding_app_with_bloc/app/models/response/upload_image_response.dart';

abstract class IApiServiceRepository {
  Future<UploadFileResponse> uploadImage({required File image});
}
