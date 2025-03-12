import 'package:app/helpers/colors.dart';
import 'package:app/helpers/route_generator.dart';
import 'package:app/providers/address_provider.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/favorite_provider.dart';
import 'package:app/providers/home_data_provider.dart';
import 'package:app/providers/section_product_provider.dart';
import 'package:app/screens/main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GeolocatorPlatform.instance.checkPermission();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => HomeDataProvider()),
        ChangeNotifierProvider(create: (_) => SectionProductProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        // ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: const Locale('ar'),
      supportedLocales: [
        const Locale('ar'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'NotoKufiArabic',
        useMaterial3: true,
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: ColorsPallete.scaffoldColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        dialogBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: MainHomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
