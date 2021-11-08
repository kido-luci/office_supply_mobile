import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:office_supply_mobile_master/config/paths.dart';
import 'package:office_supply_mobile_master/config/router.dart';
import 'package:office_supply_mobile_master/config/themes.dart';
import 'package:office_supply_mobile_master/pages/guest/sign_in/widgets/background.dart';
import 'package:office_supply_mobile_master/providers/sign_in.dart';
import 'package:office_supply_mobile_master/services/messaging.dart';
import 'package:office_supply_mobile_master/widgets/loading_ui.dart';
import 'package:office_supply_mobile_master/widgets/rounded_input_field.dart';
import 'package:office_supply_mobile_master/widgets/rounded_password_field.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isAwaitingSignedIn = false;
  late SignInProvider signInProvider;

  final MessagingService _messagingService = MessagingService.instance;

  late String userDevice;

  @override
  void initState() {
    super.initState();
    setupMessaging();
    signInProvider = Provider.of<SignInProvider>(context, listen: false);

    isSignedIn();
  }

  Future<void> setupMessaging() async {
    await _messagingService.initialize();
    userDevice = _messagingService.userDeviceToken;
  }

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
            ),
            Visibility(
              visible: isAwaitingSignedIn,
              child: const LoadingUI(),
            ),
          ],
        ),
      ),
    );
  }

  isSignedIn() async =>
      await signInProvider.isSignedIn() ? signIn.call() : () {};

  signIn() async {
    try {
      setState(() {
        isAwaitingSignedIn = true;
      });
      await signInProvider.signIn(userDevice);

      switch (signInProvider.user!.roleID) {
        case 1:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignInPage()),
          );
          await signInProvider.signOut();

          break;
        case 2:
          Navigator.of(context).pushReplacementNamed(listPeriodRouter);
          break;
        case 3:
          Navigator.of(context).pushReplacementNamed(leaderDashboardRouter);
          break;
        case 4:
          Navigator.of(context).pushReplacementNamed(employeeDashboardRouter);
          break;
        case 5:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignInPage()),
          );
          await signInProvider.signOut();

          break;
      }
    } catch (e) {
      await signInProvider.signOut();

      setState(() {
        isAwaitingSignedIn = false;
      });
    }
  }
}
