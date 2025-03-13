import 'package:app/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class MainScreenSearchWidget extends StatelessWidget {
  const MainScreenSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Row(
      spacing: 6,
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.zero,
                hintText: 'ابحث عن ما تحتاجه',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                suffixIcon: const Icon(
                  LucideIcons.camera,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/favorite');
          },
          child: Stack(
            clipBehavior: Clip.none, // Allows for overflow
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade400,
                  ),
                ),
                child: Icon(
                  LucideIcons.heart,
                  size: 20,
                  color: Colors.grey.shade400,
                ),
              ),
              if (favoriteProvider.favoriteProductIds.isNotEmpty)
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '${favoriteProvider.favoriteProductIds.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
