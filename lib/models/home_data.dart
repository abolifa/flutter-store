import 'package:app/models/brand.dart';
import 'package:app/models/category.dart';
import 'package:app/models/offer.dart';
import 'package:app/models/section.dart';
import 'package:app/models/slider_model.dart';

class HomeData {
  final List<Category> categories;
  final List<Brand> brands;
  final List<SliderModal> sliders;
  final List<Offer> offers;
  final List<Section> sections;

  HomeData({
    required this.categories,
    required this.brands,
    required this.sliders,
    required this.offers,
    required this.sections,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      categories: (json['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList(),
      brands: (json['brands'] as List)
          .map((brand) => Brand.fromJson(brand))
          .toList(),
      sliders: (json['sliders'] as List)
          .map((slider) => SliderModal.fromJson(slider))
          .toList(),
      offers: (json['offers'] as List)
          .map((offer) => Offer.fromJson(offer))
          .toList(),
      sections: (json['sections'] as List)
          .map((section) => Section.fromJson(section))
          .toList(),
    );
  }
}
