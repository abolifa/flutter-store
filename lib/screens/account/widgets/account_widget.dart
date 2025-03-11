import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccountWidget extends StatelessWidget {
  AccountWidget({super.key});

  final list = [
    {
      "title": "الطلبات",
      "subtitle": "إدارة وتتبع",
      "icon": LucideIcons.shoppingBag,
    },
    {
      "title": "المرتجعات",
      "subtitle": "0 قيد المراجعة",
      "icon": LucideIcons.refreshCw,
    },
    {
      "title": "التقييمات",
      "subtitle": "0 منتج",
      "icon": LucideIcons.star,
    },
    {
      "title": "المفضلة",
      "subtitle": "0 منتج",
      "icon": LucideIcons.heart,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.6,
        ),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.all(20),
            child: Row(
              spacing: 15,
              children: [
                Icon(
                  list[index]["icon"] as IconData,
                  size: 25,
                  color: Colors.grey.shade600,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text(
                      list[index]["title"] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      list[index]["subtitle"] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
