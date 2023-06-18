import 'dart:async';

import 'package:ecommerce/ui/screens/bottom_nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/models/profile_model.dart';
import '../../data/services/network_caller.dart';
import '../../restApi/getRequest.dart';
import '../state_managers/auth_controller.dart';
import '../state_managers/user_auth_controller.dart';
import '../state_managers/user_profile_controller_two.dart';
import '../utils/app_colors.dart';
import '../utils/styles.dart';
import 'complete_profile_screen.dart';
import 'home_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpETController = TextEditingController();

  int _start = 120; // Timer duration in seconds
  late Timer _timer;
  //l//ate bool usernewornot;

  @override
  void initState() {
    super.initState();
    startTimer();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Get.find<ProductController>().getProductDetails(widget.productId);
    //   //Get.find<UserProfileControllerTwo>().getProfileDataTwo();
    // });

    //usernewornot=await userneworold();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start == 0) {
            timer.cancel(); // Stop the timer when it reaches 0
          } else {
            _start--;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserAuthController>(builder: (userAuthController) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Enter OTP Code',
                style: titleTextStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'A 4 digit OTP code has been sent',
                style: subTitleTextStyle,
              ),
              const SizedBox(
                height: 24,
              ),
              PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                controller: _otpETController,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 45,
                    fieldWidth: 45,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.green,
                    activeColor: primaryColor,
                    inactiveColor: primaryColor,
                    inactiveFillColor: Colors.white),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v) {},
                onChanged: (value) {},
                appContext: context,
              ),
              const SizedBox(
                height: 16,
              ),
              userAuthController.otpVerificationInProgress
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final bool response =
                              await userAuthController.otpVerification(
                                  widget.email, _otpETController.text);
                          if (response) {
                            //Get.off(()=>const CompleteProfileScreen());

                            // typeone

                            final responseone = await NetworkCaller.getRequest(
                                url: '/ReadProfile');
                            //final ProfileModel profileModel = ProfileModel.fromJson(responseone.returnData);
                            if (responseone.returnData['data'] == null) {
                              //if(profileModel.data!.isEmpty){
                              Get.offAll(const CompleteProfileScreen());
                            } else {
                              Get.offAll(const BottomNavBarScreen());
                            }

                            //typetwo
                            //
                            // if (AuthController.profile != null) {
                            //   Get.offAll(const HomeScreen());
                            //   }
                            //
                            // else{
                            //   Get.to(const CompleteProfileScreen());
                            // }
                          } else {
                            Get.showSnackbar(
                              const GetSnackBar(
                                title: 'Otp verification Failed',
                                message:
                                    'Check once again before enter your otp',
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                          setState(() {
                            _start = 120;
                          });
                          startTimer();
                        },
                        child: const Text('Next'),
                      ),
                    ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 13, color: softGreyColor),
                  text: 'This code will be expire in ',
                  // children: [
                  //   TextSpan(
                  //     style: TextStyle(
                  //         color: primaryColor, fontWeight: FontWeight.w600),
                  //     text: '$_start seconds',
                  //   ),
                  //
                  // ],
                ),
              ),
              Text(
                '$_start seconds',
                style: const TextStyle(
                    color: primaryColor, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () async {
                  await userAuthController.otpVerification(
                      widget.email, _otpETController.text);
                },
                child: Text(
                  'Resend Code',
                  style: TextStyle(color: greyColor.withOpacity(0.5)),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
