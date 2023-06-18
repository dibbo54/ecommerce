import 'package:ecommerce/ui/screens/profile_screen.dart';
import 'package:ecommerce/ui/state_managers/updateprofile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';

import '../utils/app_colors.dart';
import '../widgets/common_text_field.dart';
import 'home_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
        title: const Text('Update Your Profile'),
        leading: IconButton(
          onPressed: () {
            //Get.find<BottomNavigationBarController>().backToHome();
            //Get.offAll(()=>const HomeScreen());
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: greyColor,
          ),
        ),
      ),
      body: GetBuilder<UpdateProfileController>(
        //stream: null,
        builder: (updateProfileController) {
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
                        'Update Profile',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Update your personal information here',
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
                          final RegExp _regex = RegExp(
                              r'^\+?(?:\d{1,3})?[-.●]?(\d{2})[-.●]?(\d{4})[-.●]?(\d{4})$');

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
                      updateProfileController.updateProfileProgress
                          ? const Center(child: CircularProgressIndicator())
                          :
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //CompleteProfileToApi();
                              Get.find<UpdateProfileController>()
                                  .updateProfile(
                                      FirstnameController.text,
                                      LastnameController.text,
                                      MobileController.text,
                                      CityController.text,
                                      ShippingAddressController.text)
                                  .then(
                                (value) {
                                  if (value) {
                                    FirstnameController.clear();
                                    LastnameController.clear();
                                    MobileController.clear();
                                    CityController.clear();
                                    ShippingAddressController.clear();

                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        title: 'Success!',
                                        message: 'Update profile Successful.',
                                        duration: Duration(seconds: 2),
                                      ),
                                    );

                                    Get.off(
                                      () => const ProfileScreen(),
                                      //duration: const Duration(seconds: 2)
                                    );
                                  } else {
                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        title: 'Failed',
                                        message:
                                            'You have to select all fields.. Try again',
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
                          child: const Text('Submit'),
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
