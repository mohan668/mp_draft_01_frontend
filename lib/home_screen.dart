import 'package:flutter/material.dart';
import 'camera_page.dart'; // Camera page file
import 'profile_page.dart'; // Profile page file
import 'image_page.dart';   // Image page file for image detection
import 'trash_detection_page.dart'; // Trash detection page file
import 'live_bottle_detection.dart'; // Live Bottle Detection page file

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track selected bottom navigation index

  final List<Widget> _pages = [
    // Pages for each navigation item
    Center(child: Text("Home Screen")), // Home screen content
    CameraPage(), // Camera page content
    ProfilePage(), // Profile page content
    LiveBottleDetectionPage(), // Real-time video detection page
    LiveBottleDetectionPage(), // Live bottle detection page
  ];

  final List<String> _titles = [
    "Mini Project", // Title for the Home screen
    "Camera Page",  // Title for the Camera screen
    "Profile Page", // Title for the Profile screen
    "Real-time Detection", // Title for the Real-time detection screen
    "Live Bottle Detection", // Title for the Live Bottle Detection screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex], style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: _currentIndex == 0
          ? ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.video_call, color: Colors.blue), // Video icon
            title: Text('Real-time Video Detection', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16), // ">" symbol
            onTap: () {
              // Redirect to the real-time detection page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LiveBottleDetectionPage()), // Navigate to RealTimeDetectionPage
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.image, color: Colors.blue), // Image icon
            title: Text('Image Detection', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16), // ">" symbol
            onTap: () {
              // Redirect to Image Detection page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImageScreen()), // Navigate to ImagePage
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.blue), // Trash icon
            title: Text('Trash Detection', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16), // ">" symbol
            onTap: () {
              // Redirect to Trash Detection page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrashDetectionPage()), // Navigate to TrashDetectionPage
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_drink, color: Colors.blue), // Bottle icon
            title: Text('Live Bottle Detection', style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16), // ">" symbol
            onTap: () {
              // Redirect to Live Bottle Detection page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LiveBottleDetectionPage()), // Navigate to LiveBottleDetectionPage
              );
            },
          ),
        ],
      )
          : _pages[_currentIndex], // Display selected page for other tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Current selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected tab
          });
        },
        backgroundColor: Colors.white, // Set background color of the bottom nav bar
        selectedItemColor: Colors.blue, // Color of the selected item
        unselectedItemColor: Colors.grey, // Color of the unselected items
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home", // Home button
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "Camera", // Camera button
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile", // Profile button
          ),
        ],
      ),
    );
  }
}
