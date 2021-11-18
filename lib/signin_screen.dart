import 'package:flutter/material.dart';
import 'package:interview_assesment/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
var email;
var password;


final _auth= FirebaseAuth.instance;
final _firestore= FirebaseFirestore.instance;


class signin_screen extends StatelessWidget {
  const signin_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),),
            Center(child: Text('Signin Screen',style: TextStyle(fontSize: 35),)),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 350,
              child:TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Email'),
                onChanged: (value1){
                  email=value1;
                  // print(name);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 350,
              child:TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your Password'),
                onChanged: (value2){
                  password=value2;
                  // print(password);
                },
              ),
            ),
            SizedBox(height: 20,),
            FlatButton(
              onPressed: ()async{
                print(email);
                print(password);
                try{
                  var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if(user!=null){
                    _firestore.collection('Managers').doc(user.user!.uid).set({
                      'Name':email,
                      'Password':password,
                    });
                    Alert_box(context, "Alert!", 'Your Account Has Been Created Log In Now', 'login_screen');
                  }
                }
                catch(e){Alert_box(context,'Oops','Something Went Wrong','signin_screen');};
              },
              child:Container(
                child: const Text("  Sign-In  ",style: TextStyle(color: Colors.white70,fontSize: 20),),
              ),
              color: Colors.blue,
              height: 50,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            SizedBox(height: 20,),
            FlatButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => login_screen()));
            },
              padding: EdgeInsets.symmetric(horizontal: 60,vertical: 10),
              child: const Text('Already Have An Account? Log In',style: TextStyle(color: Colors.white,fontSize: 15),),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

void Alert_box(context,alert,message,page_loc){
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, '$page_loc');
    },
  );

  var alertDialog= AlertDialog(
    title: Text('$alert!'),
    content:Text("$message"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context){
      return alertDialog;
    },
  );
}