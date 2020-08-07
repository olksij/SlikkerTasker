import 'package:flutter/material.dart';

import 'material.dart';
import 'app.dart';

class FirstRun extends StatefulWidget { @override _FirstRunState createState() => _FirstRunState(); }

class _FirstRunState extends State<FirstRun> {
   
   var loggingIn = false;

   void localSetState(s) => this.setState(() => s());

   @override
   Widget build(BuildContext context) {
      return Scaffold(
         body: Center( child: Text("It's first run!") ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: Layer(
            accent: 240,
            corningStyle: CorningStyle.full,
            objectType: ObjectType.floating,
            child: loggingIn ? FutureBuilder(
               future: signIn(),
               builder: (context, user) {
                  if (user.hasData) {
                     Future.delayed(Duration(seconds: 1), () => Navigator.pushNamed(context, '/home'));
                     return Text(user.data.displayName.toString()); 
                  }
                  else return loggingIn ? SizedBox(
                     child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1F1F33)),
                     ),
                     height: 16,
                     width: 16,
                  ) : Text('Continue with Google $loggingIn');
               },
            )
            : Text('Continue with Google'),
            onTap: this.localSetState,
            onTapProp: () => loggingIn = true,
         ),
      );
   }
}
