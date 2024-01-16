import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String status; // 'Student' or 'Teacher' status
  final String name;
  final String email;
  final VoidCallback onUpdateProfile;

  const MyDrawer({super.key, 
    required this.status,
    required this.name,
    required this.email,
    required this.onUpdateProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
          ),
          ListTile(
            leading: const Icon(Icons.assignment_ind),
            title: Text('Status: $status'),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Update Profile'),
            onTap: onUpdateProfile, // Trigger the profile update action when clicked.
          ),
          // Add more menu items if needed.
        ],
      ),
    );
  }
}
