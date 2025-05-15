// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/review_model.dart';
import '../../repositories/review_repository.dart';
import '../../utils/message_utils.dart';

class ReviewController extends GetxController {
  final myReviewRepo = ReviewRepository();
  List<ReviewModel> getProductReview = <ReviewModel>[].obs;
  RxBool isReviewsNotFound = false.obs;
  RxDouble averageRating = 0.0.obs;
  RxInt totalReviews = 0.obs;
  RxInt oneStarCount = 0.obs;
  RxInt twoStarCount = 0.obs;
  RxInt threeStarCount = 0.obs;
  RxInt fourStarCount = 0.obs;
  RxInt fiveStarCount = 0.obs;

  Future<void> getReviewByProductIDApiResponse(BuildContext context, String productId) async {
    isReviewsNotFound.value = false;
    getProductReview.clear();

    //Check for is user login or not...
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if(token == null || token.isEmpty) {
      isReviewsNotFound.value = true;
      return;
    }

    await myReviewRepo.getReviewByProductIDApiCall(productId).then((value) {
      getProductReview.assignAll(value.map<ReviewModel>((item) {
        return ReviewModel(
          reviewId: item['id'],
          name: item['name'],
          email: item['email'],
          review: item['review'],
          rating: item['rating'],
        );
      }).toList());
      if (getProductReview.isEmpty) {
        isReviewsNotFound.value = true;
      }
      calculateReviewStatistics();
    }).onError((error, stackTrace) {
      MessageUtils.flushBarErrorMessage(error.toString(), context);
    });
  }

  void calculateReviewStatistics() {
    totalReviews.value = getProductReview.length;
    oneStarCount.value = getProductReview.where((review) => review.rating == 1).length;
    twoStarCount.value = getProductReview.where((review) => review.rating == 2).length;
    threeStarCount.value = getProductReview.where((review) => review.rating == 3).length;
    fourStarCount.value = getProductReview.where((review) => review.rating == 4).length;
    fiveStarCount.value = getProductReview.where((review) => review.rating == 5).length;

    if (totalReviews.value > 0) {
      double totalRating = getProductReview
          .map((review) => review.rating)
          .reduce((a, b) => a + b)
          .toDouble();
      averageRating.value = totalRating / totalReviews.value;
    } else {
      averageRating.value = 0.0;
    }
  }
}