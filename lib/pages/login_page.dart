import 'package:desafio_logique/components/alert.dart';
import 'package:desafio_logique/helpers/login_api.dart';
import 'package:desafio_logique/pages/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../main.dart';

class LoginPage extends StatelessWidget {

  final LocalStorage storage = new LocalStorage('logiq_app');
  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGAR", style:
        TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context){
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            _textFormField(
                "Login",
                "Digite o Login",
                controller: _ctrlLogin,
                validator : _validaCampos
            ),
            _textFormField(
                "Senha",
                "Digite a senha",
                controller: _ctrlSenha,
                validator : _validaCampos,
                senha: true
            ),

            Divider(),

            _raisedButton("ENTRAR", Colors.orange, context,),

            _raisedButtonCadast("CADASTRE-SE", Colors.yellow, context),

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

  String _validaCampos(String texto) {
    if(texto.isEmpty){
      return "Este campo é obrigatório";
    }
    if(texto.length<3){
      return "O campo precisa ter mais de 3 caracteres";
    }

    return null;
  }

  String _validaEmail(String texto) {
    if(texto.isEmpty){
      return "Digite o Login";
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

  _raisedButtonCadast(
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
        Navigator.push(
          context, MaterialPageRoute(
            builder : (context)=> SignPage()),
        );
      },
    );
  }

  _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    String login = _ctrlLogin.text;
    String senha = _ctrlSenha.text;

    var res = await LoginApi.login(login, senha);

    if(res == 200){
      _navegaHomepage(context);
    }else{
      alert(context, "Login ou senha Inválidos");
    }
  }

  _navegaHomepage(BuildContext context){
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context)=>HomePage()
        ),(Route<dynamic> route) => false);
  }
}
