import 'package:flutter/material.dart';
import 'package:youtube_clone_app/CustomSearchDelegate.dart';
import 'package:youtube_clone_app/telas/Biblioteca.dart';
import 'package:youtube_clone_app/telas/EmAlta.dart';
import 'package:youtube_clone_app/telas/Inicio.dart';
import 'package:youtube_clone_app/telas/Inscricoes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // variaveis
  int _indiceAtual = 0;

  //fim variaveis

  @override
  Widget build(BuildContext context) {
    // list para chamar telas
    String _resultado = "";
    List<Widget> telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricoes(),
      Biblioteca()
    ];
    // fim list

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey, opacity: 1),
        backgroundColor: Colors.white, // Cor de fundo
        title: Image.asset(
          "images/logo_youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          // botao pesquisar
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String res = await showSearch(
                  context: context, delegate: CustomSearchDelegate());
              setState(() {
                _resultado = res;
              });
            },
          ),
          // Fim botao pesquisar
        ],
      ),
      body: telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              title: Text("Início"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("Em alta"), icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(
              title: Text("Inscrições"), icon: Icon(Icons.subscriptions)),
          BottomNavigationBarItem(
              title: Text("Biblioteca"), icon: Icon(Icons.folder))
        ],
      ),
    );
  }
}
