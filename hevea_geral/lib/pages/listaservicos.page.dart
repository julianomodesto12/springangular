import 'package:flutter/material.dart';
import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:sgihevea/model/Servico.dart';







class ListaServicosPage extends StatefulWidget {



  @override
  _ListaServicosPageState createState() =>
      new _ListaServicosPageState();
}

class _ListaServicosPageState extends State<ListaServicosPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Servico> items = new List();

  final db = DatabaseHelper.instance;

  int _selectedIndex = 0;



  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    //retornar objeto selecionado
    Navigator.pop(context,  items[_selectedIndex]);
  }

  TextEditingController editingController;




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

  void _gerarLista() async {
    List<Servico> lista = await db.getAllServicos();
    lista.toList();
    lista.forEach((servicos) {
      print("serv: "+servicos.toString() );
      items.add(servicos);
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
                onChanged: (value) {},
                controller: editingController,
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
                                _gerarLista();
                              },
                                  child: new Text('Filtrar' ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  )),
                              new FlatButton(onPressed: () {
                                Navigator.pop(context);
                              },
                                  child: new Text('Retornar' ,style: TextStyle(
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
                                      '${items[position].id_serv}',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].nome_serv}',
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