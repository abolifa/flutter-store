import 'package:app/models/address.dart';
import 'package:app/models/percation.dart';
import 'package:app/screens/account/address/addresses_screen.dart';
import 'package:app/screens/account/address/map_screen.dart';
import 'package:app/screens/account/address/new_address_screen.dart';
import 'package:app/screens/auth/login_screen.dart';
import 'package:app/screens/main_home_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainHomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/addresses':
        return MaterialPageRoute(builder: (_) => AddressesScreen());
      case '/new-address':
        if (args is Percation) {
          return MaterialPageRoute(
            builder: (_) => NewAddressScreen(selectedLocation: args),
          );
        } else if (args is Address) {
          return MaterialPageRoute(
            builder: (_) => NewAddressScreen(
              isEdit: true,
              address: args,
            ),
          );
        } else if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => NewAddressScreen(
              isEdit: true,
              address: args['address'],
            ),
          );
        }
        return _errorRoute();
      case '/new-address-map':
        return MaterialPageRoute(builder: (_) => MapScreen());
      default:
        return MaterialPageRoute(builder: (_) => MainHomeScreen());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Error: Route not found'),
        ),
      ),
    );
  }
}
