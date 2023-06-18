import 'package:get/get.dart';

import '../../data/models/review_model.dart';
import '../../data/services/network_caller.dart';


class ReviewController extends GetxController {
  ReviewModel _reviewModel = ReviewModel();
  bool _getReviewInProgress = false;

  bool get getReviewInProgress => _getReviewInProgress;

  ReviewModel get reviewModel => _reviewModel;

  Future<bool> getReviews(int productId) async {
    _getReviewInProgress = true;
    update();
    final response =
        await NetworkCaller.getRequest(url: '/ListReviewByProduct/$productId');
    _getReviewInProgress = false;
    if (response.isSuccess) {
      _reviewModel = ReviewModel.fromJson(response.returnData);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
