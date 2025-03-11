import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccountList extends StatelessWidget {
  const AccountList({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        "header": "حسابي",
        "items": [
          {
            "title": "الملف الشخصي",
            "icon": LucideIcons.user,
            "onTap": () {},
          },
          {
            "title": "العناوين",
            "icon": LucideIcons.mapPin,
            "onTap": () {
              Navigator.pushNamed(context, "/addresses");
            },
          },
          {
            "title": "الطلبات",
            "icon": LucideIcons.shoppingBag,
            "onTap": () {},
          },
        ],
      },
      {
        "header": "الإعدادات",
        "items": [
          {
            "title": "المفضلة",
            "icon": LucideIcons.heart,
            "onTap": () {},
          },
          {
            "title": "التقييمات",
            "icon": LucideIcons.star,
            "onTap": () {},
          },
        ],
      },
    ];

    return Column(
      spacing: 15,
      children: sections.map<Widget>((section) {
        List<Map<String, dynamic>> items =
            List<Map<String, dynamic>>.from(section["items"] as List);

        return Column(
          spacing: 10,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    section["header"] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(
                  thickness: 0.5,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: Icon(
                      item["icon"] as IconData,
                      size: 24,
                      color: Colors.black26,
                    ),
                    title: Text(
                      item["title"] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    trailing: Icon(
                      LucideIcons.chevronLeft,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    onTap: item["onTap"] as void Function()?,
                  );
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
