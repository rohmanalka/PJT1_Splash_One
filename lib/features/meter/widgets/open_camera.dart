import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class OpenCamera extends StatefulWidget {
  const OpenCamera({super.key});

  @override
  State<OpenCamera> createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  CameraController? _controller;
  bool _ready = false;
  bool _isTakingPicture = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup:
            ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();

      if (!mounted) return;
      setState(() => _ready = true);
    } catch (e) {
      debugPrint("Error init camera: $e");
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isTakingPicture) {
      return;
    }

    setState(() {
      _isTakingPicture = true;
    });

    try {
      final file = await _controller!.takePicture();

      if (mounted) {
        await _controller!.pausePreview();
      }

      if (!mounted) return;

      Navigator.pop(context, file.path);
    } catch (e) {
      debugPrint("Error taking picture: $e");
      if (mounted) {
        setState(() {
          _isTakingPicture = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready || _controller == null) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: CameraPreview(_controller!),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            color: Colors.black,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isTakingPicture
                  ? null
                  : _takePicture,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.white,
              ),
              child: _isTakingPicture
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.camera_alt, size: 32, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
