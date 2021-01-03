import 'package:flutter/material.dart';
import 'package:oficinamobile/dao/DatabaseHelper.dart';
import 'package:oficinamobile/model/Usuario.dart';

import 'package:toast/toast.dart';


class LimparPage extends StatelessWidget {
  //passar parametro para page stateless
  String ptext;
  Usuario pusuario;


  LimparPage( this.ptext,this.pusuario );




  @override
  Widget build(BuildContext context ) {


    return  Scaffold(

      body: new LimparPagefulWidget(text :this.ptext , usuario : this.pusuario ),
    );

  }

}

class LimparPagefulWidget extends StatefulWidget {
  String text;
  Usuario usuario;
  //LimparPage(this.url, this.fileName,[this.extension='txt']);

  //LimparPage({Key key}) : super(key: key);
  LimparPagefulWidget({Key key,  @required this.text,  @required this.usuario  }) : super(key: key);

  @override
  _LimparPagefulWidgetState createState() => new _LimparPagefulWidgetState();

}

class _LimparPagefulWidgetState extends State<LimparPagefulWidget> {

  String ptexto ;
  Usuario user;



  Future initState()  {
    ptexto = widget.text;
    user = widget.usuario;


    super.initState();
  }

  final db = DatabaseHelper.instance;


  Future<void> limparDados() async {

   Toast.show("Excluindo dados", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
   await db.deleteAllHoraTecnica();
   await db.deleteAllFuncionario();
   await db.deleteAllComponente();
   await db.deleteAllMotivo();
   await db.deleteAllOrdemServico();
    Toast.show("Fim Exclusão dados", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Limpar Dados'),
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
                               await limparDados();
                              print("limpar");

                            },
                                child: new Text('Limpar'
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