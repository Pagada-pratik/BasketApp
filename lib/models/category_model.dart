class CategoryModel {
  final int? id;
  final String? title;
  final String? slug;
  final int? parent;
  final String? description;
  final List<CategoryModel> subCategories;

  CategoryModel({
    this.id,
    this.title,
    this.slug,
    this.parent,
    this.description,
    this.subCategories = const [],
  });
}