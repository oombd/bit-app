import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";

  void _saberPreco() async {
    Uri url = Uri.parse("https://blockchain.info/ticker");
    http.Response resposta = await http.get(url);
    Map<String, dynamic> retorno = json.decode(resposta.body);

    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Preço do Bitcoin",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(17),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(11),
                child: Text(
                  "R\$ " + _preco,
                  style: const TextStyle(
                    fontSize: 45,
                  )
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 200),
                  shape: const CircleBorder(),
                  primary: Colors.black
                ),
                onPressed: _saberPreco,
                child: const Text(
                  "Atualizar",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
