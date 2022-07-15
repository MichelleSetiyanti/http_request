import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String id, email, name;
  @override
  void initState() {
    id = "belum ada Id";
    email = "belum ada email";
    name = "belum ada Name";
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP GET"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Id : $id",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Email : $email",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Name : $name",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  var myresponse = await myhttp
                      .get(Uri.parse("https://reqres.in/api/users/3"));
                  if (myresponse.statusCode == 200) {
                    //berhasil get data
                    print("Berhasil Get Data");
                    var data =
                        json.decode(myresponse.body) as Map<String, dynamic>;
                    setState(() {
                      id = data["data"]["id"].toString();
                      email = data["data"]["email"].toString();
                      name =
                          ("${data["data"]["first_name"]} ${data["data"]["last_name"]}");
                      print(data["data"]);
                    });
                    // print(myresponse.body);
                  } else {
                    //tidak berhasil
                    // setState(() {
                    //   id = "ERROR ${myresponse.statusCode}";
                    // });
                    print("ERROR ${myresponse.statusCode}");
                  }
                  // print(myresponse.statusCode);
                  // print("-------------------");
                  // print(myresponse.headers);
                  // print("-------------------");
                  // print("-------------------");
                },
                child: Text("GET DATA")),
          ],
        ),
      ),
    );
  }
}
