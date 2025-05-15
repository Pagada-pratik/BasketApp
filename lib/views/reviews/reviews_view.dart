// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/review_card.dart';
import '../../components/skeleton/others/review_card_skeleton.dart';
import '../../controllers/profile_controller.dart';
import '../../controllers/reviews/review_controller.dart';
import '../../resources/app_colors.dart';
import '../../resources/constants.dart';
import '../../routes/routes_name.dart';
import '../../utils/message_utils.dart';
import '../product/components/product_list_tile.dart';
import 'components/user_review_card.dart';

class ReviewsView extends StatefulWidget {
  final List<dynamic> productData;
  const ReviewsView({super.key, required this.productData});

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  ReviewController reviewController = Get.put(ReviewController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    reviewController.getReviewByProductIDApiResponse(context, widget.productData[0]['id'].toString());
  }

  @override
  void dispose() {
    Get.delete<ReviewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            "assets/icons/Arrow - Left.svg",
            height: 26,
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.bodyLarge!.color!,
              BlendMode.srcIn,
            ),
          ),
        ),
        title: const Text("Reviews"),
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            Obx(() => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: ReviewCard(
                  rating: reviewController.averageRating.value.isNaN || reviewController.averageRating.value.isInfinite
                      ? 0.0
                      : reviewController.averageRating.value,
                  numOfReviews: reviewController.totalReviews.value,
                  numOfFiveStar: reviewController.fiveStarCount.value,
                  numOfFourStar: reviewController.fourStarCount.value,
                  numOfThreeStar: reviewController.threeStarCount.value,
                  numOfTwoStar: reviewController.twoStarCount.value,
                  numOfOneStar: reviewController.oneStarCount.value,
                ),
              ),
            )),
            ProductListTile(
              svgSrc: "assets/icons/Chat-add.svg",
              title: "Add Review",
              isShowBottomBorder: true,
              press: () async {

                if(profileController.userId.isEmpty) {
                  MessageUtils.flushBarErrorMessage('Login required!', context);
                  return;
                }

                await Navigator.pushNamed(context, RoutesName.addReviewScreen,
                  arguments: {
                    'productData': widget.productData,
                  },
                );
                Get.delete<ReviewController>();
                reviewController.getReviewByProductIDApiResponse(context, widget.productData[0]['id'].toString());
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppConstants.defaultPadding / 2.5)),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppConstants.defaultPadding),
                child: Text(
                  "User reviews",
                  style: TextStyle(fontSize: 16, color: AppColors.blackColor),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppConstants.defaultPadding / 2.5)),
            Obx(() => (reviewController.getProductReview.isNotEmpty) ?
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviewController.getProductReview.length,
                itemBuilder: (context, index) {
                  final reviewData = reviewController.getProductReview.reversed.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: AppConstants.defaultPadding,
                      right: AppConstants.defaultPadding,
                    ),
                    child: UserReviewCard(
                      name: reviewData.name,
                      review: reviewData.review,
                      rating: reviewData.rating.toString(),
                    ),
                  );
                },
              ),
            ) : (!reviewController.isReviewsNotFound.value)
                ? const SliverToBoxAdapter(child: ReviewCardSkeleton())
                : SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? "assets/Illustration/EmptyState_lightTheme.png"
                        : "assets/Illustration/EmptyState_darkTheme.png",
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Text(
                    "Reviews not found",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}