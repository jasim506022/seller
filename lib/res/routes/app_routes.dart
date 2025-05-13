import 'package:get/get.dart';

import '../../view/add_product/manage_product_page.dart';
import '../../view/auth/forget_password_page.dart';
import '../../view/auth/sign_in_page.dart';
import '../../view/auth/sign_up_page.dart';
import '../../view/completeorder/totalsellerpage.dart';
import '../../view/main/main_page.dart';
import '../../view/order/history_page.dart';
import '../../view/order/order_overview_page.dart';
import '../../view/order/order_page.dart';
import '../../view/order/seller_order_breakdown_page.dart';
import '../../view/product/product_details_page.dart';
import '../../view/product/product_page.dart';
import '../../view/profile/edit_profile_page.dart';
import '../../view/splash/onboarding_page.dart';
import '../../view/splash/splash_page.dart';
import 'routes_name.dart';

class AppRoutes {
  static List<GetPage> appRoutes() => [
    // Splash and Onboarding
    GetPage(name: RoutesName.splashPage, page: () => const SplashPage()),
    GetPage(name: RoutesName.onboardingPage, page: () => const OnboardingPage()),

    // Authentication
    GetPage(name: RoutesName.signInPage, page: () => const SignInPage()),
    GetPage(name: RoutesName.forgetPassword, page: () => const ForgetPasswordPage()),
    GetPage(name: RoutesName.signupPage, page: () => const SignUpPage()),

    // Main Pages
    GetPage(name: RoutesName.mainPage, page: () => const MainPage()),
    GetPage(name: RoutesName.uploadAndUpdateProduct, page: () => const ManageProductPage()),

    // Product Pages
    GetPage(name: RoutesName.productDetails, page: () => const ProductDetailsPage()),
    GetPage(name: RoutesName.product, page: () => const ProductPage()),

    // Sales and Order Pages
    GetPage(name: RoutesName.totalSales, page: () => const TotalSellPage()),
    GetPage(name: RoutesName.orderPage, page: () => const OrderScreen()),
    GetPage(name: RoutesName.completeOrderPage, page: () => const CompleteOrderPage()),
    GetPage(name: RoutesName.delivaryPage, page: () => const OrderOverviewPage()),
    GetPage(name: RoutesName.orderDetailsPage, page: () => const SellerOrderBreakdownPage()),

    // Profile Pages
    GetPage(name: RoutesName.editProfilePage, page: () => const EditProfilePage()),
  ];
}
