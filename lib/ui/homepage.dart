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
    return Container();
  }
}
