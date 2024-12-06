import 'package:flutter/material.dart';
import 'how_to_use_page.dart';  // Import the new HowToUsePage file

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // White color for back arrow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile picture section
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://www.w3schools.com/w3images/avatar2.png'),
                ),
              ),
              const SizedBox(height: 20),
              // Name and email section
              const Column(
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Profile options section
              ListTile(
                leading: const Icon(Icons.account_circle, color: Colors.blue),
                title: const Text('Personal Information'),
                onTap: () {
                  // Handle navigation to personal info page
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue),
                title: const Text('Notifications'),
                onTap: () {
                  // Handle navigation to notifications settings page
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock, color: Colors.blue),
                title: const Text('Privacy Settings'),
                onTap: () {
                  // Handle navigation to privacy settings page
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.blue),  // Added icon for help
                title: const Text('How to Use'),
                onTap: () {
                  // Navigate to the HowToUsePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HowToUsePage()),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.blue),
                title: const Text('Log Out'),
                onTap: () {
                  // Handle logout functionality
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
