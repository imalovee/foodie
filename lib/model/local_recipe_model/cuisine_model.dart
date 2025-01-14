import 'dart:ui';

class CuisineModel{
  final String id;
  final String title;
  final String subTitle;
  final String imageUrl;

  const CuisineModel({
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.subTitle
});
}