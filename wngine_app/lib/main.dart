import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wngine_app/Page/AdminPage.dart';
import 'package:wngine_app/Page/DeletePage.dart';
import 'package:wngine_app/Page/UpdatePage.dart';
import 'package:wngine_app/Page/DescPage.dart';
// import 'package:wngine_app/Page/DescPage.dart';

// import 'package:wngine_app/Page/GooglePage.dart';
import 'package:wngine_app/Page/InsertPage.dart';
import 'package:wngine_app/Page/LoginPage.dart';
import 'package:wngine_app/Page/SearchPage.dart';
import 'package:wngine_app/Page/SplashScreen.dart';
import 'package:wngine_app/Page/UsernamePage.dart';
import 'package:wngine_app/Page/HomePage.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(42, 42, 42, 0.992),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromARGB(255, 144, 4, 88),
          contentTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
          ),
        ),
        // primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: const AdminPage(),
      routes: <String, WidgetBuilder>{
        '/insertPage': (BuildContext context) => const InsertAdmin(),
        '/updatePage': (BuildContext context) => UpdatePage(),
        '/loginPage': (BuildContext context) => const LoginPage(),
        '/homePage': (BuildContext context) => const HomePage(),
        '/usernameRegist': (BuildContext context) => const RegisterPage(),
        '/searchPage': (BuildContext context) => SearchPage(),
        '/descriptions': (BuildContext context) => const Descriptions(),
        '/splashScreen': (BuildContext context) => const SplashScreen(),
        '/adminPage': (BuildContext context) => const AdminPage(),
        '/deletePage': (BuildContext context) => DeletePage(),
      },
    );
  }
}

class DescriptionsPage {
  const DescriptionsPage();
}
