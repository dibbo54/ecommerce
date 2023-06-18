import 'package:ecommerce/ui/screens/updateProfileScreen.dart';
import 'package:ecommerce/ui/screens/complete_profile_screen.dart';
import 'package:ecommerce/ui/screens/home_screen.dart';
import 'package:ecommerce/ui/state_managers/user_profile_controller_two.dart';
import 'package:ecommerce/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_managers/auth_controller.dart';
import '../state_managers/bottom_navigation_bar_controller.dart';

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 16.0),
//           CircleAvatar(
//             radius: 80.0,
//             backgroundImage: NetworkImage(
//                 'https://example.com/avatar.png'), // Replace with the user's avatar image URL
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             'John Doe', // Replace with the user's name
//             style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8.0),
//           Text(
//             'Software Engineer', // Replace with the user's occupation
//             style: TextStyle(fontSize: 16.0),
//           ),
//           SizedBox(height: 16.0),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               margin: EdgeInsets.symmetric(horizontal: 16.0),
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'About Me',
//                     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', // Replace with the user's bio
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                   SizedBox(height: 16.0),
//                   Text(
//                     'Interests',
//                     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0),
//                   Wrap(
//                     spacing: 8.0,
//                     runSpacing: 8.0,
//                     children: [
//                       Chip(
//                         label: Text('Rabbil Hasan'),
//                         backgroundColor: Colors.blue,
//                         labelStyle: TextStyle(color: Colors.white),
//                       ),
//                       Chip(
//                         label: Text('01317734711'),
//                         backgroundColor: Colors.green,
//                         labelStyle: TextStyle(color: Colors.white),
//                       ),
//                       Chip(
//
//                         label: Text('City'),
//
//                         backgroundColor: Colors.orange,
//                         labelStyle: TextStyle(color: Colors.white),
//                       ),
//                       // Add more interests here as needed
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Get.find<UserProfileController>().getProfileData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Get.find<ProductController>().getProductDetails(widget.productId);
      Get.find<UserProfileControllerTwo>().getProfileDataTwo();

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(
          onPressed: () {
            Get.find<BottomNavigationBarController>().backToHome();
            //Get.offAll(const HomeScreen());
           // Get.to(const HomeScreen());
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: greyColor,
          ),
        ),
      ),
      //GetBuilder<UserAuthController>(builder: (userAuthController)
      body: GetBuilder<UserProfileControllerTwo>(
          builder: (userProfileControllerTwo) {
        if (userProfileControllerTwo.getProfileDataInProgress) {
          return const SizedBox(
            height: 180,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        //if( userneworold()){}
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        userProfileControllerTwo
                                .profileModel.data?.first.firstName ??
                            "Set your profile first",
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        userProfileControllerTwo
                                .profileModel.data?.first.lastName ??
                            "Set your profile first",
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        userProfileControllerTwo
                                .profileModel.data?.first.mobile ??
                            "Set your profile first",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        userProfileControllerTwo
                                .profileModel.data?.first.email ??
                            "Set your profile first",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shipping Address',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      userProfileControllerTwo
                              .profileModel.data?.first.shippingAddress ??
                          "Set your profile first",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'City',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      userProfileControllerTwo.profileModel.data!.first.city ??
                          "Set your profile first",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.find<AuthController>().logOut();
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await Get.find<AuthController>()
                              .checkAuthValidation();
                          if (result) {
                            Get.off(()=>const UpdateProfileScreen());
                          }


                          //Get.find<CreateProfileController>().createProfile(userProfileControllerTwo.profileModel.data.first.city, lastName, mobile, city, shippingAddress);
                        },
                        child: const Text(
                          'Update your profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
