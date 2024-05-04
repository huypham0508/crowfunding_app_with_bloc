part of 'camera_bloc.dart';

CameraState authInitialState = CameraState(
  imageFile: XFile(''),
  status: CameraStatus.showCamera,
  uploadStatus: UploadStatus.failed,
  playUpload: false,
);

enum CameraStatus { showPicture, showCamera }

enum UploadStatus { uploading, successfully, failed }

class CameraState {
  final CameraController? cameraController;
  final Future<void>? initializeControllerFuture;
  final XFile imageFile;
  final CameraStatus status;
  final UploadStatus uploadStatus;
  final bool playUpload;

  CameraState({
    this.cameraController,
    this.initializeControllerFuture,
    required this.imageFile,
    required this.status,
    required this.uploadStatus,
    required this.playUpload,
  });

  CameraState copyWith({
    CameraController? cameraController,
    Future<void>? initializeControllerFuture,
    XFile? imageFile,
    CameraStatus? status,
    UploadStatus? uploadStatus,
    bool? playUpload,
  }) {
    return CameraState(
      playUpload: playUpload ?? this.playUpload,
      status: status ?? this.status,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      imageFile: imageFile ?? this.imageFile,
      cameraController: cameraController ?? this.cameraController,
      initializeControllerFuture:
          initializeControllerFuture ?? this.initializeControllerFuture,
    );
  }
}
