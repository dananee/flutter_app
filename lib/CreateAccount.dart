import 'package:flutter_app/Contacts.dart';
import 'package:flutter_app/Methods.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool _isObscure = true;

    return Scaffold(
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
                    child: Text(
                      "Create Account to continue !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Name", Icons.account_box, _name),
                    ),
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "email", Icons.account_box, _email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: TextField(
                        obscureText: _isObscure,
                        controller: _password,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.account_box),
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                })),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "phone", Icons.phone, _phone),
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
                        "You already have an account ? Login now",
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
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          createAccount(_name.text, _email.text, _password.text, _phone.text)
              .then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Contacts()));
              print("Account Created Sucessfull");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Account created with success !")));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please enter Fields");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please enter all Fields !")));
        }
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
            "Create Account",
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
}
