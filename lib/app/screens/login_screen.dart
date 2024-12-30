import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task_bloc_project/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_task_bloc_project/app/bloc/auth_bloc/auth_event.dart';
import 'package:social_media_task_bloc_project/app/bloc/auth_bloc/auth_state.dart';
import 'package:social_media_task_bloc_project/app/common/app_colors.dart';
import 'package:social_media_task_bloc_project/app/custom_widgets/custom_label.dart';
import 'package:social_media_task_bloc_project/app/custom_widgets/custom_snackbar.dart';
import 'package:social_media_task_bloc_project/app/custom_widgets/custom_text_fields.dart';
import 'package:social_media_task_bloc_project/app/screens/sign_up_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => HomeScreen(
                        userId: emailController.text,
                      )),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Login to your account",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.darkgrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  const CustomLable(lable: "Email"),
                  UniversalTextField(
                    controller: emailController,
                    hintText: "Enter valid Email ID",
                  ),
                  const SizedBox(height: 10),
                  const CustomLable(lable: "Password"),
                  PasswordTextField(
                    controller: passwordController,
                    hintText: "Enter valid Password",
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () {
                      if (emailController.text.isEmpty) {
                        customSnackbar(context, "Please enter valid Email ID");
                      } else if (passwordController.text.isEmpty) {
                        customSnackbar(context, "Please enter valid Passwor");
                      } else {
                        BlocProvider.of<AuthBloc>(context).add(
                          SignInEvent(
                              emailController.text, passwordController.text),
                        );
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: AppColors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      emailController.clear();
                      passwordController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
