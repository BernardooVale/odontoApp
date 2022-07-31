import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:odonto_estagio/pagina_teste_usuario.dart';

class paginaPrincipal extends StatefulWidget {
  const paginaPrincipal({Key? key}) : super(key: key);

  @override
  State<paginaPrincipal> createState() => _paginaPrincipalState();
}

class _paginaPrincipalState extends State<paginaPrincipal> {

  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';

  @override
  void initState() {
    dadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    
    drawer: Drawer( 
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          UserAccountsDrawerHeader(
            accountName: Text(nome),
             accountEmail: Text(email),
             ),
             ListTile(

              dense: true,
              title: Text('Sair'),
              trailing: Icon(Icons.exit_to_app),
              onTap: (){sair();},
             ),
        ],
      ),
    ),
    appBar: AppBar(
      centerTitle: true,
        title: Text('OdontoApp'),
      ),
    body: Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Text(nome, textAlign: TextAlign.center,),

      ],
    ),
    );
  }

  dadosUsuario() async{

    User? usuario = await  _firebaseAuth.currentUser;

    if(usuario != null){

      setState(() {
        
        nome = usuario.displayName!;
        email = usuario.email!;
      });

    }

  }

  sair() async{

    await _firebaseAuth.signOut().then(
    (user) => Navigator.pushReplacement(
      context,
       MaterialPageRoute(
        builder: (context) => paginaTeste(),
        ),
      ),  
    );
  }
}