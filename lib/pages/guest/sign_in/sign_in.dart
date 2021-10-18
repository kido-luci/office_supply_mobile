import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/controllers/google_sign_in_controller.dart';
import 'package:office_supply_mobile_master/pages/guest/widgets/background.dart';
import 'package:office_supply_mobile_master/widgets/rounded_input_field.dart';
import 'package:office_supply_mobile_master/widgets/rounded_password_field.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Background(size: _size),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                  parent: NeverScrollableScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                          color: primaryColor),
                    ),
                  ),
                  SvgPicture.asset(
                    iconPath + loginSvg,
                    height: _size.height * 0.3,
                  ),
                  RoundedInputField(
                    hintText: "Email",
                    onChanged: (value) {},
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {},
                  ),
                  SignInButtonBuilder(
                    backgroundColor: primaryColor,
                    onPressed: () {},
                    text: 'Sign in with Account',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.54),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 70,
                          child: Divider(
                            color: Color.fromRGBO(0, 0, 0, 0.54),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'or',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 1,
                              color: Color.fromRGBO(0, 0, 0, 0.54),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Divider(
                            color: Color.fromRGBO(0, 0, 0, 0.54),
                          ),
                        )
                      ],
                    ),
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      signIn();
                    },
                  ),
                  SignInButton(
                    Buttons.Facebook,
                    onPressed: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.54),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  signIn() async {
    try {
      await Provider.of<GoogleSignInController>(context, listen: false)
          .signIn();
      if (Provider.of<GoogleSignInController>(context, listen: false)
              .googleSignInAccount !=
          null) {
        Navigator.of(context).pushReplacementNamed('/employee_dashboard');
      }
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('error: ${e.toString()}');
    } catch (e) {
      // ignore: avoid_print
      print('error: ${e.toString()}');
    }
  }
}
