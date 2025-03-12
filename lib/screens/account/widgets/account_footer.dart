import 'package:app/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class AccountFooter extends StatelessWidget {
  const AccountFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final socials = [
      {
        "icon": LucideIcons.facebook,
        "color": Colors.blue,
      },
      {
        "icon": LucideIcons.twitter,
        "color": Colors.green,
      },
      {
        "icon": LucideIcons.instagram,
        "color": Colors.blueAccent,
      },
      {
        "icon": LucideIcons.linkedin,
        "color": Colors.red,
      }
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (authProvider.isAuthenticated)
          GestureDetector(
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('تنبيه'),
                  content: const Text('هل تريد تسجيل الخروج؟'),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () async {
                        await authProvider.logout();
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      isDestructiveAction: true,
                      child: const Text('نعم'),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('لا'),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.power,
                    size: 22,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'تسجيل خروج',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                'تواصل معنا',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800),
              ),
              const Divider(
                thickness: 0.5,
              ),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var social in socials)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade600,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          social["icon"] as IconData,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'شروط الإستخدام',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    ' . ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    'سياسة الخصوصية',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    ' . ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    'تواصل معنا',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '© 2025 جميع الحقوق محفوظة',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
