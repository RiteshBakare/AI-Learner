import 'package:ai_learner_teacher/pages/home_page.dart';
import 'package:ai_learner_teacher/pages/login_page.dart';
import 'package:ai_learner_teacher/services/AuthServices.dart';
import 'package:ai_learner_teacher/utils/app_colors.dart';
import 'package:ai_learner_teacher/utils/images_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _prnController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;

  bool isLoading = false;

  final AuthService _authService = AuthService();

  void registerUser() async {
    if (_emailController.text.toString().isEmpty) {
      showToast(context, "Please Enter Mail");
    } else if (_passwordController.text.toString().isEmpty) {
      showToast(context, "Please Enter Password");
    } else if (_nameController.text.toString().isEmpty) {
      showToast(context, "Please Enter Name");
    } else if (_prnController.text.toString().isEmpty) {
      showToast(context, "Please Enter PRN");
    } else if (_confirmPasswordController.text.toString().isEmpty) {
      showToast(context, "Please Enter Password");
    } else if (_confirmPasswordController.text.toString() !=
        _passwordController.text.toString()) {
      showToast(context, "Password Does not match");
    } else {
      String result = await _authService.createUserWithMailPassword(
          _emailController.text.toString(),
          _passwordController.text.toString(),
          _nameController.text.toString(),
          _prnController.text.toString());
      if (result == "success") {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showToast(context, "some thing went wrong $result ");
        setState(() {
          isLoading = false;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPurpleColor,
      body: Center(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: lightPurpleColor,
              ),
              child: Center(
                child: Lottie.asset(registerAnimation),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(35),
                  topEnd: Radius.circular(35),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Register Text
                  const Text(
                    'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Registration Form
                  _buildTextField(
                      _nameController, 'Enter your Name', TextInputType.text),
                  const SizedBox(height: 10.0),
                  _buildTextField(_emailController, 'Enter your Email',
                      TextInputType.emailAddress),
                  const SizedBox(height: 10.0),
                  _buildTextField(
                      _prnController, 'Enter your PRN', TextInputType.number),
                  const SizedBox(height: 10.0),
                  _buildPasswordTextField(
                      _passwordController, 'Enter your Password'),
                  const SizedBox(height: 10.0),
                  _buildPasswordTextField(
                      _confirmPasswordController, 'Confirm Password'),
                  const SizedBox(height: 10.0),
                  // Register Button
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      registerUser();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: lightPurpleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: const Size(double.infinity, 50.0),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 1.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Already have an Account?',
                        style: TextStyle(color: Colors.grey, fontSize: 19),
                      ),
                      const SizedBox(width: 1.0),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.blue, fontSize: 19),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, TextInputType inputType) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.blueGrey.shade300,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
        ),
        keyboardType: inputType,
      ),
    );
  }

  Widget _buildPasswordTextField(
      TextEditingController controller, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.blueGrey.shade300,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: _obscurePassword
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        obscureText: _obscurePassword,
      ),
    );
  }
}
