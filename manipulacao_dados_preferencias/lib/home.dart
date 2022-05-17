import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: camel_case_types

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController controlerTextField = TextEditingController();
  String _textoSalvo = 'Nada Salvo!';

  _salvar() async {
    String valorDigitado = controlerTextField.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);

    print("Valor salvo:  $valorDigitado");
  }

  _ler() async {
    final prefs = await SharedPreferences.getInstance();
    setState((){
      _textoSalvo = prefs.getString("nome") ?? "Sem Valor";
    });
    print("Valor recuperado:  $_textoSalvo");

  }

  _remover() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manipulação de Dados'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child:  Column(
          children: [
            Text(_textoSalvo,
                style: TextStyle(fontSize: 20),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: 'Digite algo',
                  labelStyle: TextStyle(
                      fontSize: 18
                  )
              ),
              controller: controlerTextField,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: _salvar,
                    child: const Text('Salvar')
                ),
                ElevatedButton(
                    onPressed: _ler,
                    child: const Text('Ler'),
                ),
                ElevatedButton(
                  onPressed: _remover,
                  child: const Text('Remover'),
                ),
              ],
            )
          ],
        )
      )
    );
  }
}
