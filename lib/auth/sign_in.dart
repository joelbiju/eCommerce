import 'package:ecommerce_app/auth/log_in.dart';
import 'package:ecommerce_app/widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController nameController = TextEditingController(); // Controller for the name
  final TextEditingController emailController = TextEditingController(); // Controller for the email
  final TextEditingController passwordController = TextEditingController(); // Controller for the password
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  void dispose() {
    nameController.dispose(); // Dispose of the name controller
    emailController.dispose(); // Dispose of the email controller
    passwordController.dispose(); // Dispose of the password controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FD),
      appBar: AppBar(
        title: const Text(
          'e-Shop',
          style: TextStyle(
            color: Color(0xFF0C54BE),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      CustomTextField(
                        controller: nameController, 
                        hintText: 'Name', 
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name'; 
                          }
                          return null; 
                        },
                      ),
                      SizedBox(height: 10.0),

                      CustomTextField(
                        controller: emailController, 
                        hintText: 'Email', 
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email'; 
                          }
                          const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; // Regular expression for validating email format
                          final regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value)) {
                            return 'Please enter a valid email'; 
                          }
                          return null; 
                        },
                      ),
                      SizedBox(height: 10.0),

                      CustomTextField(
                        controller: passwordController, 
                        hintText: 'Password', 
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password'; 
                          }
                          return null; 
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Submit Button
              CustomButton(
                buttonText: 'Signup', 
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, process the data.
                    print('Name: ${nameController.text}');
                    print('Email: ${emailController.text}');
                    print('Password: ${passwordController.text}');
                  }
                },
              ),
              SizedBox(height: 8.0),

              // Sign In Button
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.black, // Change this to your preferred color
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: Color(0xFF0C54BE),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        // Navigate to the sign in screen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LogIn(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
