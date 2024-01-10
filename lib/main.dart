import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/controller/platform_provider.dart';
import 'package:platformconverter/controller/theme_provider.dart';
import 'package:platformconverter/view/android/home_page.dart';
import 'package:platformconverter/view/ios/Ios_home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool appTheme = prefs.getBool('AppTheme') ?? false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatformProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),

        ChangeNotifierProvider(
          create: (context) => ThemeProvider()..getTheme(),
        ),
      ],

      builder: (context, child) {

        return Consumer2<PlatformProvider,ThemeProvider>(
          builder: (context, platformProvider,themeprovider, child) {
            if (platformProvider.isAndroid == false) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Android_home(),
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeprovider.thememode,
              );
            } else {
              return Consumer<ThemeProvider>(
                  builder: (context, themeprovider, child) {
                    return CupertinoApp(
                      debugShowCheckedModeBanner: false,
                      home: Home(),
                      theme:CupertinoThemeData(
                          brightness: themeprovider.currentTheme
                              ? Brightness.dark
                              : Brightness.light),
                    );
                  });
            }
          },
        );
      },
    );
  }
}
