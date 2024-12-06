import 'package:flutter/material.dart';

class HowToUsePage extends StatelessWidget {
  const HowToUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Use'),
        backgroundColor: Colors.blue,
      ),
      body: const SingleChildScrollView(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Setup Instructions for Image Detection and Trash Detection',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '1. Same Network Requirement\n'
                  ' Ensure both your laptop (server) and mobile (client) are connected to the same local WiFi network.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '2. Find Your Laptop\'s IP Address\n'
                  ' Windows: Open Command Prompt and type `ipconfig`, then look for the "IPv4 Address".\n'
                  ' Mac/Linux: Open the terminal and type `ifconfig` or `ip a` to get your local IP address.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '3. Flask Server Setup on Laptop\n'
                  ' Ensure the Flask server is running on your laptop.\n'
                  ' Set Flask to listen on your laptop’s local IP by running the following:\n'
                  '  ```\n'
                  '  app.run(debug=True, host="192.168.x.x", port=5000)\n'
                  '  ```\n'
                  '  Replace `192.168.x.x` with your laptop’s local IP.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '4. Allow Flask on Firewall (Laptop)\n'
                  ' Make sure your firewall allows incoming connections on port 5000.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '5. Correct API URL in Flutter App\n'
                  ' In the Flutter app, make sure you\'re calling the correct IP address of the laptop:\n'
                  '  ```\n'
                  '  var uri = Uri.parse("http://192.168.x.x:5000/detect_image");\n'
                  '  ```',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '6. Test the Connection\n'
                  ' Ping the server: Open a browser on your mobile and try visiting `http://192.168.x.x:5000/`. You should see the Flask app response if connected successfully.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '7. Ensure Devices are on the Same Subnet\n'
                  ' The IP addresses of both devices (laptop and mobile) should be in the same subnet. This ensures they\'re on the same local network.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '8. No Router Isolation\n'
                  ' Check that your router does not have client isolation enabled, which could block devices from communicating with each other.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '9. Mobile App Requirements\n'
                  ' Test the app on a real mobile device (not an emulator) because emulators often have different networking configurations.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '10. Use HTTP for Local Testing\n'
                  ' For local testing, use HTTP (not HTTPS) as Flask does not have SSL certificates for HTTPS unless configured manually.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '11. Handle Large Files (Optional)\n'
                  ' If uploading large files, set the maximum content length in Flask:\n'
                  '  ```\n'
                  '  app.config[\'MAX_CONTENT_LENGTH\'] = 16  1024  1024  # 16MB\n'
                  '  ```',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '12. Flask Server Running\n'
                  ' Keep the Flask server running on your laptop while using the app on your mobile device. The server should stay open in the terminal.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
