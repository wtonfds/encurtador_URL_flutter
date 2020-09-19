import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class LoginApi {
  static Future<int> login(String login, String senha) async {

    var token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ3dG9uMjAyMCIsImF1dGgiOiJST0xFX0FETUlOSVNUUkFET1IiLCJpYXQiOjE2MDAzNjkzODQsImV4cCI6MTYwMTY2NTM4NH0.WYR-TYxKGsPgQFPAgvY-u7Dy5M8An3WyE_tioWmQzdtxJ8A7w9B7l0SoST6wYFd6aFt7t7aAqPdpZw3vRdR6rA';
    var url = 'http://secundario.logiquesistemas.com.br:8097/desafio-api/v1/auth/login';
    final LocalStorage storage = new LocalStorage('logiq_app');

    var _body = jsonEncode({ "login": "$login", "senha": "$senha"});

    var res = await http.post(
        url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
      }, body: _body
    );

    var status = 0;
    if(res.statusCode == 200){
      var parsedJson = json.decode(res.body);

      var id = parsedJson['detalhesUsuario']['id'];
      var email = parsedJson['detalhesUsuario']['email'];
      var nome = parsedJson['detalhesUsuario']['nome'];

      storage.setItem('id', id);
      storage.setItem('email', email);
      storage.setItem('nome', nome);

      status = res.statusCode;
    }else{
      status = res.statusCode;
    }

    return status;
  }

  static Future<int> sign(String email, String login, String nome, String senha) async {

    var url = 'http://secundario.logiquesistemas.com.br:8097/desafio-api/v1/auth/cadastrar/usuario/';
    var token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ3dG9uMjAyMCIsImF1dGgiOiJST0xFX0FETUlOSVNUUkFET1IiLCJpYXQiOjE2MDAzNjkzODQsImV4cCI6MTYwMTY2NTM4NH0.WYR-TYxKGsPgQFPAgvY-u7Dy5M8An3WyE_tioWmQzdtxJ8A7w9B7l0SoST6wYFd6aFt7t7aAqPdpZw3vRdR6rA';
    final LocalStorage storage = new LocalStorage('logiq_app');

    Map data = {
    "email": email,
    "login": login,
    "nome": nome,
    "senha": senha
    };

    var parserJson = jsonEncode(data);

    var res = await http.post(
        url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: parserJson
    );

    var status = 0;
    if(res.statusCode == 201){
      status = res.statusCode;
    }else{
      status = res.statusCode;
    }

    return status;
  }
}