import 'package:flutter/material.dart';
import 'package:office_supply_mobile_master/config/router.dart';
import 'package:office_supply_mobile_master/controllers/cart_controller.dart';
import 'package:office_supply_mobile_master/controllers/google_sign_in_controller.dart';
import 'package:office_supply_mobile_master/pages/authenticated_users/employee/dashboard/employee_dashboard.dart';
import 'package:office_supply_mobile_master/pages/guest/sign_in/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInController(),
          child: const SignInPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartController(),
        ),
      ],
      child: MaterialApp(
        title: 'Sign In',
        initialRoute: mainRouter,
        routes: {
          mainRouter: (context) => const SignInPage(),
          employeeDashboardRouter: (context) => const EmployeeDashBoard(),
        },
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        //home: const SignInPage(),
      ),
    );
  }
}
