import 'package:flutter/material.dart';
import 'package:interview_assesment/weight_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var email;
var password;
final _auth= FirebaseAuth.instance;
final _firestore= FirebaseFirestore.instance;

class login_screen extends StatelessWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 30),),
              Center(child: Text('Login Screen',style: TextStyle(fontSize: 35),)),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 350,
                child:TextFormField(
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your email'),
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
                  var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(user!=null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => weight_screen()));
                  }
                  else{
                    Alert_box(context, 'Oops', 'Something Went Wrong!', 'login_screen');
                  }
                },
                child:Container(
                  child: const Text("  Log-In  ",style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
                color: Colors.blue,
                height: 50,

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              SizedBox(height: 20,),
            ],
          )
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