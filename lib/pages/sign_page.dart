import 'package:desafio_logique/helpers/login_api.dart';
import 'package:desafio_logique/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../main.dart';

class SignPage extends StatelessWidget {
  final LocalStorage storage = new LocalStorage('logiq_app');
  final _ctrlEmail = TextEditingController();
  final _ctrlLogin = TextEditingController();
  final _ctrlNome = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastre - se", style:
        TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            _textFormField(
                "Email",
                "Digite o Email",
                controller: _ctrlEmail,
                validator : _validaEmail
            ),
            _textFormField(
                "Login",
                "Digite o login",
                controller: _ctrlLogin,
                validator: _validaLogin
            ),
            _textFormField(
                "Nome",
                "Digite o nome",
                controller: _ctrlNome,
                validator: _validaNome
            ),
            _textFormField(
                "Senha",
                "Digite o sobre nome",
                controller: _ctrlSenha,
                validator: _validaNome
            ),

            Divider(),

            _raisedButton("CADASTRAR", Colors.orange, context,),

          ],
        ),
      ),
    );
  }

  _textFormField(
      String label,
      String hint, {
        bool senha = false,
        TextEditingController controller,
        FormFieldValidator<String> validator,
      }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: senha,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  String _validaLogin(String texto) {
    if(texto.isEmpty){
      return "Campo Obrigatório";
    }
    if(texto.length<3){
      return "O campo precisa ter mais de 3 caracteres";
    }
    return null;
  }

  String _validaNome(String texto) {
    if(texto.isEmpty){
      return "Campo Obrigatório";
    }
    if(texto.length<3){
      return "O campo precisa ter mais de 3 caracteres";
    }
    return null;
  }

  String _validaEmail(String texto) {
    if(texto.isEmpty){
      return "Campo Obrigatório";
    }
    if(texto.length<3){
      return "O campo precisa ter mais de 3 caracteres";
    }
    return null;
  }

  _raisedButton(
      String texto,
      Color cor,
      BuildContext context) {
    return RaisedButton(
      color: cor,
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      onPressed: () {
        _clickButton(context);
      },
    );
  }

  _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    String email = _ctrlEmail.text;
    String nome = _ctrlNome.text;
    String senha = _ctrlSenha.text;
    String login = _ctrlLogin.text;

    var response = await LoginApi.sign(email, login, nome, senha);

    if(response == 201){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Cadastro realizado com sucesso."),
            content: new Text(""),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  _navegaHomepage(context);
                },
              ),
            ],
          );
        },
      );

    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Erro ao Cadastrar esse usuário."),
            content: new Text("Tente novamento mais tarde."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  _navegaHomepage(BuildContext context){
    Navigator.push(
      context, MaterialPageRoute(
        builder : (context)=> LoginPage()
    ),
    );
  }

}
