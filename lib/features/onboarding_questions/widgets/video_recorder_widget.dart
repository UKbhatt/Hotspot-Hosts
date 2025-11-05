import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class VideoRecorderWidget extends StatefulWidget {
  final Function(String path) onRecorded;
  const VideoRecorderWidget({super.key, required this.onRecorded});

  @override
  State<VideoRecorderWidget> createState() => _VideoRecorderWidgetState();
}

class _VideoRecorderWidgetState extends State<VideoRecorderWidget> {
  CameraController? _controller;
  bool _isRecording = false;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras.first, ResolutionPreset.medium);
    await _controller!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _recordVideo() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/video.mp4';
    await _controller!.startVideoRecording();
    setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    final file = await _controller!.stopVideoRecording();
    setState(() => _isRecording = false);
    widget.onRecorded(file.path);
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        SizedBox(height: 250, child: CameraPreview(_controller!)),
        const SizedBox(height: 16),
        IconButton(
          icon: Icon(_isRecording ? Icons.stop : Icons.videocam),
          onPressed: _isRecording ? _stopRecording : _recordVideo,
          color: _isRecording ? Colors.red : Colors.green,
          iconSize: 48,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
