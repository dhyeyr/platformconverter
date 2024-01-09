// import 'package:flutter/material.dart';
// import 'package:platformconverter/view/android/add_contant.dart';
// import 'package:platformconverter/view/android/call_page.dart';
// import 'package:platformconverter/view/android/chat_page.dart';
// import 'package:platformconverter/view/android/setting_page.dart';
// import 'view/android/home_page.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // home: HomeScreen(),
//       routes: {
//         "/": (context) =>Android_home(),
//         "ContactSave": (context) =>Add_contact(),
//         "ContactSave": (context) =>Chat_page(),
//         "ContactSave": (context) =>Settings(),
//         "ContactSave": (context) =>Call_page(),
//
//       },
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconverter/controller/contactprovider.dart';
import 'package:platformconverter/controller/platform_provider.dart';
import 'package:platformconverter/controller/theme_provider.dart';
import 'package:platformconverter/view/android/add_contant.dart';
import 'package:platformconverter/view/android/call_Page.dart';
import 'package:platformconverter/view/android/home_page.dart';
import 'package:platformconverter/view/android/setting_page.dart';
import 'package:platformconverter/view/ios/Ios_home.dart';
import 'package:platformconverter/view/ios/profile_ios.dart';
import 'package:platformconverter/view/theme/dark.dart';
import 'package:platformconverter/view/theme/light.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [

          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()..gettheme(),
          ),

          ChangeNotifierProvider(
            create: (context) {
              return ContactProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (context) => PlatformProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ContactProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
        ],


        builder: (context, child) {
          return Consumer<ThemeProvider>(
            builder: (BuildContext context, theme, Widget? child) {
              var ios = Provider.of<PlatformProvider>(context).isIos;
              if (ios) {
                return MaterialApp(
                  initialRoute: "/",
                  debugShowCheckedModeBanner: false,
                  theme: light,
                  darkTheme: dark,

                  routes: {
                    "/": (context) => const Android_home(),
                    "AddContact": (context) => const Add_contact(),
                    "Settings": (context) => Settings(),

                  },
                );
              } else {
                return Consumer<ThemeProvider>(
                  builder: (BuildContext context, theme, Widget? child) {
                    return CupertinoApp(
                      initialRoute: '/',
                      debugShowCheckedModeBanner: false,
                      theme: CupertinoThemeData(
                          brightness:
                          theme.isDark ? Brightness.dark : Brightness.light),
                      // home: Home(),
                      routes: {
                        "/": (p0) => Home(),
                        "Profile": (p0) => Profile(),

                      },
                    );
                  },
                );
              }
            },
          );



          // if (isAndroid) {
          //   return MaterialApp(
          //
          //     theme: light,
          //       darkTheme: dark,
          //       debugShowCheckedModeBanner: false,
          //        themeMode: Provider.of<ThemeProvider>(context).isDark ? ThemeMode.dark : ThemeMode.light,
          //       // themeMode: ThemeMode.system,
          //
          //     initialRoute: '/',
          //     routes: {
          //       '/': (context) => Android_home(),
          //       'chatpage': (context) => Add_contact(),
          //       'settings': (context) => Settings()
          //     },
          //   );
          // } else {
          //    return Consumer<ThemeProvider>(
          //      builder: (BuildContext context, theme, Widget? child) {
          //        return CupertinoApp(
          //          initialRoute: '/',
          //          debugShowCheckedModeBanner: false,
          //          theme: CupertinoThemeData(
          //              brightness:
          //              theme.isDark ? Brightness.dark : Brightness.light),
          //          // home: Home(),
          //          routes: {
          //            "/": (p0) => Home(),
          //             "Profile": (p0) => Profile(),
          //            // "NextPage": (p0) => NextPage(),
          //          },
          //        );
          //      },
          //    );





        });
  }
}

