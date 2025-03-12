import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainScreenSearchWidget extends StatelessWidget {
  const MainScreenSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(5),
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
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
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
      ],
    );
  }
}
