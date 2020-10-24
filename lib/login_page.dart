import 'package:flutter/material.dart';

import 'package:tasker/data.dart';
import 'package:tasker/reusable/slikker.dart';

class FirstRun extends StatefulWidget { @override _FirstRunState createState() => _FirstRunState(); }

class _FirstRunState extends State<FirstRun> {
   
   bool loggingIn;

   @override void initState() {
      super.initState();
      loggingIn = false;
   }

   @override Widget build(BuildContext context) {
      return Material(
         child:Stack(
            children: [
               Center(
                  child: Text('Welcome', 
                     style: TextStyle(fontSize: 36.0), 
                     textAlign: TextAlign.center,
                  ),
               ),
               Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                     padding: EdgeInsets.only(bottom: 30),
                     child: SlikkerCard(
                        padding: EdgeInsets.all(15),
                        accent: 240,
                        borderRadius: BorderRadius.circular(54),
                        child: loggingIn ? SizedBox(
                           child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3D3D66)),
                           ),
                           height: 16,
                           width: 16,
                        ) : Text('Continue with Google'),
                        onTap: () {
                           setState(() => loggingIn = true);
                           signIn(silently: false)
                           .then((value) { 
                              if (value) Navigator.pushNamed(context, '/home');
                              else setState(() => loggingIn = false);
                           });
                        },
                     ),
                  )
               )
            ] 
         )
      );
   }
}
