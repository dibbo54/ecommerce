import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../state_managers/user_auth_controller.dart';
import '../utils/styles.dart';
import '../widgets/common_elevated_button.dart';
import '../widgets/common_text_field.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailETController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserAuthController>(builder: (authController) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Welcome Back',
                  style: titleTextStyle,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Please Enter Your Email Address',
                  style: subTitleTextStyle,
                ),
                const SizedBox(
                  height: 24,
                ),
                CommonTextField(
                  controller: _emailETController,
                  hintText: 'Email Address',
                  textInputType: TextInputType.emailAddress,
                  validator: (String? value) {
                    const String emailRegex =
                        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
                    final RegExp regex = RegExp(emailRegex);
                    if ((value?.isEmpty ?? true) || !(regex.hasMatch(value!))) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                authController.emailVerificationInProgress
                    ? const CircularProgressIndicator()
                    : CommonElevatedButton(
                        title: 'Next',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final bool response = await authController
                                .emailVerification(_emailETController.text);
                            if (response) {
                              Get.to(OTPVerificationScreen(
                                email: _emailETController.text,
                              ));
                            } else {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Email verification failed. Try again',
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
