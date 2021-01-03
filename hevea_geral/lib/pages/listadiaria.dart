import 'package:flutter/material.dart';

import 'package:sgihevea/dao/DatabaseHelper.dart';

import 'package:sgihevea/model/DiariaHevea.dart';

import 'package:sgihevea/model/Usuario.dart';


class ListaDiariaPage extends StatefulWidget {

  final Usuario usuario;

  int pid_atividade ;

  ListaDiariaPage(this.usuario );

  @override
  _ListaDiariaPageState createState() =>
      new _ListaDiariaPageState();
}

class _ListaDiariaPageState extends State<ListaDiariaPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<DiariaHevea> items = new List();

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

  void _gerarLista(String pfazenda , int pTarefa ) async {

    List<DiariaHevea> listDiaria = await db.getAllResumoDiario( pfazenda , pTarefa );
    listDiaria.toList();
    listDiaria.forEach((elemento) {

      items.add(elemento);
    });
  }


  void _gerarListaData(String pfazenda , int pTarefa ) async {
    //verificar se tem dados anteriores

    if (items.isNotEmpty){
      items.clear();
      print("Limpeza");
    }



    List<DiariaHevea> listDiaria = await db.getAllResumoDiario( pfazenda , pTarefa );
    listDiaria.toList();
    int i= 0;
    listDiaria.forEach((elemento) {
      i+=1 ;
      print("i: "+i.toString());

      items.add(elemento);
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
                  //_gerarListaAtividadeData(value.toString());
                  _gerarListaData(widget.usuario.faze_usua , int.parse( value.toString() ) );
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
                                //_gerarListaData(widget.usuario.faze_usua);
                              },
                                  child: new Text('Filtrar' ,style: TextStyle(
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
                                    //a.id_dih, a.data_dih, a.chapa_dih, a.funcionario_dih, a.tarefa_dih,a.arvores_dih, a.coord_dih
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 12.0, 12.0, 6.0),
                                    child: Text(
                                      '${items[position].id}',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].data_ativ}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].chapa}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].funcionario}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].tarefa}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].arvores}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].coord}',
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