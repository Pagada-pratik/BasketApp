import 'package:form_field_validator/form_field_validator.dart';

class AppConstants {
  static const String appLogo = "assets/logo/logoMyBasket.png";
  static const productDemoImg1 = "https://i.imgur.com/CGCyp1d.png";
  static const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
  static const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
  static const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
  static const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
  static const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";

  static const plusJakartaFont = "Plus Jakarta";
  static const grandisExtendedFont = "Grandis Extended";

  static const double defaultPadding = 16.0;
  static const double defaultFontSize = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const Duration defaultDuration = Duration(milliseconds: 300);

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character'),
  ]);

  static final emailIdValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: "Enter a valid email address"),
  ]);

  static final usernameValidator = MultiValidator([
    RequiredValidator(errorText: 'Username is required'),
  ]);

  static final reviewValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
  ]);

  static final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Billing First name is a required field'),
  ]);

  static final lastNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Billing Last name is a required field'),
  ]);

  static final streetAddressValidator = MultiValidator([
    RequiredValidator(errorText: 'Billing Street address is a required field'),
  ]);

  static final townCityValidator = MultiValidator([
    RequiredValidator(errorText: 'Billing Town / City is a required field'),
  ]);

  static final postcodeZIPValidator = MultiValidator([
    RequiredValidator(errorText: 'Billing Postcode / ZIP is a required field'),
  ]);

  static final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Billing Phone is a required field'),
  ]);

  static final emailFieldValidator = MultiValidator([
    RequiredValidator(errorText: 'Billing Email address is a required field'),
    EmailValidator(errorText: "Enter a valid email address"),
  ]);

  static const pasNotMatchErrorText = "Passwords do not match";

  static final fnValidator = MultiValidator([
    RequiredValidator(errorText: 'First name is required'),
  ]);

  static final lnValidator = MultiValidator([
    RequiredValidator(errorText: 'Last name is required'),
  ]);

  static const String consumerKey =
      'ck_db6d1d51962e6117133663cfc07e29032583ea13';
  static const String consumerSecret =
      'cs_0db74683aefbc7d1634232acb2bff830b2b4ec32';
  static const String wooCommerceAuthorizationToken =
      'Y2tfZGI2ZDFkNTE5NjJlNjExNzEzMzY2M2NmYzA3ZTI5MDMyNTgzZWExMzpjc18wZGI3NDY4M2FlZmJjN2QxNjM0MjMyYWNiMmJmZjgzMGIyYjRlYzMy';
  static const String adminAuthorizationToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL25ldGluZm9kZW1vMS5jb20iLCJpYXQiOjE3NDQ5ODEwMzcsIm5iZiI6MTc0NDk4MTAzNywiZXhwIjoxNzQ1NTg1ODM3LCJkYXRhIjp7InVzZXIiOnsiaWQiOiIxIn19fQ.nzDnciVKqGnq7hJbJ6-UPsrDQUW84hvgH5Vc3vi_hkE';
}
