import 'package:get/get.dart';

import '../../data/services/network_caller.dart';


class CreateReviewController extends GetxController {
  bool _createReviewProgress = false;

  bool get createReviewProgress => _createReviewProgress;

  Future<bool> createReview(String description,int productId) async {
    _createReviewProgress = true;
    update();
    final response =
    await NetworkCaller.postRequest(url: '/CreateProductReview', body: {
      // "product_id" : productId,
      // "color" : color,
      // "size" : size

      "description" : description,
      "product_id": productId
    });
    _createReviewProgress = false;
    if (response.isSuccess) {
      update();
      return true;
    } else {
      // if (response.statusCode == 401) {
      //   Get.find<AuthController>().logOut();
      // }
      update();
      return false;
    }
  }
}
