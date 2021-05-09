import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:slikker_kit/slikker_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tasker/data/data.dart';

Color accentColor(double alpha, double hue, double saturation, double value) =>
    HSVColor.fromAHSV(alpha, hue, saturation, value).toColor();

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
      header: SlikkerCard(
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
      floatingButton: SlikkerCard(
        padding: EdgeInsets.fromLTRB(15, 15, 17, 15),
        accent: 240,
        borderRadius: BorderRadius.circular(54),
        child: loggingIn
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3D3D66)),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 22,
                    width: 22,
                    child: SvgPicture.asset(
                      "assets/google_logo.svg",
                      semanticsLabel: 'Google Logo',
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 12)),
                  Text('Sign in with Google', style: TextStyle(fontSize: 15)),
                ],
              ),
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
