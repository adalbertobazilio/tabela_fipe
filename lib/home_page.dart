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
  List ListaModelos = [];
  List ListaAnos = [];
  List Valor = [];

  Future<String> pegarMarcas() async {
    var url = Uri.parse('');
    if (tipobusca == 'carro') {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas');
    } else {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/motos/marcas');
    }
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    setState(() {
      ListaMarcas = resBody;
    });

    return "Sucess";
  }

  Future<String> pegarModelos() async {
    var url = Uri.parse('');
    if (tipobusca == 'carro') {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas/'+ Marca +'/modelos');
    } else {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/motos/marcas/'+ Marca +'/modelos');
    }
    var res = await http.get(url);
    Map<String, dynamic> resBody = json.decode(res.body);
    List<dynamic> Lista = resBody['modelos'];
    //var resBody = json.decode(res.body);

    print(Lista);

    setState(() {
      int Codigo = Lista[0]["codigo"];
      Modelo = Codigo.toString();
    });

    setState(() {

      ListaModelos = Lista;
    });
    print(Modelo);
    return "Sucess";
  }

  Future<String> pegarAnos() async {
    var url = Uri.parse('');
    if (tipobusca == 'carro') {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas/' + Marca +'/modelos/' + Modelo +'/anos');
    } else {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/motos/marcas/' + Marca +'/modelos/' + Modelo +'/anos');
    }
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    setState(() {
      ListaAnos = resBody;
    });

    return "Sucess";
  }

  Future<String> pegarValor() async {
    var url = Uri.parse('');
    if (tipobusca == 'carro') {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas/' + Marca +'/modelos/' + Modelo +'/anos/' + Ano);
    } else {
      url = Uri.parse('https://parallelum.com.br/fipe/api/v1/motos/marcas/' + Marca +'/modelos/' + Modelo +'/anos/' + Ano);
    }
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    setState(() {
      Valor = resBody;
    });

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
                      Marca = '1';
                      pegarMarcas();
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
                      Marca = '60';
                      pegarMarcas();
                    });
                  },
                ),
                Text('Motos'),
                SizedBox(width: 10),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: Marca,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Selecione a Marca'),
                          onChanged: (newValue) {
                            setState(() {
                              Marca = newValue as String;
                              print(Marca);
                              pegarModelos();
                            });
                          },
                          items: ListaMarcas.map((item) {
                            return  DropdownMenuItem(
                              child:  Text(item['nome']),
                              value: item['codigo'].toString(),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),

            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: Modelo,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Selecione o Modelo'),
                          onChanged: (newValue) {
                            setState(() {
                              Modelo = newValue as String;
                              pegarAnos();
                              print(Modelo);
                            });
                          },
                          items: ListaModelos.map((item) {
                            return  DropdownMenuItem(
                              child:  Text(item['nome']),
                              value: item['codigo'].toString(),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
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
