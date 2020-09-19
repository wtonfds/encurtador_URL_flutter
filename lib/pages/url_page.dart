import 'package:desafio_logique/helpers/url_api.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class UrlPage extends StatefulWidget {
  @override
  _UrlPageState createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  final LocalStorage storage = new LocalStorage('logiq_app');
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: URLApi.listarTodos(storage.getItem('id')),
        // ignore: missing_return
        builder: (context, snapshot){
          if(snapshot.hasData){
            return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index){
                  Map wppost = snapshot.data[index];

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Single_URL(
                        url_curta: wppost['curta'],
                        url_data: wppost['data'],
                        url_idUsuario: wppost['id'],
                        url_original: wppost['original']

                    ),
                  );
                });
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Single_URL extends StatelessWidget {
  final url_curta;
  final url_data;
  final url_idUsuario;
  final url_original;


  Single_URL({
    this.url_curta,
    this.url_data,
    this.url_idUsuario,
    this.url_original
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('URL Encurtada:', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(url_curta),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('Data:', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(url_data),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('URL Original:', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(url_original),
            )
          ],
      ),
    );
  }
}