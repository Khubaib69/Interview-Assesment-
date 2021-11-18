import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class list_of_all_weights extends StatefulWidget {
  const list_of_all_weights({Key? key}) : super(key: key);

  @override
  _list_of_all_weightsState createState() => _list_of_all_weightsState();
}

class _list_of_all_weightsState extends State<list_of_all_weights> {
  final _auth= FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;

  var userid;
  var currentuser= FirebaseAuth.instance.currentUser!.uid;


  // void Get_Users()async {
  //   await for (var snapshot in _firestore.collection('Users').orderBy('Time',descending: true).snapshots()) {
  //     for (var sale in snapshot.docs) {
  //       userid = sale.get('Userid');
  //       if (currentuser == userid) {
  //         print(sale.get('Time'));
  //         print(sale.get('Userid'));
  //         print(sale.get('Weight'));
  //       };
  //     }
  //   }
  // }

  void remove_entry(weight_to_delete,time_to_delete,userid_to_delete)async{
    await for (var snapshot in _firestore.collection('Users').snapshots()) {
          for (var sale in snapshot.docs) {
            userid = sale.get('Userid');
            var weight_delete = sale.get('Weight');
            var time_delete = sale.get('Time');
            if (currentuser == userid_to_delete && weight_to_delete==weight_delete && time_delete==time_to_delete) {
              print(sale.get('Time'));
              print(sale.get('Userid'));
              print(sale.get('Weight'));
              sale.reference.delete();
            };
          }
        }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('Users').orderBy('Time',descending: true).snapshots(),
            builder: (BuildContext context, snapshot) {
              List<weightbubble> weightlist=[];
               if(snapshot.hasData){
                 var list_of_weight=snapshot.data!.docs;
                 for(var weight in list_of_weight){
                   if(currentuser==weight.get('Userid')){
                     final weights=weight.get('Weight');
                     final time=weight.get('Time');
                     final userid=weight.get('Userid');


                     final weightBubble=weightbubble(weight: weights,time: time,userid: userid,);
                     weightlist.add(weightBubble);
                   }
                 }
               }
               return SingleChildScrollView(
                 child: Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                       // child: ListView(
                       //   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                         children: weightlist,
                       // ),
                      // ),
                   ),
                 ),
               );
            },
          )

            // FlatButton(
            // onPressed: (){
            //        Get_Users();
            //      // userid=null;
            //   },
            // child: Text('Press Me Daddy')),
        ],
      ),
          )),
    );
  }
}


class weightbubble extends StatelessWidget {
  weightbubble({this.weight,this.time,this.userid});
  final weight;
  final userid;
  final time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
              'Weight is $weight at \nTime $time',style: TextStyle(fontSize: 26,color: Colors.white),
            ),
              SizedBox(width: 80,),
              FlatButton(onPressed: (){
                var x =_list_of_all_weightsState();
                x.remove_entry(weight, time, userid);
                // print(weight);
                // print(time);
                // print(userid);
              }, child: Icon(Icons.delete,color: Colors.red,)),
            ],

          ),
        ),
      ),
    );
  }
}
