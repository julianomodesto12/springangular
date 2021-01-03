import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oficinamobile/dao/DatabaseHelper.dart';
import 'package:oficinamobile/model/ExportarRegistros.dart';
import 'package:oficinamobile/model/HoraTecnica.dart';
import 'package:oficinamobile/model/HoraTecnicaExp.dart';
import 'package:oficinamobile/model/Usuario.dart';





import 'package:toast/toast.dart';



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

  List<HoraTecnicaExp> items = new List();

  final db = DatabaseHelper.instance;

  int _selectedIndex = 0;

  String convertNumeroHora(int pval){
    String resultado = "00";
    //parte inteira  divisao
    int pInt = pval~/60 ;
    //resto da divisao
    int pRest = pval%60 ;
    var f = new NumberFormat("00", "pt_BR");
    resultado = f.format(pInt) + ":" +f.format(pRest) ;

    return resultado;

  }



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


    print('metodo preencher lista');



    print('print fim lista');
  }

  void _gerarListaDados(String fData ) async {


    if (items.isNotEmpty){
      items.clear();
      print("Limpeza");
    }

    print("Data: "+fData);

    List<HoraTecnicaExp> listDados = await db.getHoraTecnicaExpByData(fData);
    listDados.toList();
    int i= 0;
    listDados.forEach((dado) {
      i+=1 ;
      print("i: "+i.toString());


      items.add(dado);
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
                  _gerarListaDados(value.toString());
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
                                items.forEach((hrtecexport) async {
                                  j+=1 ;
                                  print("i: "+j.toString());
                                  print("idhora: "+hrtecexport.hoteCodigo.toString() );

                                  Exportacao exportacao = new Exportacao();
                                  await exportacao.exportarListaHoraTecnicaChave(hrtecexport.hoteCodigo);



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
                                      '${items[position].hoteData}',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].funcChapa}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].orseCodigo}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].compCodigo}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${items[position].mohaCodigo}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${convertNumeroHora(items[position].ithoHorainicio)}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${convertNumeroHora(items[position].ithoHorafim)}',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Text(
                                      '${(items[position].exportado)}',
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
