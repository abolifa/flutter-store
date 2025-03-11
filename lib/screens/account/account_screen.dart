import 'package:app/providers/auth_provider.dart';
import 'package:app/screens/account/widgets/account_footer.dart';
import 'package:app/screens/account/widgets/account_header.dart';
import 'package:app/screens/account/widgets/account_list.dart';
import 'package:app/screens/account/widgets/account_widget.dart';
import 'package:app/screens/account/widgets/main_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return authProvider.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 15,
                    children: [
                      const SizedBox(height: 10),
                      AccountHeader(),
                      if (authProvider.isAuthenticated) AccountWidget(),
                      MainBanner(),
                      if (authProvider.isAuthenticated) AccountList(),
                      AccountFooter(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
