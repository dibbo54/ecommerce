import 'package:get/get.dart';

import '../../data/models/profile_model.dart';
import '../../data/services/network_caller.dart';

class UserProfileControllerTwo extends GetxController {
  ProfileModel _profileModel = ProfileModel();
  bool _getProfileDataInProgress = false;


  ProfileModel get profileModel => _profileModel;
  bool get getProfileDataInProgress => _getProfileDataInProgress;

  Future<bool> getProfileDataTwo() async {
    _getProfileDataInProgress = true;
    update();
    final response = await NetworkCaller.getRequest(url: '/ReadProfile');
    _getProfileDataInProgress = false;

    if (response.isSuccess) {
      _profileModel = ProfileModel.fromJson(response.returnData);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
