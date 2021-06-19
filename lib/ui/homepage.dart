import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _offset = 0;
  String _search = "";
  Future<Map> _getGifs() async {
    http.Response response;

    if (_search.isEmpty) {
      response = await http.get(
        Uri.https('api.giphy.com', '/v1/gifs/trending', {
          'api_key': 'BFAoH2iVvSGVsATTWMkNax2Fs1YW5rzR',
          'limit': '25',
          'rating': 'g'
        }),
      );
    } else {
      response = await http.get(Uri.https('api.giphy.com', '/v1/gifs/search', {
        'api_key': 'BFAoH2iVvSGVsATTWMkNax2Fs1YW5rzR',
        'q': _search,
        'limit': '25',
        'offset': _offset,
        'rating': 'g',
        'lang': 'en'
      }));
    }
    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGifs().then((map) => print(map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black,
        title: Image.network(
            "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0)),
                  hintText: 'pesquisar',
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0))),
            ),
          ),
        ],
      ),
    );
  }
}
