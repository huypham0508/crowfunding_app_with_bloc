import 'dart:io';

import 'package:camera/camera.dart';
import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/global/blocs/camera/camera_bloc.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });
  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraBloc cameraBloc;

  @override
  void initState() {
    super.initState();
    cameraBloc = context.read<CameraBloc>()
      ..add(
        InitialCameraEvent(
          cameraController: CameraController(
            widget.camera,
            ResolutionPreset.ultraHigh,
            enableAudio: false,
            imageFormatGroup: ImageFormatGroup.jpeg,
          ),
        ),
      );
  }

  @override
  void dispose() {
    cameraBloc.add(DisposeCameraEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        _handleTakePicture() {
          cameraBloc.add(TakePictureCameraEvent());
        }

        bool showPicAndUpload() {
          if (state.status == CameraStatus.showPicture) {
            return true;
          }
          if (state.uploadStatus == UploadStatus.uploading) {
            return true;
          }
          return false;
        }

        return Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: FutureBuilder<void>(
                  future: state.initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: CameraPreview(state.cameraController!),
                            ),
                          )
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: GestureDetector(
                  child: Center(
                    child: FloatingActionButton(
                      backgroundColor: AppColors.whitish100,
                      onPressed: _handleTakePicture,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ),
              if (showPicAndUpload())
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.black100,
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: FileImage(File(state.imageFile.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _closeButton(() {
                              cameraBloc.add(CloseShowPicCameraEvent());
                            }),
                            _uploadButton(() {
                              cameraBloc.add(
                                UploadCameraEvent(
                                  description: 'test',
                                ),
                              );
                            }),
                          ],
                        ),
                        GlobalStyles.sizedBoxHeight_30
                      ],
                    ),
                  )
                      .animate(
                        autoPlay: false,
                        target: state.playUpload ? 1 : 0,
                      )
                      .move(
                        duration: 1.seconds,
                        curve: Curves.easeInBack,
                        begin: Offset(0, 0),
                        end: Offset(-size.width / 0.7, -size.height * 1.5),
                      )
                      .scale(
                        curve: Curves.ease,
                        end: Offset(0.20, 0.20),
                      ),
                )
            ],
          ),
        );
      },
    );
  }

  ElevatedButton _uploadButton(onPressed) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.black100,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        'Upload',
        style: TextStyle(color: AppColors.whitish100),
      ),
    );
  }

  ElevatedButton _closeButton(onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        'Close',
        style: TextStyle(color: AppColors.black100),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
