import 'package:app/helpers/general_widgets.dart';
import 'package:app/models/category.dart';
import 'package:app/providers/home_data_provider.dart';
import 'package:app/screens/category/widgets/expansion_widget.dart';
import 'package:app/screens/home/widgets/main_screen_search_widget.dart';
import 'package:app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int? selectedCategoryIndex;
  List<Category> selectedCategoryItems = [];

  void selectCategory(int index, List<Category>? items) {
    setState(() {
      if (selectedCategoryIndex == index) {
        selectedCategoryIndex = null;
        selectedCategoryItems = [];
      } else {
        selectedCategoryIndex = index;
        selectedCategoryItems = items ?? [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeDataProvider = Provider.of<HomeDataProvider>(context);
    final categories = homeDataProvider.homeData?.categories ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Navbar(
        title: const Text('التصنيفات'),
        bottom: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: MainScreenSearchWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Text(
                  'الفئات',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.65,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    separatorBuilder: (context, index) {
                      if (index == selectedCategoryIndex) {
                        if (selectedCategoryItems.isNotEmpty) {
                          return ExpansionWidget(
                              categories: selectedCategoryItems);
                        } else {
                          return SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(
                                'لا يوجد أقسام فرعية',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                      return const Divider(thickness: 0.3);
                    },
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ListTile(
                        title: Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRect(
                                child: Image.network(
                                  GeneralWidgets.getNetworkImage(
                                    category.image,
                                  ),
                                ),
                              ),
                              Text(
                                category.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              if (selectedCategoryIndex == index)
                                const Icon(
                                  LucideIcons.chevronUp,
                                  size: 20,
                                )
                              else
                                const Icon(
                                  LucideIcons.chevronDown,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                        onTap: () => selectCategory(index, category.children),
                        selected: selectedCategoryIndex == index,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
