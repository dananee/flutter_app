import 'package:flutter_app/Methods.dart';
import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import 'HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  var myEmail;
  var myPhone;
  var myName;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
          backgroundColor: Colors.green,
        ),
        body: isLoading
            ? Center(
                child: Container(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 8,
                    ),
                    Container(
                      height: 160,
                      width: 180,
                      child: Image.asset('assets/logo.png'),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Container(
                        width: size.width / 1.1,
                        child: FutureBuilder(
                          future: _fetch(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done)
                              return Text("Profile Details...",
                                  textAlign: TextAlign.center);
                            return Text("Profile Details",
                                textAlign: TextAlign.center);
                          },
                        )),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: TextFormField(
                          controller: _name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "$myName",
                          ),
                        )),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "$myEmail",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "$myPhone",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    customButton(size),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        drawer: NavDrawer());
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        print("hiiii");
        FirebaseFirestore _firestore1 = FirebaseFirestore.instance;
        if (_name.text.isNotEmpty) {
          _firestore1
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .update({"name": _name.text});
        }
        if (_email.text.isNotEmpty) {
          _firestore1
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .update({"email": _email.text});
        }
        if (_phone.text.isNotEmpty) {
          _firestore1
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .update({"phone": _phone.text});
        }
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Modifications made with success !")));
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.green,
          ),
          alignment: Alignment.center,
          child: Text(
            "Save Changes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  _fetch() async {
    FirebaseFirestore _firestore3 = FirebaseFirestore.instance;
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      print("null");
    } else {
      print('gggg');
      print(FirebaseAuth.instance.currentUser?.uid);
      await _firestore3
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((ds) {
        myEmail = ds['email'];
        myName = ds['name'];
        myPhone = ds['phone'];
        print(ds);
        print(myName);

        setState(() {
          isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    }
  }
}
