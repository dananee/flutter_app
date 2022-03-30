import 'package:flutter_app/Contacts.dart';
import 'package:flutter_app/Methods.dart';
import 'package:flutter/material.dart';
import 'NavDrawer.dart';
import 'HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class editcontact extends StatefulWidget {
  DocumentSnapshot docid;
  editcontact({required this.docid});
  @override
  _editcontactState createState() => _editcontactState();
}

class _editcontactState extends State<editcontact> {
  var myService;
  var myPhone;
  var myName;
  var myEmail;
  var Myadress;
  var Id;
  @override
  void initState() {
    myName = TextEditingController(text: widget.docid.get('name'));
    myService = TextEditingController(text: widget.docid.get('service'));
    myPhone = TextEditingController(text: widget.docid.get('phone'));
    Myadress = TextEditingController(text: widget.docid.get('address'));
    myEmail = TextEditingController(text: widget.docid.get('email'));

    Id = TextEditingController(text: widget.docid.id);

    super.initState();
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _service = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _adresse = TextEditingController();

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
                      height: size.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            color: Colors.white,
                            child: IconButton(
                              onPressed: () => launch("tel://myPhone.text"),
                              icon: Icon(
                                Icons.add_ic_call,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            color: Colors.white,
                            child: IconButton(
                              onPressed: () => {
                                Share.share("Voici l'addresse de " +
                                    myName.text +
                                    ": " +
                                    Myadress.text)
                              },
                              icon: Icon(
                                Icons.location_searching,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            color: Colors.white,
                            child: IconButton(
                              onPressed: () => launch("mailto:" + myEmail.text),
                              icon: Icon(
                                Icons.attach_email_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        width: size.width / 1.6,
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
                            hintText: myName.text,
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
                          controller: _service,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: myService.text,
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
                            hintText: myPhone.text,
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
                          controller: _email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: myEmail.text,
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
                          controller: _adresse,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: Myadress.text,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    customButton(size),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    customButton1(size),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    customButton3(size),
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
        FirebaseFirestore _firestore1 = FirebaseFirestore.instance;
        if (_name.text.isNotEmpty) {
          _firestore1
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("contacts")
              .doc(Id.text)
              .update({
            "name": _name.text,
          });
        }
        if (_phone.text.isNotEmpty) {
          _firestore1
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("contacts")
              .doc(Id.text)
              .update({
            "phone": _phone.text,
          });
        }
        if (_email.text.isNotEmpty) {
          _firestore1
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("contacts")
              .doc(Id.text)
              .update({
            "email": _email.text,
          });
        }
        if (_adresse.text.isNotEmpty) {
          _firestore1
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("contacts")
              .doc(Id.text)
              .update({
            "address": _adresse.text,
          });
        }
        if (_service.text.isNotEmpty) {
          _firestore1
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("contacts")
              .doc(Id.text)
              .update({
            "service": _service.text,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Modifications made with success !")));
      },
      child: Container(
          height: size.height / 18,
          width: size.width / 1.4,
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

  Widget customButton1(Size size) {
    return GestureDetector(
      onTap: () {
        FirebaseFirestore _firestore1 = FirebaseFirestore.instance;
        _firestore1
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("contacts")
            .doc(Id.text)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User Deleted with success !")));
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => Contacts()));
      },
      child: Container(
          height: size.height / 18,
          width: size.width / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.orange,
          ),
          alignment: Alignment.center,
          child: Text(
            "Delete Contact ",
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

  void _shareContent() {
    Share.share("hiiiiii");
  }

  Widget customButton3(Size size) {
    return GestureDetector(
      onTap: () {
        Share.share("Voici le numero de tele de Monsieur " +
            myName.text +
            "Service :  " +
            myService.text +
            "  :  " +
            myPhone.text);

        //* launch("tel://214324234");
      },
      child: Container(
          height: size.height / 18,
          width: size.width / 1.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blueAccent,
          ),
          alignment: Alignment.center,
          child: Text(
            "Partager",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  _fetch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    if (FirebaseAuth.instance.currentUser?.uid == null) {
    } else {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("contacts")
          .doc(Id)
          .get()
          .then((ds) {
        setState(() {
          isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    }
  }
}
