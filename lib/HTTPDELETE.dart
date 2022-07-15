import 'dart:convert';
import 'dart:io';

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

  late String data;
  @override
  void initState() {
    data = "Belum Ada data";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP DELETE"),
        actions: [
          IconButton(
            onPressed: () async {
              var response =
                  await myhttp.get(Uri.parse("https://reqres.in/api/users/2"));
              Map<String, dynamic> mybody = json.decode(response.body);
              print(mybody);
              setState(() {
                data =
                    "Akun ${mybody["data"]["first_name"]} ${mybody["data"]["last_name"]}";
              });
            },
            icon: Icon(Icons.get_app),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(data),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              var response = await myhttp
                  .delete(Uri.parse("https://reqres.in/api/users/2"));
              // Map<String, dynamic> mybody = json.decode(response.body);
              // print(response.statusCode);
              if (response.statusCode == 204) {
                setState(() {
                  data = "Berhasil Menghapus data";
                });
              }
            },
            child: Text("HAPUS"),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      ),
    );
  }
}
