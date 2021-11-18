import 'package:flutter/material.dart';
import 'package:interview_assesment/login_screen.dart';
import 'package:interview_assesment/signin_screen.dart';

class main_screen extends StatelessWidget {
  const main_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),),
            Center(child: Text('Main Screen',style: TextStyle(fontSize: 35),)),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => login_screen()));
              },
              child:Container(
                child: const Text("  Log-In  ",style: TextStyle(color: Colors.white,fontSize: 30),),
              ),
              color: Colors.orange,
              height: 120,
              minWidth: 320,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => signin_screen()));
              },
              child:Container(
                child: const Text("  Sign-In  ",style: TextStyle(color: Colors.white,fontSize: 30),),
              ),
              color: Colors.blue,
              height: 120,
              minWidth: 320,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ],
        ),
      ),
    );
  }
}
