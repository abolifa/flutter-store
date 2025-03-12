import 'package:app/models/section.dart';
import 'package:app/providers/section_product_provider.dart';
import 'package:app/screens/products/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionWidget extends StatefulWidget {
  final Section section;

  const SectionWidget({super.key, required this.section});

  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<SectionProductProvider>()
          .fetchSectionProducts(widget.section.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SectionProductProvider>(
      builder: (context, provider, child) {
        final products = provider.sectionProducts[widget.section.id] ?? [];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.section.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<SectionProductProvider>()
                          .fetchSectionProducts(widget.section.id);
                    },
                    child: const Text(
                      'عرض الكل',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  right: 10,
                  bottom: 10,
                  top: 5,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductWidget(product: product);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 5),
              ),
            ),
          ],
        );
      },
    );
  }
}
