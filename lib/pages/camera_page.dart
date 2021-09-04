import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palettex/cubit/xpalette_cubit.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<XpaletteCubit, XpaletteState>(
      builder: (context, state) {
        if (state is XpaletteCameraActiveState) {
          return WillPopScope(
              onWillPop: () async {
                BlocProvider.of<XpaletteCubit>(context).cameraInit = false;
                BlocProvider.of<XpaletteCubit>(context)
                    .emit(XpaletteLibraryLoadedState());
                return true;
              },
              child: CameraPageStful(camera: state.cameras));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class CameraPageStful extends StatefulWidget {
  const CameraPageStful({
    required this.camera,
    Key? key,
  }) : super(key: key);

  final List<CameraDescription> camera;

  @override
  CameraPageStfulState createState() => CameraPageStfulState();
}

class CameraPageStfulState extends State<CameraPageStful> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  int cameraIndex = 0;

  @override
  void initState(){
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async{
    if (BlocProvider.of<XpaletteCubit>(context).cameraInit == false) {
      BlocProvider.of<XpaletteCubit>(context).cameraInit = true;

      _controller = CameraController(
        widget.camera[cameraIndex],
        ResolutionPreset.veryHigh,
      );

      _initializeControllerFuture = _controller!.initialize();
    }
  }

  void onNewCameraSelected() async {
    // если камер меньше двух, то сменить камеру нельзя
    if (widget.camera.length < 2){
      return;
    }

    // если уже выбрали последнюю камеру в списке
    if (cameraIndex + 1 >= widget.camera.length){
      cameraIndex = 0;
    } else {
      cameraIndex++;
    }

    _initializeControllerFuture = null;

    _controller = CameraController(
      widget.camera[cameraIndex],
      ResolutionPreset.veryHigh,
    );

// If the controller is updated then update the UI.
    _controller!.addListener(() {
      if (mounted) setState(() {});
      if (_controller!.value.hasError) {
        print('Camera error ${_controller!.value.errorDescription}');
      }
    });

    try {
      _initializeControllerFuture = _controller!.initialize();
      await _controller!.lockCaptureOrientation();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    if(_controller != null){
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //initCamera();
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          double aspectRatio;

          try {
            aspectRatio = _controller!.value.aspectRatio;
          } catch (e){
            print('failed to get ratio');
            aspectRatio = 1;
          }
          // If the Future is complete, display the preview.
          return SafeArea(
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Stack(
                  children: [
                    CameraPreview(_controller!),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                side: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                padding: EdgeInsets.all(24),
                              ),
                              onPressed: () async {
                                try {
                                  await _initializeControllerFuture;
                                  final image = await _controller!.takePicture();
                                  BlocProvider.of<XpaletteCubit>(context).cameraInit = false;
                                  BlocProvider.of<XpaletteCubit>(context)
                                      .processImageFromCustomCamera(image);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Icon(Icons.camera, color: Colors.grey,)),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                side: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1,
                                ),
                                padding: EdgeInsets.all(24),
                              ),
                              onPressed: () async {
                                onNewCameraSelected();
                              },
                              child: Icon(Icons.replay, color: Colors.grey,)),
                        ),
                      ),
                    )

                ],
              ),
            ),
          );
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
