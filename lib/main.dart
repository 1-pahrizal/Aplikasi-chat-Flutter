import 'package:appchat/helper/helper_function.dart';
import 'package:appchat/pages/auth/login_page.dart';
import 'package:appchat/pages/home_page.dart';
import 'package:appchat/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.appKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSingedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus() async {
      await HelperFunctions.getUserLoggedInStatus().then((value) {
        if (value != null) {
          setState(() {
            _isSingedIn = value;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Constants().primaryColor,
          scaffoldBackgroundColor: Colors.white),
      home: _isSingedIn ? const HomePage() : const LoginPage(),
    );
  }
}
