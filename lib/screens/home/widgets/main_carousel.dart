import 'package:app/helpers/general_widgets.dart';
import 'package:app/models/slider_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MainCarousel extends StatelessWidget {
  final List<SliderModal> sliders;

  const MainCarousel({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 180,
          aspectRatio: 4 / 1,
          viewportFraction: 0.87,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 10),
          autoPlayAnimationDuration: const Duration(milliseconds: 400),
          autoPlayCurve: Curves.linear,
          enlargeCenterPage: false,
          // Disable enlarging to reduce spacing
          scrollDirection: Axis.horizontal,
        ),
        items: sliders.map((slider) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                // Reduce horizontal padding
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    GeneralWidgets.getNetworkImage(slider.image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
