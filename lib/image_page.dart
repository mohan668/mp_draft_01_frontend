import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _imageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    var uri = Uri.parse('http://192.168.43.44:5000/detect'); // Update with your Flask endpoint
    var request = http.MultipartRequest('POST', uri);

    var file = await http.MultipartFile.fromPath(
      'image',
      _image!.path,
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(file);

    var response = await request.send();

    if (response.statusCode == 200) {
      var bytes = await response.stream.toBytes();
      setState(() {
        _imageUrl = 'data:image/jpeg;base64,${base64Encode(bytes)}';
      });
    } else {
      //print('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detection', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white), // Change the back arrow icon color to white
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
            children: [
              _image == null
                  ? Container(
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.blue),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'No image selected.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
                  : Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.file(
                      _image!,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image, color: Colors.white),
                label: const Text('Pick Image', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _uploadImage,
                icon: const Icon(Icons.upload, color: Colors.white),
                label: const Text('Upload Image', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _imageUrl != null
                  ? Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.memory(
                      base64Decode(_imageUrl!.split(',')[1]),
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
