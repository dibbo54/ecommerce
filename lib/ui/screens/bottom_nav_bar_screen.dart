import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../state_managers/bottom_navigation_bar_controller.dart';
import '../state_managers/category_controller.dart';
import '../state_managers/home_controller.dart';
import '../state_managers/product_by_remark_controller.dart';
import '../utils/app_colors.dart';
import 'cart_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';
import 'wish_list_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final List<Widget> _screens = const [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    WishListScreen()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeController>().getHomeSlider();
      Get.find<CategoryController>().getCategories();
      Get.find<ProductByRemarkController>().getPopularProductsByRemark();
      Get.find<ProductByRemarkController>().getNewProductsByRemark();
      Get.find<ProductByRemarkController>().getSpecialProductsByRemark();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomNavigationBarController>(
          builder: (controller) {
            return _screens[controller.selectedIndex];
          }
      ),
      bottomNavigationBar: GetBuilder<BottomNavigationBarController>(
          builder: (controller) {
            return BottomNavigationBar(
              onTap: (value) {
                controller.changeIndex(value);
              },
              elevation: 5,
              selectedItemColor: primaryColor,
              unselectedItemColor: softGreyColor,
              currentIndex: controller.selectedIndex,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.grid_view),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: 'Cart'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    label: 'Wishlist'
                ),
              ],
            );
          }
      ),
    );
  }
}
