import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  String tipobusca = 'carro';
  String Marca = '1';
  String Modelo = '';
  String Ano = '';
  List ListaMarcas = [];


  Future<String> pegarMarcas() async {
    var url = Uri.parse('');
    if (tipobusca == 'carro') {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas');
    } else {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/motos/marcas');
    }
    var res = await http
        .get(url);
    var resBody = json.decode(res.body);

    setState(() {
      ListaMarcas = resBody;
    });

    //print(resBody);

    return "Sucess";
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta Tabela Fipe'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'carro',
                  groupValue: tipobusca,
                  onChanged: (value) {
                    setState(() {
                      tipobusca = 'carro';
                    });
                  },
                ),
                Text('Carros'),
                SizedBox(width: 10),
                Radio(
                  value: 'moto',
                  groupValue: tipobusca,
                  onChanged: (value) {
                    setState(() {
                      tipobusca = 'moto';
                    });
                  },
                ),
                Text('Motos'),
                SizedBox(width: 10),
              ],
            ),
            FutureBuilder(
                future: pegarMarcas(),
                builder: (context, snapshot) {
                  return DropdownButton<String>(
                      hint: Text("Selecione a Marca"),
                      value: Marca,
                      items: ListaMarcas.map((item) {
                        return  DropdownMenuItem(
                          child:  Text(item['nome']),
                          value: item['codigo'].toString(),
                        );
                      }).toList(),

                    onChanged: (value) {
                      setState(() {
                        Marca = value as String;
                      });
                    },

                  );
                }),

            DropdownButton(
              isExpanded: true,
              value: Modelo,
              iconSize: 30,
              hint: Text('Selecione o Modelo'),
              onChanged: null,
              items: null,
            ),
            DropdownButton(
              isExpanded: true,
              value: Ano,
              iconSize: 30,
              hint: Text('Selecione o Ano'),
              onChanged: null,
              items: null,
            )
          ],
        ),
      ),
    );
  }
}
