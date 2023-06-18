import 'dart:convert';

import 'package:ecommerce/ui/screens/profile_screen.dart';
import 'package:ecommerce/ui/widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../state_managers/auth_controller.dart';
import '../state_managers/create_profile_controller.dart';
import '../utils/app_colors.dart';
import 'home_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  //final Client httpClient = Client();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController FirstnameController = TextEditingController();
  final TextEditingController LastnameController = TextEditingController();
  final TextEditingController MobileController = TextEditingController();
  final TextEditingController CityController = TextEditingController();
  final TextEditingController ShippingAddressController =
      TextEditingController();

  @override
  void dispose() {
    FirstnameController.dispose();
    FirstnameController.dispose();
    MobileController.dispose();
    CityController.dispose();
    ShippingAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        leading: IconButton(
          onPressed: () {
            //Get.find<BottomNavigationBarController>().backToHome();
            Get.offAll(() => const HomeScreen());
            //Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: greyColor,
          ),
        ),
      ),

      body: GetBuilder<CreateProfileController>(
        //stream: null,
        builder: (createProfileController) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 46,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 120,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Completed Profile',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Get started with us with your details',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFa6a6a6),
                            letterSpacing: 0.5),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CommonTextField(
                        controller: FirstnameController,
                        hintText: 'First name',
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your First Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CommonTextField(
                        controller: LastnameController,
                        hintText: 'Last name',
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your Last Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CommonTextField(
                        controller: MobileController,
                        hintText: 'Mobile',
                        validator: (String? value) {
                          final RegExp _regex = RegExp(r'^\+?(?:\d{1,3})?[-.●]?(\d{2})[-.●]?(\d{4})[-.●]?(\d{4})$');

                          if (value == null || value.isEmpty) {
                            return 'Mobile number is required';
                          }

                          if (!_regex.hasMatch(value)) {
                            return 'Invalid mobile number';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CommonTextField(
                          controller: CityController,
                          hintText: 'City',
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your city';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      CommonTextField(
                          maxLines: 4,
                          controller: ShippingAddressController,
                          hintText: 'Shipping Address',
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Shipping Address';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      createProfileController.createProfileProgress
                          ? const Center(child: CircularProgressIndicator())
                          :
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //CompleteProfileToApi();
                              Get.find<CreateProfileController>()
                                  .createProfile(
                                      FirstnameController.text,
                                      LastnameController.text,
                                      MobileController.text,
                                      CityController.text,
                                      ShippingAddressController.text)
                                  .then(
                                (value) {
                                  if (value) {
                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        title: 'Success!',
                                        message: 'Create profile Successful.',
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    FirstnameController.clear();
                                    LastnameController.clear();
                                    MobileController.clear();
                                    CityController.clear();
                                    ShippingAddressController.clear();

                                    //Get.off(const HomeScreen());
                                  } else {
                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        title: 'Failed',
                                        message: 'You have to select all fields',
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                              );
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const ProfileScreen()));
                          },
                          child: const Text('Complete'),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
