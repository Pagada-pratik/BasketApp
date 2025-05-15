class ReviewModel {
  final int reviewId;
  final String name;
  final String email;
  final String review;
  final int rating;

  ReviewModel({
    required this.reviewId,
    required this.name,
    required this.email,
    required this.review,
    required this.rating,
  });
}