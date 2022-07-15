import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

void main() {
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
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  late String hasilResponseNama;
  late String hasilResponseJob;

  @override
  void initState() {
    hasilResponseNama = "Belum Ada Data";
    hasilResponseJob = "Belum Ada Data";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP POST"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: jobC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Job",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              var response = await myhttp.post(
                  Uri.parse("https://reqres.in/api/users"),
                  body: {"name": nameC.text, "job": jobC.text});

              Map<String, dynamic> data =
                  json.decode(response.body) as Map<String, dynamic>;

              setState(() {
                hasilResponseNama = data["name"];
                hasilResponseJob = "${data["job"]}";
              });
            },
            child: Text("POST"),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(height: 20),
          Divider(color: Colors.grey),
          SizedBox(height: 10),
          Text(hasilResponseNama),
          Text(hasilResponseJob),
        ],
      ),
    );
  }
}
