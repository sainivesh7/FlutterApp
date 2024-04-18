import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
/*
    Future<void> sendPasswordResetEmail() async {
      final String email = emailController.text;

      // Add your backend API endpoint URL for sending password reset emails
      final String resetPasswordUrl = 'YOUR_RESET_PASSWORD_API_ENDPOINT';

      try {
        final http.Response response = await http.post(
          Uri.parse(resetPasswordUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': email}),
        );

        if (response.statusCode == 200) {
          // Password reset email sent successfully
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset email sent to $email'),
            ),
          );
        } else {
          // Handle error response
          final Map<String, dynamic> responseData = json.decode(response.body);
          final String errorMessage = responseData['message']; // Adjust based on your API response structure

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $errorMessage'),
            ),
          );
        }
      } catch (e) {
        // Handle network or server errors
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred. Please try again later.'),
          ),
        );
      }
    }*/

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email address',
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {}, // Assign onTap function to GestureDetector onTap
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Send Email",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              /*ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: sendPasswordResetEmail,
              child: Text('Send Reset Email'),
            ),*/
            ),
          ],
        ),
      ),
    );
  }
}
