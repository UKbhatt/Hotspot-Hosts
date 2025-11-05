import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AudioRecorderWidget extends StatefulWidget {
  final Function(String path) onRecorded;
  const AudioRecorderWidget({super.key, required this.onRecorded});

  @override
  State<AudioRecorderWidget> createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  final _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _path;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    _path = '${dir.path}/recorded_audio.aac';
    await _recorder.startRecorder(toFile: _path);
    setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() => _isRecording = false);
    widget.onRecorded(_path!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(_isRecording ? Icons.stop : Icons.mic),
          onPressed: _isRecording ? _stopRecording : _startRecording,
          iconSize: 48,
          color: _isRecording ? Colors.red : Colors.blue,
        ),
        if (_isRecording)
          const Text('Recording...', style: TextStyle(color: Colors.red)),
      ],
    );
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }
}
