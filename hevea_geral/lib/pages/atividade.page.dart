
import 'package:flutter/material.dart';
import 'package:sgihevea/model/Atividade.dart';

import 'package:sgihevea/model/Fazenda.dart';
import 'package:sgihevea/model/Funcionario.dart';

import 'package:sgihevea/model/Servico.dart';
import 'package:sgihevea/model/Tarefa.dart';
import 'package:sgihevea/model/Usuario.dart';
import 'datetime.page.dart';
import 'listaatividade.page.dart';
import 'package:intl/intl.dart';

import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:sgihevea/sizeconfig.dart';



/// This Widget is the main application widget.
class AtividadePage extends StatelessWidget {
  //passar parametro para page stateless
  final Usuario usuario;
  final Atividade _atividade;


  AtividadePage(this.usuario , this._atividade);




  @override
  Widget build(BuildContext context ) {


    return  Scaffold(

      body: new MyStatefulWidget(text :"I", usu : this.usuario , atividadew: this._atividade  ),
    );

  }

}



class MyStatefulWidget extends StatefulWidget {
  //pegar parametro originario do page stateless, acrescentado nome parametros e @required
  String text ;
  final Usuario usu ;
  Atividade atividadew;

  MyStatefulWidget({Key key, @required this.text,  @required this.usu , @required this.atividadew }) : super(key: key);


  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  Atividade atividadecontroler = null;

   String ptexto ;

   FocusNode myFocusNode;

   void limparDados(){
     _ffuncionarioController.clear();

     _fcoordenadorController.clear();

     _fservicoController.clear();
     _ftarefaController.clear();
     _fquantidadeController.clear();
     vdropdownValueTipo = "DI";
     _fplataformaController.clear();
     _fromaneioController.clear();
     _fchaveController.clear();
     _fexportado.clear();

   }

   void preencherDados(Atividade fatividade){
     _ffuncionarioController.text = fatividade.chapa_ativ.toString();
     //DateTime selectedDate =   date2;
     _fcoordenadorController.text= fatividade.coord_ativ.toString();
     vdropdownValue = fatividade.pres_ativ;
     _fservicoController.text = fatividade.serv_ativ.toString();
     _ftarefaController.text = fatividade.tarefa_ativ.toString();
     _fquantidadeController.text = fatividade.qtd_ativ.toString();
     vdropdownValueTipo = fatividade.sang_ativ;
     _fplataformaController.text = fatividade.plat_ativ.toString();
     _fromaneioController.text =  fatividade.roma_ativ.toString();
     _fchaveController.text = fatividade.chavexp;
     _fexportado.text = fatividade.exportado;

     print("preencher data: "+fatividade.data_ativ);
     print("preencher data: "+fatividade.data_ativ.substring(6,10));
     int pano = int.parse( fatividade.data_ativ.substring(6,10));
     int mes = int.parse( fatividade.data_ativ.substring(3,5));
     int dia = int.parse( fatividade.data_ativ.substring(0,2));
     print("preencher data pos dia mes ano ");

     DateTime pDataparam = new DateTime.utc(pano,mes,dia, 00, 00, 00);
     print("preencher  pDataparam ");
     //DateTime pDataparam = DateTime.parse(widget.atividadew.data_ativ);
     _date.value  = TextEditingValue(text:new DateFormat("dd-MM-yyyy").format(pDataparam));
     //_novaData( pDataparam);
     print("preencher  _date.value ");
     print(pDataparam);

   }


