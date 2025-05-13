import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/category_manager_controller.dart';
import '../controller/loading_controller.dart';
import '../controller/manage_product_controller.dart';
import '../controller/onboarding_controller.dart';
import '../controller/order_controller.dart';
import '../controller/product_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/product_search_controller.dart';
import '../controller/select_image_controller.dart';
import '../controller/splash_controller.dart';

import '../repository/add_product_repository.dart';
import '../repository/auth_repository.dart';
import '../repository/order_repository.dart';
import '../repository/product_repository.dart';
import '../repository/profile_repository.dart';
import '../repository/select_image_repository.dart';
import '../repository/splash_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 🔹 Splash
    Get.lazyPut(() => SplashRepository());
    Get.lazyPut(() => SplashController(repository: Get.find()));

    // 🔹 Onboarding
    Get.lazyPut(() => OnboardingController());

    // 🔹 Auth
    Get.lazyPut(() => AuthRepository(), fenix: true);
    Get.lazyPut(() => AuthController(repository: Get.find()), fenix: true);

    // 🔹 Product Management
    Get.lazyPut(() => AddProductRepository(), fenix: true);
    Get.lazyPut(() => ManageProductController(repository: Get.find()), fenix: true);

    Get.lazyPut(() => ProductRepository(), fenix: true);
    Get.lazyPut(() => ProductController(repository: Get.find()), fenix: true);

    // 🔹 Order
    Get.lazyPut(() => OrderRepository(), fenix: true);
    Get.lazyPut(() => OrderController(Get.find()), fenix: true);

    // 🔹 Profile
    Get.lazyPut(() => ProfileRepository(), fenix: true);
    Get.lazyPut(() => ProfileController(repository: Get.find()), fenix: true);

    // 🔹 Image Selector
    Get.lazyPut(() => SelectImageRepository(), fenix: true);
    Get.lazyPut(() => SelectImageController(repository: Get.find()), fenix: true);

    // 🔹 Other Controllers
    Get.lazyPut(() => CategoryManagerController(), fenix: true);
    Get.lazyPut(() => ProductSearchController());
    Get.put(LoadingController(), permanent: true);
  }
}
