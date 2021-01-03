import 'dart:io';

import 'package:file/local.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

import 'dart:convert';
//import 'package:fs_shim/fs_io.dart';
import 'package:path/path.dart';


import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:sgihevea/model/Atividade.dart';
import 'package:sgihevea/model/ExportarRegistros.dart';
import 'package:sgihevea/model/Fazenda.dart';
import 'package:sgihevea/model/FuncionariosRM.dart';

import 'package:sgihevea/model/Garquivos.dart';
import 'package:sgihevea/model/ImportarRegistros.dart';
import 'package:sgihevea/model/Usuario.dart';
import 'package:sgihevea/pages/usuario.page.dart';

import 'package:toast/toast.dart';

import 'atividade.page.dart';
import 'home.page.dart';
import 'limpardados.page.dart';
import 'listaavaliacao.page.dart';
import 'listaexportar.page.dart';
import 'listaresumo.page.dart';
import 'listaservicos.page.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
//import 'package:flutter/foundation.dart' show TargetPlatform;


class MenuPage extends StatelessWidget {
  //passar parametro para page stateless
  String ptext;
  Usuario pusuario;


  MenuPage( this.ptext,this.pusuario );




  @override
  Widget build(BuildContext context ) {


    return  Scaffold(

      body: new MenuPageful(text :this.ptext , usuario : this.pusuario ),
    );

  }

}



class MenuPageful extends StatefulWidget {


  //MenuPageful(this.url, this.fileName,[this.extension='txt']);

  //MenuPageful({Key key}) : super(key: key);
  String text;
  Usuario usuario;
  //UsuarioPage(this.url, this.fileName,[this.extension='txt']);

  //UsuarioPage({Key key}) : super(key: key);
  MenuPageful({Key key,  @required this.text,  @required this.usuario  }) : super(key: key);

  @override
  _MenuPagefulState createState() => new _MenuPagefulState();

}

class _MenuPagefulState extends State<MenuPageful> {

  bool downloading = false;
  String _message;
  var progressString = "";
  Future<Directory> _externalDocumentsDirectory;



  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   //escolher titulos menu
  var titles = ['Atividades', 'Exportação', 'Importação', 'Outros',
    'Servicos','Usuario','Resumo','Avaliação'];

  //escolher menus
  final icons = [Icons.directions_bike, Icons.directions_boat,
    Icons.directions_bus, Icons.directions_car, Icons.directions_railway,
    Icons.directions_run, Icons.directions_subway, Icons.directions_transit,
    Icons.directions_walk];


  List<String> items = new List();
  final db = DatabaseHelper.instance;

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);

  }

  TextEditingController _dataController;
  TextEditingController _funcController;



  Future<String> getDiretorio() async {
    final diretorio =   await getApplicationDocumentsDirectory();//getExternalStorageDirectory();
    //getApplicationDocumentsDirectory();
    return diretorio.path;
  }

  @override
  Future initState()   {



     super.initState();

  }




  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Lista Menu',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Lista de Menu'),
          centerTitle: true,
          backgroundColor: Color(0XFF4CAF50),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, position) {
              return Container(
                color: _selectedIndex != null && _selectedIndex == position
                    ? Colors.black12
                    : Colors.white,
                  child: GestureDetector(
                              //para detectar um evento

                              onTap: () {
                                // do something
                                _onSelected(position);


                              },// onTap

                              child:Column(
                                children: <Widget>[
                                  Divider(height: 5.0),
                                  ListTile(
                                    // trailing:
                                    title: Text(
                                      '${titles[position]}',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.green,
                                      ),
                                    ),
                                    trailing:Icon(icons[position]), //  Icons.vpn_key


                                  ),
                                ],
                              ),

                          ),


              );//container
            }
          )

        ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.ac_unit),
            onPressed: () async {

                 Usuario user = new Usuario();
                 _navigateToScreen( context,_selectedIndex, widget.usuario);//
                 //escolher path

            }, //chamar tela correspondente

          ),
      ));

  }
}



void _navigateToScreen(BuildContext context,itempage, Usuario user) async {

  String result ;

  switch ( itempage ) {
    case 0:
      {



        Atividade _patividade = new Atividade();
        _patividade.id_ativ = 0;
        _patividade.roma_ativ =0;
        _patividade.plat_ativ = 0;
        _patividade.pres_ativ= "P";
        _patividade.sang_ativ= "NS";

        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AtividadePage(user, _patividade ) ),
        );


      }
      break;

    case 1:
      {
        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListaExportarPage(user)),
        );
        //gerar arquivo exportacao;
        //Toast.show("Iniciando exportação de Dados", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        //Exportacao exportacao = new Exportacao();
        //await exportacao.exportarListaAtividade();
        //Toast.show("Fim exportação de Dados", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
      break;

    case 2:
      {
        //IMPORTAR ARQUIVOS
        Toast.show("Iniciando importação de Dados", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        //await importaRegistros(context);
       Importacao importacao = new Importacao();
        await importacao.importarTudo(user.faze_usua.toString(), user.chapa_usua );

        Toast.show("Fim importação de Dados", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
      break;

    case 3:
      {

        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LimparPage("I",user)),
        );
      }
      break;


    case 4:
      {
        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListaServicosPage()),
        );
      }
      break;

    case 5:
      {
       if( user.login_usua=="master") {

         Toast.show("Iniciando importação de Usuarios", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
         //await importaRegistros(context);
         Importacao importacao = new Importacao();
         await importacao.importarUsuarios();

         Toast.show("Fim importação de Usuarios", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
         print("import usuarios");
         /*
         Usuario aux = new Usuario();
         aux.id_usua = 0;

         result = await Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => UsuarioPage("I",aux)),
         );

          */

       }
       else
         {
           Toast.show("Permissao Negada", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
         }
        //cadastrar usuario

      }
      break;
    case 6:
      {
        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListaResumoPage("I",user)),
        );
      }
      break;
    case 7:
      {
        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListaAvaliacaoPage(user)),
        );
      }
      break;
    default:
      {
        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(user)),
        );
      }
  }





}

  





