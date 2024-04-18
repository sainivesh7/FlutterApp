import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socproject/components/my_button.dart';
import 'package:socproject/components/my_textfield.dart';
import 'package:socproject/pages/home_page.dart';
import 'package:socproject/pages/register_page.dart';
import 'package:socproject/pages/forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> signIn(BuildContext context) async {
      final String email = usernameController.text;
      final String password = passwordController.text;

      // Make an HTTP POST request to your backend server
      final Uri url = Uri.parse('http://localhost:8080/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Authentication successful, navigate to home page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Authentication failed, show error message
        var errorMessage = 'Invalid email or password.';
        try {
          // Try to decode the response body to get the error message
          final responseData = json.decode(response.body);
          if (responseData['error'] != null) {
            errorMessage = responseData['error'];
          }
        } catch (e) {
          // Error decoding response body, use default error message
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    void navigateToForgotPassword(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "RealEstate App",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                // Logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                SizedBox(height: 50),
                // Welcome back, you have missed!
                Text(
                  'welcome back, you have missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 25),
                // User name
                MyTextField(
                  controller: usernameController,
                  hintText: 'Email id',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                // Password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: 10),

                // Forgot password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => navigateToForgotPassword(context),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                // Sign-in button
                MyButton(
                  onTap: () => signIn(context),
                ),

                SizedBox(height: 25),
                // Not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 4,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}