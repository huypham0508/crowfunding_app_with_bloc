import 'dart:io';
import 'package:crowfunding_app_with_bloc/src/models/upload_image.model.dart';

abstract class IApiServiceRepository {
  Future<UploadFileResponse> uploadImage({required File image});
}
