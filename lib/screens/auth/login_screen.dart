import 'package:app/providers/address_provider.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/favorite_provider.dart';
import 'package:app/providers/home_data_provider.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/banner.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'هلا! لنبدأ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Input(
                    controller: emailController,
                    isPassword: false,
                    hintText: 'الرجاء إدخال البريد الالكتروني',
                    fontSize: 13,
                    borderRadius: 10,
                  ),
                  const SizedBox(height: 15),
                  Input(
                    controller: passwordController,
                    isPassword: true,
                    hintText: 'الرجاء إدخال كلمة المرور',
                    fontSize: 13,
                    borderRadius: 10,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    text: 'تسجيل دخول',
                    isLoading: authProvider.isLoading,
                    onClick: () async {
                      bool success = await authProvider.login(
                        emailController.text,
                        passwordController.text,
                      );

                      if (success && context.mounted) {
                        context.read<AddressProvider>().fetchAddresses();
                        context.read<FavoriteProvider>().loadFavorites();
                        context.read<HomeDataProvider>().fetchHomeData();
                        Navigator.pop(context);
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                authProvider.errorMessage ??
                                    'خطاء في تسجيل الدخول',
                              ),
                            ),
                          );
                        }
                      }
                    },
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
