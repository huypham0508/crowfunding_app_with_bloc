part of 'camera_bloc.dart';

abstract class CameraEvent {}

class InitialCameraEvent extends CameraEvent {
  final CameraController cameraController;
  InitialCameraEvent({required this.cameraController});
}

class DisposeCameraEvent extends CameraEvent {}

class TakePictureCameraEvent extends CameraEvent {}

class CloseShowPicCameraEvent extends CameraEvent {}

class UploadCameraEvent extends CameraEvent {}
