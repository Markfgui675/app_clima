import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ValueNotifier<Color> color = ValueNotifier(Colors.black);

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states){
              if(states.contains(MaterialState.scrolledUnder)){
                color.value = Colors.white;
                return Colors.deepPurple;
              }
              color.value = Colors.black;
              return Colors.deepOrangeAccent;
            }),
            toolbarHeight: 120,
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: AnimatedBuilder(
                animation: color,
                builder: (context, _){
                  return Text('Cliente', style: TextStyle(color: color.value),);
                },
              ),

            ),

          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 9,
              (context, int index){
                return Container(
                  height: 120,
                  color: Colors.red,
                );
              }
            ),

          )
        ],
      ),
    );
  }
}

