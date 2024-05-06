import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:crowfunding_app_with_bloc/app/data/repository/graphql/post_repository.dart';
import 'package:crowfunding_app_with_bloc/app/data/repository/rest/api_service_repository.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'camera_events.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  List<CameraDescription> cameras;
  final PostRepository postRepository;
  final ApiServiceRepository apiServiceRepository;

  CameraBloc({
    required this.cameras,
    required this.apiServiceRepository,
    required this.postRepository,
  }) : super(authInitialState) {
    on<InitialCameraEvent>(_initial);
    on<DisposeCameraEvent>(_dispose);
    on<TakePictureCameraEvent>(_takePicture);
    on<CloseShowPicCameraEvent>(_closeShowPic);
    on<UploadCameraEvent>(_upload);
  }

  void _initial(InitialCameraEvent event, Emitter<CameraState> emit) async {
    var _initializeControllerFuture = event.cameraController.initialize();
    emit(
      state.copyWith(
        cameraController: event.cameraController,
        initializeControllerFuture: _initializeControllerFuture,
      ),
    );
  }

  void _takePicture(
    TakePictureCameraEvent event,
    Emitter<CameraState> emit,
  ) async {
    await state.initializeControllerFuture;
    final image = await state.cameraController!.takePicture();

    emit(
      state.copyWith(
        imageFile: image,
        status: CameraStatus.showPicture,
        uploadStatus: UploadStatus.failed,
      ),
    );
  }

  void _closeShowPic(
    CloseShowPicCameraEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(state.copyWith(status: CameraStatus.showCamera, imageFile: null));
  }

  void _upload(UploadCameraEvent event, Emitter<CameraState> emit) async {
    emit(
      state.copyWith(
        uploadStatus: UploadStatus.uploading,
        status: CameraStatus.showCamera,
        playUpload: true,
      ),
    );
    try {
      final response = await apiServiceRepository.uploadImage(
        image: File(state.imageFile.path),
      );
      await Future.delayed(2000.milliseconds);
      if (response.success == true && response.file!.filePath != null) {
        final postResponse = await postRepository.createPost(
          desc: event.description ?? '',
          imageUrl: response.file!.filePath ?? '',
        );
        if (postResponse.success == true) {
          emit(state.copyWith(
            uploadStatus: UploadStatus.successfully,
            playUpload: false,
          ));
          return;
        }
      }
      emit(state.copyWith(
        uploadStatus: UploadStatus.failed,
        playUpload: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        uploadStatus: UploadStatus.failed,
        playUpload: false,
      ));
      print('error uploading $e');
    }
  }

  void _dispose(DisposeCameraEvent event, Emitter<CameraState> emit) async {
    state.cameraController!.dispose();
  }
}
