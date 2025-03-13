import 'package:app/providers/favorite_provider.dart';
import 'package:app/providers/product_provider.dart';
import 'package:app/screens/products/product_widget.dart';
import 'package:app/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    await context.read<FavoriteProvider>().loadFavorites();
    await _fetchProducts();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchProducts() async {
    final favoriteIds = context.read<FavoriteProvider>().favoriteProductIds;
    await context.read<ProductProvider>().fetchProductsByIds(favoriteIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: const Text('المفضلة'),
        centerTitle: true,
        closable: true,
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    final favoriteProducts = productProvider.products.values
                        .where((product) => favoriteProvider.favoriteProductIds
                            .contains(product.id))
                        .toList();

                    if (favoriteProducts.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: favoriteProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return SizedBox(
                          height: 200,
                          width: 200,
                          child: ProductWidget(product: product),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
