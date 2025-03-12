import 'package:app/models/offer.dart';
import 'package:app/providers/favorite_provider.dart';
import 'package:app/providers/home_data_provider.dart';
import 'package:app/screens/home/widgets/category_bubble.dart';
import 'package:app/screens/home/widgets/home_scree_delivery_widget.dart';
import 'package:app/screens/home/widgets/main_carousel.dart';
import 'package:app/screens/home/widgets/main_screen_search_widget.dart';
import 'package:app/screens/home/widgets/offer_widget.dart';
import 'package:app/screens/home/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeDataProvider>().fetchHomeData();
      context.read<FavoriteProvider>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainScreenSearchWidget(),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight - 20),
          child: HomeScreeDeliveryWidget(),
        ),
      ),
      body: Consumer<HomeDataProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          } else if (provider.homeData == null) {
            return Center(child: Text('No data available'));
          } else {
            final categories = provider.homeData!.categories;
            // final brands = provider.homeData!.brands;
            final sections = provider.homeData!.sections;
            final offers = provider.homeData!.offers;
            final sliders = provider.homeData!.sliders;

            final List<Offer> offersBelowSlider = offers
                .where((offer) => offer.position == 'below_slider')
                .toList();

            final List<Offer> offersTop =
                offers.where((offer) => offer.position == 'top').toList();

            final List<Offer> offersBelowCategories = offers
                .where((offer) => offer.position == 'below_categories')
                .toList();

            final List<Offer> offersBelowSection = offers
                .where((offer) => offer.position == 'below_section')
                .toList();

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    spacing: 5,
                    children: [
                      const SizedBox(height: 5),
                      if (sliders.isNotEmpty) MainCarousel(sliders: sliders),
                      if (offersTop.isNotEmpty) OfferWidget(offers: offersTop),
                      if (offersBelowSlider.isNotEmpty)
                        OfferWidget(offers: offersBelowSlider),
                      if (categories.isNotEmpty)
                        CategoryBubble(categories: categories),
                      if (offersBelowCategories.isNotEmpty)
                        OfferWidget(offers: offersBelowCategories),
                      if (sections.isNotEmpty)
                        for (final section in sections)
                          Container(
                            height: 350,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: SectionWidget(section: section),
                          ),
                      if (offersBelowSection.isNotEmpty)
                        OfferWidget(offers: offersBelowSection),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
