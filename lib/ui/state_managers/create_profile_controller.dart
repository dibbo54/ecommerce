import 'package:get/get.dart';

import '../../data/services/network_caller.dart';

class CreateProfileController extends GetxController {
  bool _createProfileProgress = false;

  bool get createProfileProgress => _createProfileProgress;

  Future<bool> createProfile(String firstName, String lastName, String mobile,
      String city, String shippingAddress) async {
    _createProfileProgress = true;
    update();
    final response =
        await NetworkCaller.postRequest(url: '/CreateProfile', body: {
      // "product_id" : productId,
      // "color" : color,
      // "size" : size

      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "city": city,
      "shippingAddress": shippingAddress
    });
    _createProfileProgress = false;
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
