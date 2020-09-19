import 'package:desafio_logique/helpers/url_api.dart';
import 'package:desafio_logique/pages/login_page.dart';
import 'package:desafio_logique/pages/url_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalStorage storage = new LocalStorage('logiq_app');
  final _ctrlURLOriginal = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var nome = storage.getItem('nome');

    return Scaffold(
      appBar: AppBar(

        title: Text('Bem-vindo, $nome'),
      ),
      body: _body(context),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder : (context)=> URLList())
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.list),
                    Text("Listar URLs"),
                  ],
                ),
              ),

              InkWell(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(""),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  storage.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context)=>
                          LoginPage()),(Route<dynamic> route) => false
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.keyboard_return),
                    Text("LogOut"),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
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
                "Digite a URL",
                "Inicie a URL com http://",
                controller: _ctrlURLOriginal
            ),

            Text(""),

            _raisedButton("Encurtar URL", Colors.orange, context,),

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

    var dataAtual = DateTime.now().toIso8601String();

    var urlEncurtada = await URLApi.encurtadorUrl(_ctrlURLOriginal.text);

    String curta = urlEncurtada;
    var data = dataAtual.toString();
    int idUsuario = storage.getItem('id');
    String original = _ctrlURLOriginal.text;

    var response = await URLApi.salvarUrl(curta, data,  idUsuario, original);

    if(response == 201){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Encurtamento realizado com sucesso."),
            content: new Text("Clique em Fechar e veja sua URL"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  _ctrlURLOriginal.clear();
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (Context) => new URLList()));
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
            title: new Text("Erro ao Encurtar URL."),
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
}

