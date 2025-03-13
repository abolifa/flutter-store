import 'package:app/helpers/general_widgets.dart';
import 'package:app/models/product.dart';
import 'package:app/screens/products/add_to_cart_button.dart';
import 'package:app/screens/products/favorite_button.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  ProductWidgetState createState() => ProductWidgetState();
}

class ProductWidgetState extends State<ProductWidget> {
  late Product _currentProduct;

  @override
  void initState() {
    super.initState();
    _currentProduct = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        spacing: 6,
        children: [
          Stack(
            children: [
              ClipRect(
                child: Image.network(
                  GeneralWidgets.getNetworkImage(_currentProduct.image),
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 180,
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: FavoriteButton(
                  productId: _currentProduct.id,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                _currentProduct.brand.name,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          Text(
            _currentProduct.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              GeneralWidgets.getProductPrice(
                _currentProduct.variants.first.price,
                _currentProduct.variants.first.discount,
              ),
            ],
          ),
          Spacer(),
          AddToCartButton(),
        ],
      ),
    );
  }
}
