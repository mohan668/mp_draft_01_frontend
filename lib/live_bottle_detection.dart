import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'package:image/image.dart' as img;

class LiveBottleDetectionPage extends StatefulWidget {
  @override
  _LiveBottleDetectionPageState createState() => _LiveBottleDetectionPageState();
}

class _LiveBottleDetectionPageState extends State<LiveBottleDetectionPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isDetecting = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        throw Exception("No cameras available");
      }

      _controller = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );

      await _controller!.initialize();

      // Start the camera stream
      _controller!.startImageStream((CameraImage image) {
        if (!_isDetecting) {
          _isDetecting = true;
          _processImage(image);
        }
      });

      // Make sure the widget is still in the tree before updating the state
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initializing camera: $e")),
      );
    }
  }

  // Process the image and send to the Python backend
  Future<void> _processImage(CameraImage image) async {
    try {
      // Convert the CameraImage to a format suitable for YOLO
      final img.Image convertedImage = _convertCameraImage(image);

      // Send the image to the Python backend
      final response = await _sendImageToPython(convertedImage);

      // If the response is successful, process bounding boxes
      if (response.statusCode == 200) {
        final detections = jsonDecode(response.body);
        _drawBoundingBoxes(detections);
      }
    } catch (e) {
      print("Error processing image: $e");
    } finally {
      _isDetecting = false;  // Allow the next frame to be processed
    }
  }

  // Convert the CameraImage to an Image object
  img.Image _convertCameraImage(CameraImage image) {
    final planes = image.planes;
    final bytes = planes[0].bytes;
    return img.decodeImage(Uint8List.fromList(bytes))!;
  }

  // Send the image to the Python server for detection
  Future<http.Response> _sendImageToPython(img.Image image) async {
    final url = Uri.parse('http://<YOUR_SERVER_IP>:5000/detect');
    final bytes = Uint8List.fromList(img.encodeJpg(image));  // Convert to JPEG format

    final request = http.MultipartRequest('POST', url)
      ..files.add(http.MultipartFile.fromBytes('image', bytes))
      ..headers['Content-Type'] = 'multipart/form-data';

    return await request.send().then((response) => http.Response.fromStream(response));
  }

  // Draw bounding boxes on the camera preview (or display results)
  void _drawBoundingBoxes(List<dynamic> detections) {
    // You can overlay bounding boxes on the camera feed
    // For now, just print the detection results
    for (var detection in detections) {
      print("Label: ${detection['label']}, Box: ${detection['x1']}, ${detection['y1']}, ${detection['x2']}, ${detection['y2']}");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Live Bottle Detection"),
        backgroundColor: Colors.blue,
      ),
      body: CameraPreview(_controller!), // Show the camera feed
    );
  }
}
