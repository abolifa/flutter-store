import 'package:app/helpers/general_widgets.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';

class ExpansionWidget extends StatelessWidget {
  final List<Category> categories;

  const ExpansionWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            padding: EdgeInsets.all(5),
            child: Center(
                child: Column(
              spacing: 5,
              children: [
                Expanded(
                  child: ClipRect(
                    child: Image.network(
                      GeneralWidgets.getNetworkImage(category.image),
                    ),
                  ),
                ),
                Text(category.name),
              ],
            )),
          );
        },
      ),
    );
  }
}
