import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/home_slider_model.dart';
import '../../data/services/network_caller.dart';

class HomeController extends GetxController {
  bool _getSliderInProgress = false;
  HomeSliderModel _homeSliderModel = HomeSliderModel();

  bool get getSliderInProgress => _getSliderInProgress;

  HomeSliderModel get homeSliderModel => _homeSliderModel;

  Future<bool> getHomeSlider() async {
    _getSliderInProgress = true;
    update();
    final response = await NetworkCaller.getRequest(url: '/ListProductSlider');
    _getSliderInProgress = false;
    if (response.isSuccess) {
      _homeSliderModel = HomeSliderModel.fromJson(response.returnData);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}