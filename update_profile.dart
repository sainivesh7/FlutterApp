import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatelessWidget {
  final Function(Map<String, String>) onUpdate;

  UpdateProfile({required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return EditProfile(onUpdate: onUpdate);
  }
}

class EditProfile extends StatefulWidget {
  final Function(Map<String, String>) onUpdate;

  EditProfile({required this.onUpdate});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: getImage,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : AssetImage("assets/profile_picture.jpg") as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Address",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      widget.onUpdate({
                        'name': nameController.text,
                        'phoneNumber': phoneNumberController.text,
                        'address': addressController.text,
                      });

                      Navigator.pop(context); // Navigate back to the previous screen
                    },
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
