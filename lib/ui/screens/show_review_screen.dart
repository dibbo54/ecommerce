//import 'package:flutter/cupertino.dart';

import 'package:ecommerce/ui/screens/create_review_screen.dart';
import 'package:ecommerce/ui/state_managers/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state_managers/auth_controller.dart';
import '../state_managers/bottom_navigation_bar_controller.dart';
import '../utils/app_colors.dart';
import 'home_screen.dart';

class ShowReviewScreen extends StatefulWidget {
  final dynamic productId;
  const ShowReviewScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ShowReviewScreen> createState() => _ShowReviewScreenState();
}

class _ShowReviewScreenState extends State<ShowReviewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Get.find<ProductController>().getProductsByCategory(widget.categoryId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Get.find<ProductController>().getProductDetails(widget.productId);
      Get.find<ReviewController>().getReviews(widget.productId);

    });

  }

  @override
  Widget build(BuildContext context) {
    // print(widget.productId.runtimeType);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Reviews'),
        leading: IconButton(
          onPressed: () {
            //Get.find<BottomNavigationBarController>().backToHome();
            //Get.offAll(const HomeScreen());
            //Get.offAll(()=> const HomeScreen());
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: greyColor,
          ),
        ),
      ),
      body: GetBuilder<ReviewController>(
        //init: ProductReviewController(reviews: reviews),
        builder: (reviewController) => ListView.builder(
          //if(reviewController.)

          itemCount: reviewController.reviewModel.data?.length,
          itemBuilder: (context, index) {
            //final review = controller.reviews[index];
            if (reviewController.getReviewInProgress) {
              return const SizedBox(
                height: 90,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/profile_image.jpg'),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Text(
                                  reviewController.reviewModel.data?.first
                                          .profile?.firstName ??
                                      'unkhown',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  reviewController.reviewModel.data?.first
                                          .profile?.lastName ??
                                      'unkhown',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          reviewController
                                  .reviewModel.data?.first.description ??
                              'unkhown',
                        ),
                        SizedBox(height: 8),
                        Text(
                          reviewController.reviewModel.data?.first.createdAt ??
                              'unkhown',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.find<AuthController>().checkAuthValidation();
          if (result) {
            Get.to(CreateReviewScreen(id: widget.productId));
          }
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ProductReviewScreen extends StatelessWidget {
//   final List<Review> reviews;
//
//   const ProductReviewScreen({Key? key, required this.reviews}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Reviews'),
//       ),
//       body: GetBuilder<ProductReviewController>(
//         init: ProductReviewController(reviews: reviews),
//         builder: (controller) => ListView.builder(
//           itemCount: controller.reviews.length,
//           itemBuilder: (context, index) {
//             final review = controller.reviews[index];
//             return Card(
//               elevation: 2,
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 20,
//                           backgroundImage: AssetImage('assets/profile_image.jpg'),
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           review.userName,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Text(review.description),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class ProductReviewController extends GetxController {
//   final List<Review> reviews;
//
//   ProductReviewController({required this.reviews});
// }
//
// class Review {
//   final String userName;
//   final String description;
//
//   Review({required this.userName, required this.description});
// }
