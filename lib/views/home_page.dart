import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  void saveData() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    nameController.clear();
    numberController.clear();

    if (name != '' && number != '') {
      Map<String, dynamic> userData = {
        "name": name,
        "number": number
      };
      FirebaseFirestore.instance.collection("contacts").add(userData);
    }
    else {
      log("fill the details");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Contact Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )
                  )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  hintText: "Contact Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )
                  )
              ),
            ),
            SizedBox(
              height: 15,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  saveData();
                }, child: Text("SAVE")),

              ],
            ),
            SizedBox(height: 10,),

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('contacts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> userMap = snapshot.data!
                                  .docs[index].data() as Map<String, dynamic>;

                              return ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userMap["name"]),
                                    Text(userMap["number"]),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 70,
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            var docId = snapshot.data!.docs[index].id;
                                              setState(() {
                                                FirebaseFirestore.instance
                                                    .collection("contacts").doc(
                                                    docId).update({
                                                  "name": nameController.text,
                                                  "number": numberController.text,
                                                });
                                              });
                                              nameController.clear();
                                              numberController.clear();
                                          },
                                          child: Icon(Icons.edit)),
                                        SizedBox(width: 10,),
                                      InkWell(
                                          onTap: () {
                                            var docId = snapshot.data!.docs[index].id;
                                            FirebaseFirestore.instance.collection("contacts").doc(docId).delete();
                                          },
                                          child: Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                      );
                    }
                    else {
                      return const Text("No Data!");
                    }
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}

