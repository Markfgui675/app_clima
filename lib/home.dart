import 'dart:async';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
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
  ValueNotifier<dynamic> lottieFile = ValueNotifier(Lottie.asset('assets/rain.json'));

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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.deepOrangeAccent
            ),
            elevation: 0,
            backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states){
              if(states.contains(MaterialState.scrolledUnder)){
                color.value = Colors.white;
                return Colors.deepPurple;
              }
              color.value = Colors.black;
              return Colors.deepOrangeAccent;
            }),
            toolbarHeight: 320,
            expandedHeight: 420,
            pinned: true,
            flexibleSpace: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24, top: 24),
                        child: Icon(Icons.menu),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('25°', style: TextStyle(fontSize: 100),),
                                  SizedBox(height: 5,),
                                  Text('Limpo', style: TextStyle(fontSize: 20),),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Text('Brasília'),
                                      Icon(Icons.pin_drop)
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Info', style: TextStyle(fontSize: 20),),

                                ],
                              ),
                            )
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Lottie.asset('assets/rain.json'),
                            )
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, int index){
                return Container(
                  height: 680,
                  color: Colors.transparent,
                );
              }
            ),

          )
        ],
      ),
    );
  }
}

