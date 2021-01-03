import 'package:flutter/material.dart';
import 'package:sgihevea/model/Atividade.dart';
import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:sgihevea/model/AtividadeFuncionario.dart';
import 'package:sgihevea/model/ExportarRegistros.dart';



import 'package:sgihevea/model/Usuario.dart';
import 'package:toast/toast.dart';

import 'atividade.page.dart';

class ListaExportarPage extends StatefulWidget {

  final Usuario usuario;

  int pid_atividade ;

  ListaExportarPage(this.usuario );

  @override
  _ListaExportarPageState createState() =>
      new _ListaExportarPageState();
}

class _ListaExportarPageState extends State<ListaExportarPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<AtividadeFuncionario> items = new List();

  final db = DatabaseHelper.instance;

  int _selectedIndex = 0;



  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    //retornar objeto selecionado
    // Navigator.pop(context,  items[_selectedIndex]);
  }

  TextEditingController editingController;
  final _fdataController = TextEditingController();



  //end write red file

  @override
  Future initState()  {
    super.initState();
    //List <Atividade> listativ = _retornaLista();
    // items = listativ;
    print('metodo preencher lista');
    //_gerarListaAtividade();
/*
    db.getAllAtividade().then((atividades) {
      setState(() {
        print('inicio tela consulta');
        atividades.forEach((atividade) {
          items.add(Atividade.fromMap(atividade));
        });
      });
    });
*/



    print('print fim lista');
  }




  void _gerarListaAtividadeData(String fData) async {
    //getAtividadeByDataAexportar(String pData) ;
    //verificar se tem dados anteriores

    if (items.isNotEmpty){
      items.clear();
      print("Limpeza");
    }

    print("Data: "+fData);

    List<AtividadeFuncionario> listAtiv = await db.getAtividadeByDataAexportar(fData);
    listAtiv.toList();
    int i= 0;
    listAtiv.forEach((atividades) {
      i+=1 ;
      print("i: "+i.toString());
      print("idativ: "+atividades.toString() );
      items.add(atividades);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Filtro Lista"),
        backgroundColor: Color(0XFF4CAF50),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _fdataController,
                onChanged: (value) {
                  print("onchange interno 0");
                  _gerarListaAtividadeData(value.toString());
                },
                //controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Container(//COLORIR BOTTON
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
                  child:                Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: <Widget>[
                              //dart treates everything as objects so we pass a function in onPressed value
                              new FlatButton(onPressed: () {
                                //_gerarListaAtividade();
                                print("onchange interno 1");
                                //_gerarListaAtividadeData(_fdataController.text.toString());
                              },
                                  child: new Text('Filtrar' ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  )),

                              new FlatButton(onPressed: () async {

                                Toast.show("Inicio exportação de Dados", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                int j= 0;
                                items.forEach((atividadexport) async {
                                  j+=1 ;
                                  print("i: "+j.toString());
                                  print("idativ: "+atividadexport.id_ativ.toString() );

                                  Exportacao exportacao = new Exportacao();
                                  await exportacao.exportarListaAtividadeId(atividadexport.id_ativ);



                                });

                                Toast.show("Fim exportação de Dados", context , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                Navigator.pop(context);
                              },
                                  child: new Text('Exportar' ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  )),

                            ],

                          ),

                        )

                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Container(
                    // color: Colors.yellow,
                    color: _selectedIndex != null && _selectedIndex == position
                        ? Colors.yellow
                        : Colors.white,

                    child: GestureDetector(
                      //para detectar um evento
                      //child: Text('Hello world'),
                      onTap: () {
                        // do something
                        _onSelected(position);
                        //_selectedIndex = ;
                      },



                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    /*varios campos por linha */

                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      '${items[position].data_ativ}',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].chapa_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].nome_func}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].coord_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].pres_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].serv_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].tarefa_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].arvore_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].qtd_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].sang_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].plat_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].roma_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].exportado}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ],
                              ),


                            ],
                          ),
                          Divider(
                            height: 2.0,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
