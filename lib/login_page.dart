import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tasker/data.dart';
import 'package:tasker/slikker.dart';

class FirstRun extends StatefulWidget {
  @override
  _FirstRunState createState() => _FirstRunState();
}

class _FirstRunState extends State<FirstRun> {
  late bool loggingIn;

  @override
  void initState() {
    super.initState();
    loggingIn = false;
  }

  @override
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      title: 'Tasker',
      topButton: TopButton.hidden(),
      header: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SlikkerCard(
          accent: 240,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Make sure you agree with ',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  color: accentColor(0.6, 240, 0.4, 0.4),
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launch(
                          'https://github.com/AlexBesida/SlikkerTasker/blob/master/PRIVACY.md'),
                    text: 'Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //decoration: TextDecoration.underline,
                      color: accentColor(1, 240, 0.6, 1),
                      fontFamily: 'Manrope',
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      color: accentColor(0.6, 240, 0.4, 0.4),
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launch(
                          'https://github.com/AlexBesida/SlikkerTasker/blob/master/TERMS.md'),
                    text: 'Terms & Conditions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //decoration: TextDecoration.underline,
                      color: accentColor(1, 240, 0.6, 1),
                      fontFamily: 'Manrope',
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '.',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      color: accentColor(0.6, 240, 0.4, 0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isFloating: false,
        ),
      ),
      content: Container(),
      floatingButton: SlikkerCard(
        padding: EdgeInsets.all(15),
        accent: 240,
        borderRadius: BorderRadius.circular(54),
        child: loggingIn
            ? SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3D3D66)),
                ),
                height: 16,
                width: 16,
              )
            : Text('Continue with Google'),
        onTap: () {
          setState(() => loggingIn = true);
          signIn(silently: false).then((value) {
            if (value)
              Navigator.pushNamed(context, '/home');
            else
              setState(() => loggingIn = false);
          });
        },
      ),
    );
  }
}
