import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socproject/pages/update_profile.dart'; // Assuming you have an UpdateProfilePage

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _userName;
  late String _phoneNumber;
  late String _address;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Team2';
      _phoneNumber = prefs.getString('phoneNumber') ?? '+1234567890';
      _address = prefs.getString('address') ?? 'Pedatadepalli, India';
    });
  }

  void _updateProfile(Map<String, String> profileData) {
    setState(() {
      _userName = profileData['name'] ?? _userName;
      _phoneNumber = profileData['phoneNumber'] ?? _phoneNumber;
      _address = profileData['address'] ?? _address;
    });

    _saveProfileData(_userName, _phoneNumber, _address);
  }

  void _saveProfileData(String userName, String phoneNumber, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
    prefs.setString('phoneNumber', phoneNumber);
    prefs.setString('address', address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateProfile(onUpdate: _updateProfile)),
              ).then((_) {
                // Reload profile data after editing
                _loadProfileData();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 70.0,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              '$_userName',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                '$_phoneNumber',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                '$_address',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('userId'); // Assuming you have a userId stored in SharedPreferences
                Navigator.popUntil(context, ModalRoute.withName('/')); // Navigate back to the login page
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}