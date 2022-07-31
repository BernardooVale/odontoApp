import 'dart:async';
import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odonto_estagio/pagina_principal.dart';

import 'pagina_login.dart';

class paginaTeste extends StatefulWidget {
  const paginaTeste({Key? key}) : super(key: key);

  @override
  State<paginaTeste> createState() => _paginaTesteState();
}

class _paginaTesteState extends State<paginaTeste> {

  StreamSubscription? streamSubscription;

  @override
  void initState() {

    super.initState();
    streamSubscription = FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user){

        if (user == null){

          Navigator.pushReplacement(
            context,
             MaterialPageRoute(
              builder: (context) => paginaLogin(),
              ),
            );

        } else {

          Navigator.pushReplacement(
            context,
             MaterialPageRoute(
              builder: (context) => paginaPrincipal(),
              ),
            );
        }
      });
  }

  @override 
  void dispose(){

    streamSubscription!.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        
        child: CircularProgressIndicator(),
      
      ),
    );
  }
}