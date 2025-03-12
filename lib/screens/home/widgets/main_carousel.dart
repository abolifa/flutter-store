import 'package:app/helpers/general_widgets.dart';
import 'package:app/models/slider_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MainCarousel extends StatelessWidget {
  final List<SliderModal> sliders;

  const MainCarousel({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayAnimationDuration: const Duration(milliseconds: 400),
        autoPlayCurve: Curves.decelerate,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: sliders.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                // Set your desired radius here
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.center,
                      image: NetworkImage(
                        GeneralWidgets.getNetworkImage(slider.image),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
