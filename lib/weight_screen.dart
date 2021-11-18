import 'package:flutter/material.dart';
import 'package:interview_assesment/list_of_all_weights.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class weight_screen extends StatefulWidget {
  const weight_screen({Key? key}) : super(key: key);

  @override
  _weight_screenState createState() => _weight_screenState();
}



class _weight_screenState extends State<weight_screen> {

  // void initState() {
  //   // TODO: implement initState
  //   dynamic currentTime = DateFormat.jm().format(DateTime.now());
  // }
  var weight;
  var auth= FirebaseAuth.instance.currentUser!.uid;
  final _firestore= FirebaseFirestore.instance;

    // final uid = user.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),),
            Center(child: Text('Weight Screen',style: TextStyle(fontSize: 35),)),
            SizedBox(height: 40,),
            Container(
              width: 340,
              child: TextField(
                onChanged: (value){
                  weight=value;
                },
                keyboardType:TextInputType.number,
                decoration: InputDecoration(
                  focusColor: Colors.blue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.black38,),
                    hintText: "Enter You Weight In Kg",
                    fillColor: Colors.white70),
              ),
            ),
            SizedBox(height: 30,),
            FlatButton(
              onPressed: ()async {
                dynamic currentTime = DateFormat.jm().format(DateTime.now());
                if(weight!=null){
                  await _firestore.collection('Users').doc().set({
                    'Weight':weight,
                    'Time':currentTime,
                    'Userid':auth,
                  });
                }
                print(currentTime);
                print(weight);
                print(auth);
                weight=0;
                auth=null.toString();
                Navigator.push(context, MaterialPageRoute(builder: (context) => weight_screen()));
              },
              child:Container(
                child: const Text(" Submit ",style: TextStyle(color: Colors.white70,fontSize: 20),),
              ),
              color: Colors.blue,
              height: 45,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            SizedBox(height: 20,),
            FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => list_of_all_weights()));
              },
              child:Container(
                child: const Text("View The List Of All Weights",style: TextStyle(color: Colors.white70,fontSize: 20),),
              ),
              color: Colors.blue,
              height: 45,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ],
        ),
      ),
    );
  }
}
