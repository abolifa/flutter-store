import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final int productId;

  const FavoriteButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(productId);

    return GestureDetector(
      onTap: () => {
        if (authProvider.isAuthenticated)
          {favoriteProvider.toggleFavorite(productId)}
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('يجب تسجيل الدخول أولاً'),
              ),
            ),
            Navigator.pushNamed(context, '/login'),
          }
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }
}
