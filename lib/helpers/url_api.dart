import 'dart:convert';
import 'package:http/http.dart' as http;


class URLApi{
  static Future<int> salvarUrl(String curta, String data, int idUsuario, String original) async {
    var url = 'http://secundario.logiquesistemas.com.br:8097/desafio-api/v1/url';
    var token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ3dG9uMjAyMCIsImF1dGgiOiJST0xFX0FETUlOSVNUUkFET1IiLCJpYXQiOjE2MDAzNjkzODQsImV4cCI6MTYwMTY2NTM4NH0.WYR-TYxKGsPgQFPAgvY-u7Dy5M8An3WyE_tioWmQzdtxJ8A7w9B7l0SoST6wYFd6aFt7t7aAqPdpZw3vRdR6rA';

    var _body = jsonEncode({
      "curta": curta,
      "data": data,
      "idUsuario": idUsuario,
      "original": original
    });

    var res = await http.post(
        url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: _body
    );

    var status = 0;
    if(res.statusCode == 201){
      status = res.statusCode;
    }else{
      status = res.statusCode;
    }

    return status;
  }

  static Future<List> listarTodos(int id) async {
    var url = 'http://secundario.logiquesistemas.com.br:8097/desafio-api/v1/url/listar/$id';
    var token = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ3dG9uMjAyMCIsImF1dGgiOiJST0xFX0FETUlOSVNUUkFET1IiLCJpYXQiOjE2MDAzNjkzODQsImV4cCI6MTYwMTY2NTM4NH0.WYR-TYxKGsPgQFPAgvY-u7Dy5M8An3WyE_tioWmQzdtxJ8A7w9B7l0SoST6wYFd6aFt7t7aAqPdpZw3vRdR6rA';

    final res = await http.get(
        url, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },);
    var convertDataJson = jsonDecode(res.body);
    return convertDataJson;
  }

  static Future<String> encurtadorUrl(String url) async {
    var link = 'https://api.shrtco.de/v2/shorten?url=$url';
    var res = await http.get(link);
    var result = jsonDecode(res.body);

    return result['result']['full_short_link'];
  }
}