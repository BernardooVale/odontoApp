import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pagina_principal.dart';
import 'pagina_cadastro.dart';

class paginaLogin extends StatefulWidget {
  const paginaLogin({Key? key}) : super(key: key);

  @override
  State<paginaLogin> createState() => _paginaLoginState();
}

class _paginaLoginState extends State<paginaLogin> {

  final _emailControle = TextEditingController();
  final _senhaControle = TextEditingController(); 
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(

        title: Text('Pagina de Login'),
        ),

      body: ListView(

        padding: EdgeInsets.all(12),
        children: [

          TextFormField(

            controller: _emailControle,
            decoration: InputDecoration(

              label: Text('email'),
            ),
          ),
          TextFormField(

            controller: _senhaControle,
            decoration: InputDecoration(

              label: Text('senha'),
            )
          ),
          ElevatedButton(onPressed: (){

            login();

          }, child: Text('Entrar'),
          ),
          TextButton(onPressed: (){

            Navigator.push(
              context,
               MaterialPageRoute(
                builder: (context) => paginaCadastro(),
              ),
            );
          }, child: Text('Criar Conta'),),
        ],
      ),
    );
  }

login() async {

  try{

    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: _emailControle.text,
       password: _senhaControle.text);

    if(userCredential != null){

      Navigator.pushReplacement(
            context,
             MaterialPageRoute(
              builder: (context) => paginaPrincipal(),
              ),
            );
    }
  }on FirebaseAuthException catch(e){

    if(e.code == 'user-not-found'){

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text('Usuario não encontrado'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else if(e.code == 'wrong-password'){

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text('Senha incorreta'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}

}