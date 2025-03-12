import 'package:app/helpers/general_widgets.dart';
import 'package:app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryBubble extends StatefulWidget {
  final List<Category> categories;

  const CategoryBubble({super.key, required this.categories});

  @override
  State<CategoryBubble> createState() => _CategoryBubbleState();
}

class _CategoryBubbleState extends State<CategoryBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            spacing: 5,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        GeneralWidgets.getNetworkImage(
                          widget.categories[index].image,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                widget.categories[index].name,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          );
        },
      ),
    );
  }
}
