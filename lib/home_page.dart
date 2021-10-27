import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String tipobusca = 'carro';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta Tabela Fipe'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
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
          Text('Selecione a Marca', textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0),),
          DropdownButton(
            value: null,
            items: null,
            onChanged: null,
          )
          ],
        ),
      ),
    );
  }
}
