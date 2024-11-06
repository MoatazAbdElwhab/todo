import 'package:flutter/material.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/widgets/default_elevated_button.dart';
import 'package:todo/widgets/default_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextFormField(
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Name can not be less than 5 characters';
                  } else {
                    return null;
                  }
                },
                controller: nameController,
              ),
              const SizedBox(height: 16),
              DefaultTextFormField(
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return 'Email can not be less than 5 characters';
                  } else {
                    return null;
                  }
                },
                controller: emailController,
              ),
              const SizedBox(height: 16),
              DefaultTextFormField(
                hintText: 'Password',
                isPass: true,
                validator: (value) {
                  if (value == null || value.trim().length < 8) {
                    return 'Password can not be less than 8 characters';
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
              ),
              const SizedBox(height: 32),
              DefaultElevatedButton(
                height: 56,
                width: MediaQuery.of(context).size.width,
                label: 'Register',
                onPressed: () {
                  register();
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: const Text("Don't have an account"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {}
  }
}
