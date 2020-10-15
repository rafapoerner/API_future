import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Map> _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (context, snapshot) {
        String resultado;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            print('Conexao waiting');
            resultado = "Carregando...";
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            print("Connection none");
            if (snapshot.hasError) {
              resultado = 'Erro ao exibir os dados';
            } else {
              double valor = snapshot.data['BRL']['buy'];
              resultado = 'Preco do Bitcoin: ${valor.toString()} ';
            }
            break;
        }
        return Scaffold(
          body: Center(
            child: Text(resultado),
          ),
        );
      },
    );
  }
}
