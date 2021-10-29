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
  String Marca = '';
  String Modelo = '';
  String Ano = '';
  List ListaMarcas = [];
  List ListaModelos = [];
  List ListaAnos = [];
  List Valor = [];
  String MarcaTexto = '';
  String ModeloTexto = '';
  String AnoModeloTexto = '';
  String CombustivelTexto = '';
  String FipeTexto = '';
  String MesRefTexto = '';
  String ValorTexto = '';

  void ZeraLabels(){
    setState(() {
      MarcaTexto = '';
      ModeloTexto = '';
      AnoModeloTexto = '';
      CombustivelTexto = '';
      FipeTexto = '';
      MesRefTexto = '';
      ValorTexto = '';
    });
  }

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
      Marca = resBody[0]["codigo"];
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

    setState(() {
      int Codigo = Lista[0]["codigo"];
      Modelo = Codigo.toString();
      ListaModelos = Lista;
    });
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
      Ano = resBody[0]["codigo"];
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
      MarcaTexto = resBody["Marca"];
      ModeloTexto = resBody["Modelo"];
      int AnoMod = resBody["AnoModelo"];
      AnoModeloTexto = AnoMod.toString();
      CombustivelTexto = resBody["Combustivel"];
      FipeTexto = resBody["CodigoFipe"];
      MesRefTexto = resBody["MesReferencia"];
      ValorTexto = resBody["Valor"];
    });

    return "Sucess";
  }

  @override
  void initState() {
    pegarMarcas();
    super.initState();
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
                      ListaMarcas = [];
                      tipobusca = 'carro';
                      Marca = '1';
                      pegarMarcas();
                      ListaAnos = [];
                      ListaModelos = [];
                      ZeraLabels();
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
                      ListaMarcas = [];
                      tipobusca = 'moto';
                      Marca = '60';
                      pegarMarcas();
                      ListaAnos = [];
                      ListaModelos = [];
                      ZeraLabels();
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
                          isExpanded: true,
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
                              pegarModelos();
                              ListaAnos = [];
                              ZeraLabels();
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
                          isExpanded: true,
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
                              ZeraLabels();
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
                          value: Ano,
                          isExpanded: true,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Selecione o Ano'),
                          onChanged: (newValue) {
                            setState(() {
                              Ano = newValue as String;
                              pegarValor();
                            });
                          },
                          items: ListaAnos.map((item) {
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
            Row(
                children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 5.0,5.0),
                child: Text('Marca: ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
                   Text(MarcaTexto, overflow: TextOverflow.fade, textAlign: TextAlign.left,style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
            ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 5.0,5.0),
                  child: Text('Modelo: ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
                SizedBox(
                  width: 285.0,
                  child:
                Text(ModeloTexto, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,style: TextStyle(color: Colors.deepPurple, fontSize: 18, )),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 5.0,5.0),
                  child: Text('Ano: ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
                Text(AnoModeloTexto, textAlign: TextAlign.left,style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 5.0,5.0),
                  child: Text('Combustível: ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
                Text(CombustivelTexto, textAlign: TextAlign.left,style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 5.0,5.0),
                  child: Text('Código Fipe: ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
                Text(FipeTexto, textAlign: TextAlign.left,style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 5.0,5.0),
                  child: Text('Mês Referência: ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
                Text(MesRefTexto, textAlign: TextAlign.left,style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 5.0,5.0),
                  child: Text('Valor: ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
                Text(ValorTexto, textAlign: TextAlign.left,style: TextStyle(color: Colors.deepPurple, fontSize: 18)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
