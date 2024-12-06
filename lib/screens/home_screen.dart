import 'package:flutter/material.dart';
import 'camera_page.dart'; // Camera page file
import 'profile_page.dart'; // Profile page file
import 'image_page.dart';   // Image page file for image detection
import 'trash_detection_page.dart'; // Trash detection page file
import 'live_bottle_detection.dart'; // Live Bottle Detection page file

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track selected bottom navigation index

  final List<Widget> _pages = [
    // Pages for each navigation item
    const Center(child: Text("Home Screen")), // Home screen content
    CameraPage(), // Camera page content
    const ProfilePage(), // Profile page content
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
        title: Text(_titles[_currentIndex], style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: _currentIndex == 0
          ? ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.video_call, color: Colors.blue), // Video icon
            title: const Text('Real-time Video Detection', style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16), // ">" symbol
            onTap: () {
              // Redirect to the real-time detection page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LiveBottleDetectionPage()), // Navigate to RealTimeDetectionPage
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.image, color: Colors.blue), // Image icon
            title: const Text('Image Detection', style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16), // ">" symbol
            onTap: () {
              // Redirect to Image Detection page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ImageScreen()), // Navigate to ImagePage
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.blue), // Trash icon
            title: const Text('Trash Detection', style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16), // ">" symbol
            onTap: () {
              // Redirect to Trash Detection page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TrashDetectionPage()), // Navigate to TrashDetectionPage
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.local_drink, color: Colors.blue), // Bottle icon
            title: const Text('Live Bottle Detection', style: TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16), // ">" symbol
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
        items: const [
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
