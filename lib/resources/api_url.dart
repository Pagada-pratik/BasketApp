class ApiUrl {
  static var baseUrl = "https://netinfodemo1.com";

  static var loginEndPoint = "$baseUrl/wp-json/jwt-auth/v1/token";
  static var registerEndPoint = "$baseUrl/wp-json/custom/v1/register";
  static var forgotEndPoint = "$baseUrl/wp-json/custom/v1/forgotPassword";
  static var getCurrentUserEndPoint = "$baseUrl/wp-json/wp/v2/users/me";

  static var getProductsByIdEndPoint = "$baseUrl/wp-json/wc/v3/products";

  static var imageSliderEndPoint = "$baseUrl/wp-json/acf/v1/top_image_slider";
  static var homeCategoriesEndPoint = "$baseUrl/wp-json/acf/v1/category_slider";

  static var onSaleBannerEndPoint = "$baseUrl/wp-json/acf/v1/dod_banner";
  static var onSaleProductsEndPoint =
      "$baseUrl/wp-json/custom/v1/products/on-sale";

  static var sectionBaseHomeProductsEndPoint =
      "$baseUrl/wp-json/acf/v1/app_settings";

  static var categoriesEndPoint = "$baseUrl/wp-json/wc/v3/products/categories";

  static var getWishlistEndPoint =
      "$baseUrl/wp-json/custom/v1/wishlist/products";
  static var addProductToWishlistEndPoint =
      "$baseUrl/wp-json/custom/v1/wishlist/add-product";
  static var removeProductToWishlistEndPoint =
      "$baseUrl/wp-json/custom/v1/wishlist/remove-product";
  static var checkProductInWishlistEndPoint =
      "$baseUrl/wp-json/custom/v1/wishlist/check-product";

  static var createReviewEndPoint = "$baseUrl/wp-json/wc/v3/products/reviews";
  static var getReviewByProductIDEndPoint = "$baseUrl/wp-json/wc/v2/products";

  static var addProductToCartEndPoint =
      "$baseUrl/wp-json/cocart/v2/cart/add-item";
  static var getCartForUserEndPoint = "$baseUrl/wp-json/cocart/v2/cart";
  static var checkProductInCartEndPoint =
      "$baseUrl/wp-json/custom/v1/check-cart-product";
  static var updateProductInCartEndPoint =
      "$baseUrl/wp-json/cocart/v2/cart/item";
  static var clearCartEndPoint = "$baseUrl/wp-json/cocart/v2/cart/clear";
  static var notifyMeEndPoint = "$baseUrl/wp-json/custom/v1/createNotifyMe";

  static var checkUserEmailEndPoint = "$baseUrl/wp-json/custom/v1/checkuser";
  static var createOrderEndPoint = "$baseUrl/wp-json/wc/v3/orders";
  static var ordersComplaintEndPoint = "$baseUrl/wp-json/custom/v1/getcomplain";
  static var submitComplaintEndPoint = "$baseUrl/wp-json/custom/v1/submitcomplain";
  static var couponsDiscountEndPoint = "$baseUrl/wp-json/wc/v3/coupons";

  static var getUserProfileAndAddressEndPoint =
      "$baseUrl/wp-json/custom/v1/profile";
  static var updateUserProfileAndAddressEndPoint =
      "$baseUrl/wp-json/wc/v3/customers";
  static var updateUserProfileEndPoint = "$baseUrl/wp-json/wp/v2/users";
  static var changePasswordEndPoint = "$baseUrl/wp-json/custom/v1/changePassword";
}
