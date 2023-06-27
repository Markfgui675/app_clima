import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _pesquisar() async {
    String chave_api = '18ebbd17';

    // url padrão
    //var url = Uri.parse('https://api.hgbrasil.com/weather?key=$chave_api');
    var url = Uri.parse(
        'https://api.hgbrasil.com/weather?key=$chave_api&user_ip=remote');
    var response = await http.get(url);

    if(response.statusCode == 200){
      print(json.decode(response.body));
      dynamic resultado = json.decode(response.body);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _pesquisar(),
            child: Text("Pesquisar clima")
          )
        ],
      ),
    );
  }
}

