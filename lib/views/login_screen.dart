import 'dart:developer';
import 'package:contact_list_app/views/home_page.dart';
import 'package:contact_list_app/views/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email == '' || password == ''){
      log("please enter the details");
    }
    else{
      try{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
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
                        Text("LOGIN",
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
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            login();
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
                            child: Text("LOGIN",
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
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Text("Create a new Account!")
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
