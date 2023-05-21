import 'dart:developer';

import 'package:contact_list_app/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cPasswordController.text.trim();

    if(email == '' || password == '' || cpassword == ''){
      log("please enter the details");
    }
    else if(password != cpassword){
      log("Password do not match");
    }
    else{
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null){
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch(e) {
        log(e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(45), bottomLeft: Radius.circular(45)),
                  child: Container(
                    padding: EdgeInsets.all(26),
                    alignment: Alignment.centerLeft,
                    height: 300,
                    width: double.maxFinite,
                    child: Text("WELCOME!",
                      style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlueAccent,
                          CupertinoColors.activeBlue
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(45), topLeft: Radius.circular(45)),
                  child: Container(
                    padding: EdgeInsets.all(26),
                    alignment: Alignment.centerLeft,
                    height: 500,
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SIGNUP",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("E-Mail",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      labelText: "Enter an email",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      labelText: "Enter a password",
                                      suffixIcon: Icon(Icons.remove_red_eye),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Confirm Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  controller: cPasswordController,
                                  decoration: InputDecoration(
                                      labelText: "Confirm password",
                                      suffixIcon: Icon(Icons.remove_red_eye),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            createAccount();
                          },
                          child: Container(
                            width: 450,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.lightBlueAccent,
                                    CupertinoColors.activeBlue,
                                  ]
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text("SIGNUP",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
