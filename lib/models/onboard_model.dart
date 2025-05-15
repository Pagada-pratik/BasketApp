class OnBoard {
  final String image, title, description;
  final String? imageDarkTheme;

  OnBoard({
    required this.image,
    required this.title,
    this.description = "",
    this.imageDarkTheme,
  });
}