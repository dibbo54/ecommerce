import 'dart:convert';

import 'package:ecommerce/ui/screens/home_screen.dart';
import 'package:ecommerce/ui/screens/show_review_screen.dart';
import 'package:ecommerce/ui/state_managers/create_review_controlller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../state_managers/auth_controller.dart';
import '../state_managers/bottom_navigation_bar_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/common_text_field.dart';

class CreateReviewScreen extends StatefulWidget {
  final int id;
  const CreateReviewScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController FirstnameController = TextEditingController();
  final TextEditingController LastnameController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();

  @override
  void dispose() {
    FirstnameController.dispose();
    FirstnameController.dispose();
    DescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Reviews'),
        leading: IconButton(
          onPressed: () {
            //Get.find<BottomNavigationBarController>().backToHome();
            //Get.offAll(()=> const HomeScreen());
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: greyColor,
          ),
        ),
      ),
      body: GetBuilder<CreateReviewController>(
        //stream: null,
        builder: (createReviewController) {
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
                        'Give your Review Here',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Give us your Review',
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
                          maxLines: 4,
                          controller: DescriptionController,
                          hintText: 'Description',
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Submit your description';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      createReviewController.createReviewProgress
                          ? const Center(child: CircularProgressIndicator())
                          :
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //CompleteProfileToApi();
                              Get.find<CreateReviewController>()
                                  .createReview(
                                      DescriptionController.text, widget.id)
                                  .then(
                                (value) {
                                  if (value) {
                                    Get.showSnackbar(
                                      const GetSnackBar(
                                        title: 'Success!',
                                        message: 'Review submit Successful.',
                                        duration: Duration(seconds: 2),
                                      ),
                                    );

                                    FirstnameController.clear();
                                    LastnameController.clear();
                                    DescriptionController.clear();


                                    //Get.offAll(const Sho(),duration: const Duration(seconds: 3));
                                    //Get.back();
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
