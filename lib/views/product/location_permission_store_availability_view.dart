import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../utils/theme/input_decoration_theme.dart';

class LocationPermissionStoreAvailabilityView extends StatelessWidget {
  const LocationPermissionStoreAvailabilityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppConstants.defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    child: BackButton(),
                  ),
                  Text(
                    "Store Pickup Availability",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      child: TextFormField(
                        cursorColor: AppColors.primaryAppColor,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: "Find something...",
                          border: secondaryOutlineInputBorder(context),
                          enabledBorder: secondaryOutlineInputBorder(context),
                          focusedBorder: secondaryOutlineInputBorder(context),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(AppConstants.defaultPadding / 2),
                            child: SvgPicture.asset(
                              "assets/icons/Search.svg",
                              height: 24,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle!
                                  .color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 1.5),
                        child: Image.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? "assets/Illustration/Illustration-4.png"
                              : "assets/Illustration/Illustration_darkTheme_4.png",
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                    ),
                    Text(
                      "Your Location Services are turned off.",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                    const SizedBox(height: AppConstants.defaultPadding),
                    const Text(
                      "Turn on Location Services in your device Settings to search for stores by current location. You can still search by Country/Region, City or Zip Code.",
                    ),
                    const SizedBox(height: AppConstants.defaultPadding * 1.5),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Settings"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}