import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/categories/categories_view.dart';
import '../views/checkout/cart_view.dart';
import '../views/checkout/checkout_process.dart';
import '../views/checkout/order_payments_view.dart';
import '../views/entry_point_view.dart';
import '../views/home/home_view.dart';
import '../views/onboarding/onboarding_view.dart';
import '../views/product/product_details_view.dart';
import '../views/profile/my_orders_view.dart';
import '../views/profile/profile_details_view.dart';
import '../views/profile/profile_view.dart';
import '../views/profile/update/address_update_view.dart';
import '../views/profile/update/profile_update_view.dart';
import '../views/reviews/add_review_view.dart';
import '../views/reviews/reviews_view.dart';
import '../views/sales/on_sale_view.dart';
import '../views/search/search_view.dart';
import '../views/splash_view.dart';
import '../views/wishlist/wishlist_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.onBoardingScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const OnBoardingView());

      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());

      case RoutesName.registerScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const RegisterView());

      case RoutesName.entryPointScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const EntryPointView());

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeView());

      case RoutesName.categoriesScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const CategoriesView());

      case RoutesName.wishlistScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const WishlistView());

      case RoutesName.cartScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const CartView());

      case RoutesName.profileScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const ProfileView());

      case RoutesName.searchScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SearchView());

      case RoutesName.checkoutProcessScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const CheckoutProcess());

      case RoutesName.orderPaymentsScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const OrderPaymentsView());

      case RoutesName.myOrdersScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const MyOrdersView());

      case RoutesName.profileDetailsScreen:
        return MaterialPageRoute(builder: (BuildContext context) => ProfileDetailsView());

      case RoutesName.profileUpdateScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const ProfileUpdateView());

      case RoutesName.addressUpdateScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const AddressUpdateView());

      case RoutesName.onSaleScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final List<CategoryModel> subCategory = args['subCategory'] as List<CategoryModel>? ?? [];
        final int categoryIndex = args['categoryIndex'] ?? 0;
        return MaterialPageRoute(builder: (BuildContext context) => OnSaleView(subCategory, categoryIndex));

      case RoutesName.productDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final int productId = args['productId'] ?? 0;
        final int categoryId = args['categoryId'] ?? 0;
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductDetailsView(
            productId: productId,
            categoryId: categoryId,
          ),
        );

      case RoutesName.reviewsScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final productData = args['productData'] as List<dynamic>? ?? [];
        return MaterialPageRoute(
          builder: (BuildContext context) => ReviewsView(productData: productData),
        );

      case RoutesName.addReviewScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final productData = args['productData'] as List<dynamic>? ?? [];
        return MaterialPageRoute(
          builder: (BuildContext context) => AddReviewView(productData: productData),
        );


      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Routes Found."),
            ),
          );
        });
    }
  }
}