   void initState()  {
    super.initState();
    ptexto = widget.text;


      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`


    print("incio text");
    print(ptexto);
    print("incio tela log");
    print(widget.usu.login_usua);
    print("id_ativ");
    print(widget.atividadew.id_ativ);
    print("if");
    if (widget.atividadew.id_ativ > 0 ){
      print("pos if widget.atividadew.id_ativ > 0");

       preencherDados(widget.atividadew);

      print("pos preenchimento campo");

    }
    else
      {
        //_fcoordenadorController.text = widget.usu.chapa_usua.toString();
        print("pos if widget.atividadew.id_ativ <= 0");
        iniciarDados();

      }
    print("myFocusNode ");
    myFocusNode = FocusNode();
    print("super.initState()");

  }

  void setStateAtividade() {
  atividadecontroler = widget.atividadew;
  }


   @override
   void dispose() {
     // Clean up the focus node when the Form is disposed.
     myFocusNode.dispose();

     super.dispose();
   }

  final db = DatabaseHelper.instance;
  Atividade _atividadecad;

  //final Atividade pgAtividade = ;


  String dropdownValue = 'P';
  String vdropdownValue= 'F';

  String dropdownValueTipo = 'DI';
  String vdropdownValueTipo = 'MD';



  final _ffuncionarioController = TextEditingController();
  final _ffdataController = TextEditingController();

  final _fcoordenadorController = TextEditingController();
  final _fservicoController = TextEditingController();
  final _ftarefaController = TextEditingController();
  final _fquantidadeController = TextEditingController();
  final _fplataformaController = TextEditingController();
  final _fromaneioController = TextEditingController();
  final _fchaveController = TextEditingController();
  final _fexportado = TextEditingController();

   FocusNode _textFocus = new FocusNode();





  Future<bool> _validarDados()  async {
    int idcontroler ;
    print("inicio salvar ");
    bool retorno = true;

    if ( atividadecontroler == null ){
      print("esta nulo");
      idcontroler = 0;
    }
    else
      {
        idcontroler = atividadecontroler.id_ativ;
      }



    Toast.show("widget: "+ widget.text, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);


    int funcionario =  _ffuncionarioController.text.isNotEmpty ?  int.parse( _ffuncionarioController.text )  : 0 ;

    int pano = int.parse( _date.text.substring(6,10));
    int mes = int.parse( _date.text.substring(3,5));
    int dia = int.parse( _date.text.substring(0,2));
    DateTime selDate = new DateTime.utc(pano,mes,dia, 00, 00, 00);
    int coordenador = _fcoordenadorController.text.isNotEmpty ? int.parse( _fcoordenadorController.text ) : 0 ;
    String presenca = vdropdownValue;

    int servico = _fservicoController.text.isNotEmpty ?  int.parse( _fservicoController.text ) : 0;

    int tarefa = _ftarefaController.text.isNotEmpty ? int.parse( _ftarefaController.text ) : 0;

    double quantidade = _fquantidadeController.text.isNotEmpty ? double.parse(_fquantidadeController.text) : 0;

    String tipo = vdropdownValueTipo;

    int plataforma = _fplataformaController.text.isNotEmpty ?  int.parse( _fplataformaController.text ) : 0;

    int romaneio = _fromaneioController.text.isNotEmpty ? int.parse( _fromaneioController.text ) : 0;

    String pchave = _fchaveController.text.isNotEmpty ?  _fchaveController.text : "0";

    int arvores = 0;
    String faze = "";
    

    //validar campos
    
    List<Fazenda> listfaz = await db.getfazenda(widget.usu.faze_usua); //) db.getAllFuncionario();
    if (listfaz.isEmpty ) {
      retorno = false;
      print("fazenda invalida");
      Toast.show("Ffazenda invalida", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

    }
    else
      {
        faze = widget.usu.faze_usua;// listfaz[0].id_faze;
      }

    if ( selDate == null){
      retorno = false;
      Toast.show("data inválida", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }
      // db.getFuncionario(funcionario).then(funciona = Funcionario.fromMap.map((i)=>Photo.fromJson(i)).toList(););



    //print("antes lista");
    List<Funcionario> listfunc = await db.getFuncionario(funcionario); //) db.getAllFuncionario();
    if (listfunc.isEmpty ) {
      retorno = false;
      print("func invalido: $funcionario"  );
      Toast.show("Funcionário inválido", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

    }


   //List<Atividade> listativ = await db.getAtividadeById(funcionario); //) db.getAllFuncionario();

    List<Funcionario> listcoord = await db.getCoordenador(coordenador); //) db.getAllFuncionario();
    if (listfunc.isEmpty ) {
      retorno = false;
      print("coord invalido $coordenador");
      Toast.show("Coordenador inválido", context, duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
    }


    List<Servico> listserv = await db.getServico(servico) ; //) db.getAllFuncionario();
    if (listserv.isEmpty ) {
      retorno = false;
      print("servico invalido $servico");
      Toast.show("Serviço inválido", context, duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
    }

    List<Tarefa> listtarefa = await db.getTarefa(tarefa) ;
    if ( listtarefa.isEmpty ) {
      retorno = false;
      print("tarefa invalida $tarefa");
      Toast.show("Tarefa inválida", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }
    else
      {
        if ((_fservicoController.text=="157" || _fservicoController.text=="156"  ) && (quantidade >0 )){
            arvores = quantidade.round();
           }

      }

    if ( plataforma < 0  ) {
      print("plataforma invalida");
      retorno = false;
      Toast.show("Plataforma deve ser maior ou igual a zero", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }

    if ( romaneio < 0  ) {
      print("roma invalido $tarefa");
      retorno = false;
      Toast.show("Romaneio deve ser maior ou igual a zero", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }


    if ( quantidade < 0  ) {
      print("quantidade invalida");
      retorno = false;
      Toast.show("Quantidade deve ser maior ou igual a zero", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }

      print("RETORNO: $retorno");
     if (retorno){

        Atividade atividade = new Atividade();
        atividade.ativ_faze = faze;

        atividade.data_ativ = new DateFormat("dd-MM-yyyy").format(selDate)  ;
        atividade.chapa_ativ = funcionario;
        atividade.coord_ativ = coordenador;
        atividade.pres_ativ = presenca;
        atividade.serv_ativ = servico;
        atividade.tarefa_ativ = tarefa;
        atividade.arvore_ativ =arvores;
        atividade.qtd_ativ = quantidade;
        atividade.sang_ativ = tipo;
        atividade.plat_ativ = plataforma;
        atividade.roma_ativ = romaneio;
        //atividade.chavexp = chavexp;

       if (idcontroler> 0 ) //se existir dados na classe update , se nao insert
       {
         if ( idcontroler > 0 ){
           print("id up: "+idcontroler.toString());
         atividade.id_ativ = idcontroler ;

         atividade.chavexp =  pchave;

           String pexportado = _fexportado.text.isNotEmpty ?  _fexportado.text : "N";

         atividade.exportado = pexportado;
         print("update exportado: "+ atividade.exportado);
         _updateDados(atividade); }

       }

        print("id ativ salvar: "+idcontroler.toString());
        if (idcontroler == 0 ) {

          int novoid =  await db.getNewIdAtividade() ;
          if (novoid == null) {
            novoid = 1;
          }
          print("Novo id: $novoid");
           atividade.id_ativ = novoid ;
           //pegar func + coord +serv + datahora = chave

          String horaatual = (new DateFormat("yyyy-MM-dd hh:mm:ss").format(new DateTime.now()));
          horaatual = horaatual.replaceAll("-","");
          horaatual = horaatual.replaceAll(":","");
          horaatual = horaatual.replaceAll(" ","");
          print("horaatual: "+horaatual.trim());
          atividade.chavexp = funcionario.toString() + coordenador.toString()+ servico.toString() +horaatual.toString().trim();// + DATALANC + TAREFA
          print("chave classe: "+atividade.chavexp);
          atividade.exportado = "N";
          print("insert exportado: "+ atividade.exportado);
           _saveDados(atividade);
         }


     }
     return retorno;

  }//validar dados

  void _saveDados(Atividade atividade){
    db.newAtividade(atividade);
    Toast.show("Registro efetuado com êxito", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  void _updateDados(Atividade atividade){
    db.updateAtividade(atividade);
    Toast.show("Registro efetuado com êxito", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

   DateTime selectedDate = DateTime.now();
   TextEditingController _date = new TextEditingController();

   Future<Null> _selectDate(BuildContext context) async {
     final DateTime picked = await showDatePicker(
         context: context,

         initialDate: selectedDate,
         firstDate: DateTime(2019, 12),
         lastDate: DateTime(2100));
     if (picked != null && picked != selectedDate)
       setState(() {
         selectedDate = picked;
         //new DateFormat("dd-MM-yyyy").format(picked);
         //_date.value = TextEditingValue(text: picked.toString());
         _date.value = TextEditingValue(text:new DateFormat("dd-MM-yyyy").format(picked));
       });
   }

   void _novaData( DateTime pData) {
     _date.text = pData.toString();
   }

   void iniciarDados(){
     Atividade aux = new Atividade();
     atividadecontroler = null;
     aux.id_ativ = 0;
     widget.atividadew = aux;
     _fcoordenadorController.text = widget.usu.chapa_usua.toString();

     String horaatual = (new DateFormat("dd-MM-yyyy").format(new DateTime.now()));//(new DateFormat.yMd().format(new DateTime.now())  );//(new DateFormat("yyyy-MM-dd hh:mm:ss").format(new DateTime.now()));
     print("dataatual: "+horaatual);
     print("dia: "+horaatual.substring(0,2));
     print("mes: "+horaatual.substring(3,5));
     print("ano: "+horaatual.substring(6,10));

     int pano = int.parse(horaatual.substring(6,10));
     int mes = int.parse( horaatual.substring(3,5));
     int dia = int.parse( horaatual.substring(0,2));

     //DateTime pDatapar = new DateTime.utc(pano,mes,dia, 00, 00, 00);
     _date.value  = TextEditingValue(text:new DateFormat("dd-MM-yyyy").format(new DateTime.now()));
     //DateTime pDataparam = DateTime.parse(widget.atividadew.data_ativ);
     //_novaData( _date );

     _fcoordenadorController.text = widget.usu.chapa_usua.toString();
     
     vdropdownValue = "P";

     vdropdownValueTipo = "DI";
     _fplataformaController.text = "0";
     _fromaneioController.text =  "0";

   }
   int _counter;



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Atividade'),
          centerTitle: true,
          backgroundColor: Color(0XFF4CAF50),
        ),
        body: Center(
           child: Container(
             height: SizeConfig.safeBlockVertical * 100,
             width: SizeConfig.safeBlockHorizontal * 100,
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              color: Colors.white,
              child: ListView(
                  children: <Widget>[

                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _date,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'Data',
                            prefixIcon: Icon(
                              Icons.dialpad,
                              color: Color(0XFF4CAF50),
                            ),
                          ),
                        ),
                      ),
                    ),

                    TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.number,
                      controller: _ffuncionarioController,
                      //onChanged: (v) => _ffuncionarioController.text = v,

                      decoration: InputDecoration(
                        labelText: "Funcionario",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    TextFormField(
                      // autofocus: true,
                      keyboardType: TextInputType.number,
                      controller: _fcoordenadorController,
                     // onChanged: (v) => _fcoordenadorController.text = v,

                      decoration: InputDecoration(
                        labelText: "Coordenador",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Presenca',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),


                    DropdownButton<String>(

                      value: vdropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          vdropdownValue = newValue;
                        });
                      },
                      items: <String>['P', 'F',]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    TextFormField(
                      // autofocus: true,
                      controller: _fservicoController,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Servico",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    TextFormField(
                      // autofocus: true,
                      controller: _ftarefaController,
                      focusNode: myFocusNode,
                      //onChanged: (v) => _ftarefaController.text = v,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Tarefa",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    TextFormField(
                      // autofocus: true,
                      controller: _fquantidadeController,
                      //onChanged: (v) => _fquantidadeController.text = v,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Quantidade",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    Text(
                      'Tipo Sangria',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    DropdownButton<String>(

                      value: vdropdownValueTipo,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          vdropdownValueTipo = newValue;
                        });
                      },
                      items: <String>['DI', 'MD','NS']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),



                    TextFormField(
                      // autofocus: true,
                      controller: _fplataformaController,
                      //onChanged: (v) => _fplataformaController.text = v,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Plataforma",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),

                    TextFormField(
                      // autofocus: true,
                      controller: _fromaneioController,
                     // onChanged: (v) => _fromaneioController.text = v,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Romaneio",
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),



                    SizedBox(
                      height: 30,

                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical * 10,
                      //width: MediaQuery.of(context).size.width,
                      width: SizeConfig.safeBlockHorizontal * 90,
                      //height: 60,

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
                          Radius.circular(10), //tornar botao circular
                        ),
                      ),
                      child: SizedBox.expand(

                          child: new Center(
                              // novo container
                            child: Container(
                              height: SizeConfig.safeBlockVertical *100,
                              //width: MediaQuery.of(context).size.width,
                              width: (SizeConfig.safeBlockHorizontal * 100),
                              child: new Row(
                                //spaceBetween
                                mainAxisAlignment: MainAxisAlignment.center,
                                //teste
                                children: [
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                   // width: ( ( (SizeConfig.safeBlockHorizontal * 95) - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25) ,
                                    //color: Colors.yellow,
                                      child: new IconButton(
                                        icon: new Image.asset("assets/plus.png"),
                                        tooltip: 'Novo',
                                        onPressed: () {
                                          limparDados();
                                          iniciarDados();

                                          },
                                         ),
                                   ),
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                    // width: ( ( (SizeConfig.safeBlockHorizontal * 95) - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25) ,
                                    //color: Colors.yellow,
                                    child: new IconButton(
                                      icon: new Image.asset("assets/gravar.jpeg"),
                                      tooltip: 'Gravar',
                                      onPressed: () async {
                                        bool val = await  _validarDados();
                                        if ( val ) {
                                          print("ok");
                                          print("widget: "+ widget.text);
                                          widget.text = "P" ;//gravado
                                        }
                                        else
                                        {
                                          Toast.show("Dados estao incorretos", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                          print("invalido");
                                        }

                                      },
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                    // width: ( ( (SizeConfig.safeBlockHorizontal * 95) - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25) ,
                                    //color: Colors.yellow,
                                    
                                    child: new IconButton(
                                      icon: new Image.asset("assets/pesquisa.png"),
                                      tooltip: 'Pesquisar',
                                      onPressed: () async {
                                        Atividade vatividade = await  Navigator.push(  context, MaterialPageRoute(builder: (context) => ListaAtividadePage(widget.usu)),   );
                                        widget.text = "U" ;//gravado
                                        // print("widget: " + widget.text);
                                        print("retorno pop");
                                        print(" 1 obj id: "+vatividade.id_ativ.toString());
                                        widget.atividadew= vatividade;
                                        if (vatividade.id_ativ > 0 ) {
                                          preencherDados(widget.atividadew);
                                          print(" 2 obj id: " +
                                              widget.atividadew.id_ativ.toString());

                                        }

                                        setStateAtividade();
                                        //state
                                        print("State: reiniciar");
                                        //await  initState();

                                      },
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                    // width: ( ( (SizeConfig.safeBlockHorizontal * 95) - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25) ,
                                    //color: Colors.yellow,
                                    child: new IconButton(
                                      icon: new Image.asset("assets/tarefa.jpeg"),
                                      tooltip: 'Tarefa',
                                      onPressed: () async {
                                        int tarefa1 = _ftarefaController.text.isNotEmpty ? int.parse( _ftarefaController.text ) : 0;
                                        if ( tarefa1 > 0 ){

                                          List<Tarefa> listtarefa1 = await db.getTarefa(tarefa1) ;
                                          if ( listtarefa1.isEmpty ) {

                                            print("tarefa invalida $tarefa1");
                                            Toast.show("Tarefa inválida", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                          }
                                          else
                                          {
                                            _fquantidadeController.text = listtarefa1[0].qtd_tarefa.toString();

                                          }



                                        }
                                        FocusScope.of(context).requestFocus(myFocusNode);


                                      },
                                    ),
                                  ),


                                    /*
                                    child: new FlatButton(onPressed: () {

                                      limparDados();
                                      iniciarDados();


                                    },

                                      child: new Text('Novo'
                                          ,style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: SizeConfig.safeBlockHorizontal*4
                                            //fontSize: 17,
                                          ),
                                        )),
                                          // fim novo


                                  ),
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                    //width: MediaQuery.of(context).size.width/4,
                                    //width: ( ( (SizeConfig.safeBlockHorizontal * 95) - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25) ,
                                    //color: Colors.blue,
                                    child: new FlatButton(onPressed: () async {
                                      bool val = await  _validarDados();
                                      if ( val ) {
                                        print("ok");
                                        print("widget: "+ widget.text);
                                        widget.text = "P" ;//gravado
                                      }
                                      else
                                      {
                                        Toast.show("Dados estao incorretos", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                        print("invalido");
                                      }
                                    },
                                        child: new Text('Salvar'
                                          ,style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              //fontSize: 17,
                                              fontSize: SizeConfig.safeBlockHorizontal*4
                                          ),
                                        )),
                                  ),
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                    //width: MediaQuery.of(context).size.width/4,
                                   // width: ( (MediaQuery.of(context).size.width - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25),
                                    //width: ( ( (SizeConfig.safeBlockHorizontal * 95) - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25) ,
                                    //color: Colors.greenAccent,
                                    child:new FlatButton(onPressed: () async {

                                      Atividade vatividade = await  Navigator.push(  context, MaterialPageRoute(builder: (context) => ListaAtividadePage(widget.usu)),   );
                                      widget.text = "U" ;//gravado
                                      // print("widget: " + widget.text);
                                      print("retorno pop");
                                      print(" 1 obj id: "+vatividade.id_ativ.toString());
                                      widget.atividadew= vatividade;
                                      if (vatividade.id_ativ > 0 ) {
                                        preencherDados(widget.atividadew);
                                        print(" 2 obj id: " +
                                            widget.atividadew.id_ativ.toString());

                                      }

                                      setStateAtividade();
                                      //state
                                      print("State: reiniciar");
                                      //await  initState();

                                    },


                                        child: new Text('Busca'
                                          ,style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: SizeConfig.safeBlockHorizontal*4
                                            //fontSize: 17,
                                          ),
                                        )),
                                  ),
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal * 20,
                                   // width: MediaQuery.of(context).size.width/4,
                                                                      //width: ( (MediaQuery.of(context).size.width - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25),
                                    //width: ( ( (SizeConfig.safeBlockHorizontal * 95) - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25) ,
                                    //color: Colors.amberAccent,
                                    child:  new FlatButton(onPressed: () async {
                                      int tarefa1 = _ftarefaController.text.isNotEmpty ? int.parse( _ftarefaController.text ) : 0;
                                      if ( tarefa1 > 0 ){

                                        List<Tarefa> listtarefa1 = await db.getTarefa(tarefa1) ;
                                        if ( listtarefa1.isEmpty ) {

                                          print("tarefa invalida $tarefa1");
                                          Toast.show("Tarefa inválida", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                        }
                                        else
                                        {
                                          _fquantidadeController.text = listtarefa1[0].qtd_tarefa.toString();

                                        }



                                      }
                                      FocusScope.of(context).requestFocus(myFocusNode);
                                      // Toast.show("Focus Second Text Field", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);


                                      // if (widget.atividadew.id_ativ > 0 ) {
                                      //   await db.deleteAtividadeById(widget.atividadew.id_ativ);
                                      // }


                                    },
                                        child: new Text('Tarefa'
                                          ,style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              //fontSize: 17,
                                              fontSize: SizeConfig.safeBlockHorizontal*4
                                          ),
                                        )),
                                    */
                                    // fim tarefa
                                 // ),
                                ],

                                // inicio widget
                                /*
                                children: <Widget>[
                                  //dart treates everything as objects so we pass a function in onPressed value

                                  new FlatButton(onPressed: () {

                                    limparDados();
                                    iniciarDados();


                                  },

                                      child: new Text('Novo'

                                        ,style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: SizeConfig.safeBlockHorizontal*4
                                          //fontSize: 17,
                                        ),
                                      )),
                                  new FlatButton(onPressed: () async {
                                    bool val = await  _validarDados();
                                    if ( val ) {
                                      print("ok");
                                      print("widget: "+ widget.text);
                                      widget.text = "P" ;//gravado
                                    }
                                    else
                                    {
                                      Toast.show("Dados estao incorretos", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                      print("invalido");
                                    }
                                  },
                                      child: new Text('Salvar'
                                        ,style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          //fontSize: 17,
                                         fontSize: SizeConfig.safeBlockHorizontal*4
                                        ),
                                           )),
                                  new FlatButton(onPressed: () async {

                                    Atividade vatividade = await  Navigator.push(  context, MaterialPageRoute(builder: (context) => ListaAtividadePage(widget.usu)),   );
                                        widget.text = "U" ;//gravado
                                       // print("widget: " + widget.text);
                                        print("retorno pop");
                                        print(" 1 obj id: "+vatividade.id_ativ.toString());
                                        widget.atividadew= vatividade;
                                        if (vatividade.id_ativ > 0 ) {
                                          preencherDados(widget.atividadew);
                                          print(" 2 obj id: " +
                                              widget.atividadew.id_ativ.toString());

                                        }

                                       setStateAtividade();
                                    //state
                                        print("State: reiniciar");
                                         //await  initState();

                                       },


                                      child: new Text('Busca'
                                        ,style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: SizeConfig.safeBlockHorizontal*4
                                          //fontSize: 17,
                                        ),
                                      )),
                                  new FlatButton(onPressed: () async {
                                    int tarefa1 = _ftarefaController.text.isNotEmpty ? int.parse( _ftarefaController.text ) : 0;
                                    if ( tarefa1 > 0 ){

                                      List<Tarefa> listtarefa1 = await db.getTarefa(tarefa1) ;
                                      if ( listtarefa1.isEmpty ) {

                                        print("tarefa invalida $tarefa1");
                                        Toast.show("Tarefa inválida", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                                      }
                                      else
                                      {
                                        _fquantidadeController.text = listtarefa1[0].qtd_tarefa.toString();

                                      }



                                    }
                                    FocusScope.of(context).requestFocus(myFocusNode);
                                   // Toast.show("Focus Second Text Field", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);


                                   // if (widget.atividadew.id_ativ > 0 ) {
                                   //   await db.deleteAtividadeById(widget.atividadew.id_ativ);
                                   // }


                                  },
                                      child: new Text('Tarefa'
                                        ,style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          //fontSize: 17,
                                          fontSize: SizeConfig.safeBlockHorizontal*4
                                        ),
                                      )),

                                  //aki focus

                                  //fim focus

                                ],
                               */ //fim widget
                              ),

                            )
                            //fim novo container
                          )

                      ),
                    ),

                  ]
              ),
            )
          )//center
    );
  }



}



