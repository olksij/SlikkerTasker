import 'package:flutter/material.dart';

import 'slikker.dart';
import 'data.dart';

class FirstRun extends StatefulWidget { @override _FirstRunState createState() => _FirstRunState(); }

class _FirstRunState extends State<FirstRun> {
   
   var loggingIn = false;

   void localSetState(s) => this.setState(() => s());

   @override
   Widget build(BuildContext context) {
      return Scaffold(
         body: Center( child: Text("It's first run!") ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
         floatingActionButton: SlikkerCard(
            padding: EdgeInsets.all(15),
            accent: 240,
            borderRadius: BorderRadius.circular(54),
            child: loggingIn ? FutureBuilder(
               future: signIn(),
               builder: (context, user) {
                  if (user.hasData) {
                     Future.delayed(Duration(seconds: 1), () => Navigator.pushNamed(context, '/home'));
                     return Text(user.data.displayName.toString()); 
                  }
                  else return SizedBox(
                     child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3D3D66)),
                     ),
                     height: 16,
                     width: 16,
                  );
               },
            )
            : Text('Continue with Google'),
            onTap: () => this.setState(() => loggingIn = true),
         ),
      );
   }
}
