import 'package:flutter_app/Methods.dart';
import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import 'HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Contacts.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _service = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Add new Contact"),
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
                      height: size.height / 20,
                    ),
                    Container(
                      height: 120,
                      width: 140,
                      child: Image.asset('assets/logo.png'),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Container(
                        width: size.width / 1.1,
                        child: Text("Please enter the following details")),
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
                              hintText: "Enter the name"),
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
                          controller: _service,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter the service"),
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
                              hintText: "Enter the phone"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
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
                              hintText: "Enter the email"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _address,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter the address"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore _firestore6 =
                            FirebaseFirestore.instance;
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        print("we are here");
                        _firestore6
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('contacts')
                            .add({
                          "name": _name.text,
                          "service": _service.text,
                          "phone": _phone.text,
                          "email": _email.text,
                          "address": _address.text,
                          "uid": _phone.text,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Contact added with success !")));

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Contacts()));

                        print('pressedddeeeeeeed0');
                      },
                      child: Text("Add new contact"),
                    ),
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

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Contact added with success !")));
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

  _create() async {}
}
