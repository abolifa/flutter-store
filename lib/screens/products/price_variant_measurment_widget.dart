import 'package:app/models/product.dart';
import 'package:flutter/material.dart';

class PriceVariantMeasurementWidget extends StatelessWidget {
  final Product product;
  final ValueChanged<ProductVariant> onVariantSelected;

  const PriceVariantMeasurementWidget({
    super.key,
    required this.product,
    required this.onVariantSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price Text
        Text(
          'AED ${product.variants.first.price.toString()}',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Measurement Gesture
        GestureDetector(
          onTap: () {
            _showVariantBottomSheet(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade600,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Row(
              children: [
                // Measurement Text
                Text(
                  '${product.variants.first.unit.name} ${product.variants.first.measurement}',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Bottom Sheet for Variant Selection
  void _showVariantBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _VariantSelectorBottomSheet(
          variants: product.variants,
          onVariantSelected: onVariantSelected,
        );
      },
    );
  }
}

// Bottom Sheet Widget
class _VariantSelectorBottomSheet extends StatelessWidget {
  final List<ProductVariant> variants;
  final ValueChanged<ProductVariant> onVariantSelected;

  const _VariantSelectorBottomSheet({
    required this.variants,
    required this.onVariantSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 300,
      child: ListView.builder(
        itemCount: variants.length,
        itemBuilder: (context, index) {
          final variant = variants[index];
          return GestureDetector(
            onTap: () {
              onVariantSelected(variant);
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${variant.unit.name} ${variant.measurement}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'AED ${variant.price.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          Colors.green.shade700, // Highlight price with green
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
