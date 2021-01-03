import 'package:flutter/material.dart';
import 'package:sgihevea/model/Usuario.dart';
import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:toast/toast.dart';

import 'listaanual.page.dart';
import 'listadiaria.dart';
import 'listamensal.page.dart';


class ListaResumoPage extends StatelessWidget {
  //passar parametro para page stateless
  String ptext;
  Usuario pusuario;


  ListaResumoPage( this.ptext,this.pusuario );




  @override
  Widget build(BuildContext context ) {


    return  Scaffold(

      body: new ListaResumoPagefulWidget(text :this.ptext , usuario : this.pusuario ),
    );

  }

}

class ListaResumoPagefulWidget extends StatefulWidget {
  String text;
  Usuario usuario;
  //LimparPage(this.url, this.fileName,[this.extension='txt']);

  //LimparPage({Key key}) : super(key: key);
  ListaResumoPagefulWidget({Key key,  @required this.text,  @required this.usuario  }) : super(key: key);

  @override
  _ListaResumoPagefulWidgetState createState() => new _ListaResumoPagefulWidgetState();

}

class _ListaResumoPagefulWidgetState extends State<ListaResumoPagefulWidget> {

  String ptexto ;
  Usuario user;


  Future initState()  {
    ptexto = widget.text;
    user = widget.usuario;


    super.initState();
  }

  final db = DatabaseHelper.instance;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Resumo Sangria'),
          centerTitle: true,
          backgroundColor: Color(0XFF4CAF50),
        ),
        body:
        Container(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          color: Colors.white,
          child: ListView(
              children: <Widget>[


                SizedBox(
                  height: 40,

                ),
                Container(
                  height: 60,

                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: [
                        Color(0xFF1B5E20),
                        Color(0XFF4CAF50),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: SizedBox.expand(
                      child: new Center(
                        child: new Row(
                          //spaceBetween
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            //dart treates everything as objects so we pass a function in onPressed value
                            new FlatButton(onPressed: () async {
                              //await limparDados();
                              print("Diario");
                               await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ListaDiariaPage(user)),
                              );

                            },
                                child: new Text('Diario'
                                  ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                )),
                            new FlatButton(onPressed: () async {
                              //await limparDados();
                              print("Mensal");
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ListaMensalPage(user)),
                              );

                            },
                                child: new Text('Mensal'
                                  ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                )),
                            new FlatButton(onPressed: () async {
                              //await limparDados();
                              print("Anual");
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ListaAnualPage(user)),
                              );

                            },
                                child: new Text('Anual'
                                  ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                )),
                            new FlatButton(onPressed: () async {
                              Navigator.pop(context);

                            },
                                child: new Text('Sair'
                                  ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                )),


                          ],

                        ),

                      )

                  ),
                ),

              ]
          ),
        )
    );
  }



}