import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odonto_estagio/pagina_teste_usuario.dart';

class paginaCadastro extends StatefulWidget {
  const paginaCadastro({Key? key}) : super(key: key);

  @override
  State<paginaCadastro> createState() => _paginaCadastroState();
}

class _paginaCadastroState extends State<paginaCadastro> {

final _nomeControle = TextEditingController();
  final _emailControle = TextEditingController();
  final _senhaControle = TextEditingController(); 
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Página de Cadastro'),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [ 
          TextFormField(

            controller: _nomeControle,
            decoration: InputDecoration(

              label: Text('Nome completo')
            ),
          ),
          TextFormField(

            controller: _emailControle,
            decoration: InputDecoration(

              label: Text('email')
            ),

          ),
          TextFormField(

            controller: _senhaControle,
            decoration: InputDecoration(

              label: Text('senha')
            ),

          ),

          ElevatedButton(
            onPressed: (){cadastrar();},
             child: Text('Cadastrar'),
            ),
        ],
      ),
    );
  }

  cadastrar() async{

    try{

      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: _emailControle.text,
      password: _senhaControle.text);

      if(userCredential != null){

        userCredential.user!.updateDisplayName(_nomeControle.text);
          Navigator.pushAndRemoveUntil(
            context,
             MaterialPageRoute(
              builder: (context) => paginaTeste(),
              ),
            (route) => false);  

      }

    } on FirebaseAuthException catch (e){

      if(e.code == 'weak-password'){

        ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text('Senha fraca'),
          backgroundColor: Colors.redAccent,
        ),
      );

      } else if (e.code == 'email-already-in-use'){

        ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text('email já em uso'),
          backgroundColor: Colors.redAccent,
        ),
      );

      }
    }
  }
}