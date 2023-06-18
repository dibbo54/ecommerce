
import 'package:ecommerce/data/models/profile_model.dart';

//ProfileModel()
// import 'package:get/get.dart';
//
// import '../../data/models/profile_model.dart';
// import '../../data/services/network_caller.dart';
//
// class CategoryController extends GetxController {
//   final ProfileModel _profileModeltwo = ProfileModel();
//   bool _getCategoryInProgress = false;
//
//   //bool get getCategoryInProgress => _getCategoryInProgress;
//
//   CategoryModel get categoryModel => _categoryModel;
//
//   Future<bool> getCategories() async {
//     _getCategoryInProgress = true;
//     update();
//     final response = await NetworkCaller.getRequest(url: '/CategoryList');
//     _getCategoryInProgress = false;
//     if (response.isSuccess) {
//       _categoryModel = CategoryModel.fromJson(response.returnData);
//       update();
//       return true;
//     } else {
//       update();
//       return false;
//     }
//   }
// }