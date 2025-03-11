import 'package:app/helpers/constant.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return authProvider.customer == null
        ? buildGuestHeader(context)
        : buildCustomerHeader(context);
  }

  Widget buildGuestHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: Column(
        spacing: 8,
        children: [
          Row(
            children: [
              Text(
                'هلا! مرحبا بك في متجرنا',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'منصة السوق الإلكتروني الرائدة محلياً',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: Button(
                  text: 'تسجيل الدخول',
                  onClick: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  borderRadius: 10,
                  color: Colors.grey.shade800,
                  icon: Icon(
                    Icons.person_2_rounded,
                    color: Colors.grey.shade600,
                    size: 15,
                  ),
                ),
              ),
              Expanded(
                child: Button(
                  text: 'انشاء حساب',
                  onClick: () {},
                  borderRadius: 10,
                  color: Colors.white,
                  textColor: Colors.grey.shade600,
                  borderColor: Colors.grey.shade700,
                  icon: Icon(
                    Icons.person_add_alt_1_rounded,
                    color: Colors.grey.shade600,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCustomerHeader(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            spacing: 15,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade500,
                ),
                padding: EdgeInsets.all(3),
                child: CircleAvatar(
                  backgroundImage: authProvider.isAuthenticated &&
                          authProvider.customer?.avatar != null
                      ? NetworkImage(
                          '${Constant.imageUrl}${authProvider.customer?.avatar}')
                      : NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحباً',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    authProvider.customer?.email ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.grey.shade800,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  elevation: 0,
                  minimumSize: Size(0, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'تعديل',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
