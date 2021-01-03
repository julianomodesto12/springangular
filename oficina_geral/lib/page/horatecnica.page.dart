
import 'dart:async';

import 'package:flutter/material.dart';



import 'package:intl/intl.dart';
import 'package:oficinamobile/dao/DatabaseHelper.dart';
import 'package:oficinamobile/model/Componente.dart';
import 'package:oficinamobile/model/HoraTecnica.dart';
import 'package:oficinamobile/model/HoraTecnicaExp.dart';
import 'package:oficinamobile/model/Motivo.dart';
import 'package:oficinamobile/model/OrdemServico.dart';
import 'package:oficinamobile/model/Usuario.dart';
import 'package:oficinamobile/model/Funcionario.dart';


import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

import '../sizeconfig.dart';
import 'listahoratecnica.page.dart';




/// This Widget is the main application widget.
class HoraTecnicaPage extends StatelessWidget {
  //passar parametro para page stateless
  final Usuario usuario;
  final HoraTecnica _horaTecnica;


  HoraTecnicaPage(this.usuario , this._horaTecnica);




  @override
  Widget build(BuildContext context ) {


    return  Scaffold(

      body: new MyStatefulWidget(text :"I", usu : this.usuario , horatecnicaw: this._horaTecnica  ),
    );

  }

}



class MyStatefulWidget extends StatefulWidget  {
  //pegar parametro originario do page stateless, acrescentado nome parametros e @required
  String text ;
  final Usuario usu ;
  HoraTecnica horatecnicaw;

  MyStatefulWidget({Key key, @required this.text,  @required this.usu , @required this.horatecnicaw }) : super(key: key);


  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>  {

  HoraTecnica horatecnicacontroler = null;

  String ptexto ;

  FocusNode myFocusNode;



  void limparDados(){
    _fhoteCodigo.clear();
    _funcCod.clear();
    _funcChapa.clear();
    _hoteData.clear();
    _tipo.clear();
    _ithoCodigo.clear();
    _orseCodigo.clear();
    _compCodigo.clear();
    _mohaCodigo.clear();
    _ithoHorainicio .clear();
    _ithoHorafim.clear();
    _valorhora.clear();
    _osEncerrar.clear();
    _chavexp.clear();

  }

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

  void preencherDataTime(HoraTecnica fhoratecnica){
    int pano = int.parse( fhoratecnica.hoteData.substring(6,10));
    int mes = int.parse( fhoratecnica.hoteData.substring(3,5));
    int dia = int.parse( fhoratecnica.hoteData.substring(0,2));
    print("preencher data pos dia mes ano ");

    DateTime pDataparam = new DateTime.utc(pano,mes,dia, 00, 00, 00);
    print("preencher  pDataparam ");
    //DateTime pDataparam = DateTime.parse(widget.horatecnicaw.data_ativ);
    _date.value  = TextEditingValue(text:new DateFormat("dd-MM-yyyy").format(pDataparam));
  }

  void preencherDados(HoraTecnica fhoratecnica){
    _fhoteCodigo.text = fhoratecnica.hoteCodigo.toString();
    //DateTime selectedDate =   date2;
    _funcCod.text = fhoratecnica.funcCod.toString();
    _funcChapa.text = fhoratecnica.funcChapa.toString();
    _hoteData.text = fhoratecnica.hoteData.toString();
    _tipo.text = fhoratecnica.tipo.toString();
    dropdownValue = fhoratecnica.tipo.toString();
    vdropdownValue= fhoratecnica.tipo.toString();
    _ithoCodigo.text = fhoratecnica.ithoCodigo.toString();
    _orseCodigo.text = fhoratecnica.orseCodigo.toString();
    _compCodigo.text = fhoratecnica.compCodigo.toString();
    _mohaCodigo.text = fhoratecnica.mohaCodigo.toString();
    // desmembrar hora e min
    int hrini = fhoratecnica.ithoHorainicio;
    int hrfim = fhoratecnica.ithoHorafim;

    _ithoHorainicio.text = convertNumeroHora(hrini) ;
    _ithoHorafim.text = convertNumeroHora(hrfim) ;

    _valorhora.text = fhoratecnica.valorhora.toString();
    _osEncerrar.text = fhoratecnica.osEncerrar;
    _chavexp.text = fhoratecnica.chavexp.toString();


    int pano = int.parse( fhoratecnica.hoteData.substring(6,10));
    int mes = int.parse( fhoratecnica.hoteData.substring(3,5));
    int dia = int.parse( fhoratecnica.hoteData.substring(0,2));
    print("preencher data pos dia mes ano ");

    DateTime pDataparam = new DateTime.utc(pano,mes,dia, 00, 00, 00);
    print("preencher  pDataparam ");
    //DateTime pDataparam = DateTime.parse(widget.horatecnicaw.data_ativ);
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

    print(widget.horatecnicaw.hoteCodigo);
    print("if");
    if (widget.horatecnicaw.hoteCodigo > 0 ){
      print("pos if");

      preencherDados(widget.horatecnicaw);

      print("pos preenchimento campo");

    }
    else
    {
      //_fcoordenadorController.text = widget.usu.chapa_usua.toString();
      iniciarDados();

    }
    print("myFocusNode ");
    myFocusNode = FocusNode();
    print("super.initState()");

  }

  void setStateHoraTecnica()  {
    horatecnicacontroler = widget.horatecnicaw;
  }

  void setStateHoraTecnicaInicio()  {
    horatecnicacontroler = widget.horatecnicaw;
  }


  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  final db = DatabaseHelper.instance;
  HoraTecnica _horaTecnicacad;


  String dropdownValue = '0';
  String vdropdownValue= '1';

  final _fhoteCodigo = TextEditingController();
  final _funcCod = TextEditingController();
  final _funcChapa = TextEditingController();
  final _hoteData = TextEditingController();
  final _tipo = TextEditingController();
  final _ithoCodigo = TextEditingController();
  final _orseCodigo = TextEditingController();
  final _compCodigo = TextEditingController();
  final _mohaCodigo = TextEditingController();
  final _ithoHorainicio = TextEditingController();
  final _ithoHorafim = TextEditingController();
  final _valorhora = TextEditingController();
  final _osEncerrar = TextEditingController();
  final _chavexp = TextEditingController();


  FocusNode _textFocus = new FocusNode();


  Future<bool> _validarDados()  async {
    int idcontroler ;
    print("inicio salvar ");
    bool retorno = true;

    if ( horatecnicacontroler == null ){
      print("esta nulo");
      idcontroler = 0;
    }
    else
    {
      idcontroler = horatecnicacontroler.hoteCodigo;
    }



    Toast.show("widget: "+ widget.text, context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);


    int funcchapa =  _funcChapa.text.isNotEmpty ?  int.parse( _funcChapa.text )  : 0 ;

    int pano = int.parse( _date.text.substring(6,10));
    int mes = int.parse( _date.text.substring(3,5));
    int dia = int.parse( _date.text.substring(0,2));
    DateTime selDate = new DateTime.utc(pano,mes,dia, 00, 00, 00);
    int funccod = 0 ;

    String hotedata = _hoteData.text.isNotEmpty ?  _hoteData.text : "x";
    int tipo = _tipo.text.isNotEmpty ?  int.parse( _tipo.text ) : 0;
    int ithocodigo = _ithoCodigo.text.isNotEmpty ?  int.parse( _ithoCodigo.text ) : 0;
    int orsecodigo = _orseCodigo.text.isNotEmpty ?  int.parse( _orseCodigo.text ) : 0;
    int compcodigo = _compCodigo.text.isNotEmpty ?  int.parse( _compCodigo.text ) : 0;
    int mohacodigo = _mohaCodigo.text.isNotEmpty ?  int.parse( _mohaCodigo.text ) : 0;
    //int ithohorainicio = _ithoHorainicio.text.isNotEmpty ?  int.parse( _ithoHorainicio.text ) : "";
    //int ithohorafim = _ithoHorafim.text.isNotEmpty ?  int.parse( _ithoHorafim.text ) : "";
    double valorhora = _valorhora.text.isNotEmpty ? double.parse(_valorhora.text) : 0;
    String osencerrar = _osEncerrar.text.isNotEmpty ?  _osEncerrar.text : "N";

    String chavexp = _chavexp.text.isNotEmpty ?  _chavexp.text : "0";




    //validar campos

    //validar hora inicio e termino

    if ( _ithoHorainicio.text.trim().length <=0  )
    {
      retorno = false;
      Toast.show("Preencha a hora inicial", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);

    }
    else
      {
        String phoraatual = "";
        print("before try");
        try {
          phoraatual = (new DateFormat("hh:mm:ss").format(new
          DateTime(int.parse( _date.text.substring(6,10)),
              int.parse( _date.text.substring(3,5)),
              int.parse( _date.text.substring(0,2)),
              int.parse(_ithoHorainicio.text.toString().substring(0,2)),
              int.parse(_ithoHorafim.text.toString().substring(3,5)),
              0,
              0,
              0)));

        } on Exception catch (_) {
          print("throwing new error");
          throw Exception("Hora inicial invalida");
          retorno = false;
        }


        Toast.show("Hora inicial inválida", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
      }

    if ( _ithoHorafim.text.trim().length <=0  )
    {
      retorno = false;
      Toast.show("Preencha a hora final", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);

    }
    else
    {
      String phoraatual = "";
      print("before try");
      try {
        phoraatual = (new DateFormat("hh:mm:ss").format(new
        DateTime(int.parse( _date.text.substring(6,10)),
            int.parse( _date.text.substring(3,5)),
            int.parse( _date.text.substring(0,2)),
            int.parse(_ithoHorainicio.text.toString().substring(0,2)),
            int.parse(_ithoHorafim.text.toString().substring(3,5)),
            0,
            0,
            0)));

      } on Exception catch (_) {
        print("throwing new error");
        throw Exception("Hora final invalida");
        retorno = false;
      }


      Toast.show("Hora inicial inválida", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);
    }

    if ( selDate == null){
      retorno = false;
      Toast.show("data inválida", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }
    // db.getFuncionario(funcionario).then(funciona = Funcionario.fromMap.map((i)=>Photo.fromJson(i)).toList(););



    //print("antes lista");
    List<Funcionario> listfunc = await db.getFuncionarioChapa(funcchapa); //) db.getAllFuncionario();
    if (listfunc.isEmpty ) {
      retorno = false;
      print("func invalido: $funcchapa"  );
      Toast.show("Funcionário inválido", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);

    }
    else
      {
        funccod = listfunc[0].funcCod;
      }



    print("oderm serv inicial:  $orsecodigo");
    List<OrdemServico> listordem = await db.getOrdemServicoId(orsecodigo) ; //) db.getAllFuncionario();
    if (listordem.isEmpty ) {
      retorno = false;
      print("oderm invalida $orsecodigo");
      Toast.show("Ordem servico inválida", context, duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
    }

    List<Componente> listcomponente = await db.getComponenteId(compcodigo) ;
    if ( listcomponente.isEmpty ) {
      retorno = false;
      print("Componente invalido $compcodigo");
      Toast.show("Componente invalido ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }


    List<Motivo> listmotivo = await db.getmotivosId(mohacodigo) ;
    if ( listmotivo.isEmpty ) {
      retorno = false;
      print("Motivo invalido $compcodigo");
      Toast.show("Motivo invalido ", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    }


    print("RETORNO: $retorno");
    if (retorno){

      HoraTecnica hrtecnica = new HoraTecnica();
      hrtecnica.hoteData = new DateFormat("dd-MM-yyyy").format(selDate)  ;
      hrtecnica.funcCod = funccod;
      hrtecnica.funcChapa = funcchapa;
      hrtecnica.tipo = tipo;
      hrtecnica.ithoCodigo = ithocodigo;
      hrtecnica.orseCodigo = orsecodigo;
      hrtecnica.compCodigo = compcodigo;
      hrtecnica.mohaCodigo = mohacodigo;
      int hrini = int.parse(_ithoHorainicio.text.toString().substring(0,2))*60+int.parse(_ithoHorainicio.text.toString().substring(3,5));
      int hrfim = int.parse(_ithoHorafim.text.toString().substring(0,2))*60+int.parse(_ithoHorafim.text.toString().substring(3,5));
      hrtecnica.ithoHorainicio = hrini;
      hrtecnica.ithoHorafim = hrfim;
      hrtecnica.valorhora = valorhora;





      //atividade.chavexp = chavexp;

      if (idcontroler> 0 ) //se existir dados na classe update , se nao insert
          {
        if ( idcontroler > 0 ){
          print("id up: "+idcontroler.toString());
          hrtecnica.hoteCodigo = idcontroler ;

          hrtecnica.chavexp =  chavexp;
          hrtecnica.osEncerrar = horatecnicacontroler.osEncerrar;
         // String pexportado = _fexportado.text.isNotEmpty ?  _fexportado.text : "N";



          _updateDados(hrtecnica); }

      }

      print("id ativ salvar: "+idcontroler.toString());
      if (idcontroler == 0 ) {
         //int hoteCodigo;
        int novoid =  await db.getNewIdHoraTecnica() ;
        if (novoid == null) {
          novoid = 1;
        }
        print("Novo id: $novoid");
        hrtecnica.hoteCodigo = novoid ;
        //pegar func + coord +serv + datahora = chave

        String horaatual = (new DateFormat("yyyy-MM-dd hh:mm:ss").format(new DateTime.now()));
        horaatual = horaatual.replaceAll("-","");
        horaatual = horaatual.replaceAll(":","");
        horaatual = horaatual.replaceAll(" ","");
        print("horaatual: "+horaatual.trim());

        String hrlanc = hrtecnica.hoteData.toString();
        hrlanc = hrlanc.replaceAll("-","");

        hrtecnica.chavexp = funcchapa.toString() + hrlanc + orsecodigo.toString() + hrtecnica.ithoHorainicio.toString() + hrtecnica.ithoHorafim.toString()  + horaatual.toString().trim();
        hrtecnica.osEncerrar = "N";
        //atividade.exportado = "N";

        _saveDados(hrtecnica);
      }


    }
    return retorno;

  }//validar dados

  Future _saveDados(HoraTecnica horatec) async {
    db.newHoraTecnica(horatec);
    Toast.show("Registro efetuado com êxito", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP);

    HoraTecnicaExp hrtecexp = new HoraTecnicaExp();
    hrtecexp.hoteCodigo = horatec.hoteCodigo  ;
    hrtecexp.hoteData = horatec.hoteData  ;
    hrtecexp.funcCod = horatec.funcCod;
    hrtecexp.funcChapa = horatec.funcChapa;
    hrtecexp.tipo = horatec.tipo;
    hrtecexp.ithoCodigo = horatec.ithoCodigo;
    hrtecexp.orseCodigo = horatec.orseCodigo;
    hrtecexp.compCodigo = horatec.compCodigo;
    hrtecexp.mohaCodigo = horatec.mohaCodigo;
    hrtecexp.ithoHorainicio = horatec.ithoHorainicio;
    hrtecexp.ithoHorafim = horatec.ithoHorafim;
    hrtecexp.valorhora = horatec.valorhora;
    hrtecexp.chavexp = horatec.chavexp;
    hrtecexp.osEncerrar = horatec.osEncerrar;
    hrtecexp.exportado ="N";

    await db.updateHoraTecnicaExp(hrtecexp);
  }

  void _updateDados(HoraTecnica horatec){
    db.updateHoraTecnica(horatec);



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
      setState(()  {
        selectedDate = picked;
        //new DateFormat("dd-MM-yyyy").format(picked);
        //_date.value = TextEditingValue(text: picked.toString());
        _date.value = TextEditingValue(text:new DateFormat("dd-MM-yyyy").format(picked));

        print("Data Hora tec interno 0");
        int pChapa = int.parse(_funcChapa.text);

        print("antes future inicio");
        //int hrfim  = await getNewInicioHora(_date.text.toString() ,  pChapa );
        int hrfim  = 0;
        getNewInicioHora(_date.text.toString() ,  pChapa ).then((ultimotemp) {
          hrfim = ultimotemp;
          print("then inicioo :"+hrfim.toString() );
          String hrf = convertNumeroHora(hrfim);
          _ithoHorainicio.text = hrf;
        })
            .catchError( (error) {
          print(error);
        });
        print("apos future inicio :"+_date.text.toString() );



      });
  }

  void _novaData( DateTime pData) {
    _date.text = pData.toString();
  }


  void iniciarDados(){
    HoraTecnica aux = new HoraTecnica();

    String hrini = "07:00";

    if (horatecnicacontroler == null) {
      print("Hora tecnica vazia");
      _date.value  = TextEditingValue(text:new DateFormat("dd-MM-yyyy").format(new DateTime.now()));
      _funcChapa.text = widget.usu.funcChapa.toString();
      _funcCod.text = widget.usu.funcCodigo.toString();
    }
    else
      {
        print("Hora tecnica copiada apos gravar");
        hrini =  convertNumeroHora(horatecnicacontroler.ithoHorafim);
        preencherDataTime(horatecnicacontroler);
        _funcChapa.text = horatecnicacontroler.funcChapa.toString();
        _funcCod.text = horatecnicacontroler.funcCod.toString();

      }

    horatecnicacontroler = null;
    aux.hoteCodigo = 0;
    widget.horatecnicaw = aux;

    _ithoHorainicio.text = hrini;
    String horaatual = (new DateFormat("dd-MM-yyyy").format(new DateTime.now()));//(new DateFormat.yMd().format(new DateTime.now())  );//(new DateFormat("yyyy-MM-dd hh:mm:ss").format(new DateTime.now()));


    int pano = int.parse(horaatual.substring(6,10));
    int mes = int.parse( horaatual.substring(3,5));
    int dia = int.parse( horaatual.substring(0,2));

    //DateTime pDatapar = new DateTime.utc(pano,mes,dia, 00, 00, 00);

    //DateTime pDataparam = DateTime.parse(widget.horatecnicaw.data_ativ);
    //_novaData( _date );



    vdropdownValue = "0";



  }
  int _counter;

  Future<int> getNewInicioHora(String pData , int pChapa )  async {
   int ultimaHora = 420 ;

     List<HoraTecnica>  listHoratc = await db.getUltimaHoraTec(pData ,pChapa );
    if (listHoratc.isEmpty ) {

      print("Obter ultima hora tec nao tem"  );


    }
    else
    {
      print("Obter ultima hora tec "  );
      ultimaHora = listHoratc[0].ithoHorafim;
    }

    return ultimaHora;
  }



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
                    //
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
                      controller: _funcChapa,
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


                    Text(
                      'Tipo',
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
                      items: <String>['0', '1',]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    TextFormField(
                      // autofocus: true,
                      controller: _orseCodigo ,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Ordem Servico",
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
                      controller: _compCodigo,
                      focusNode: myFocusNode,
                      //onChanged: (v) => _ftarefaController.text = v,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Componente",
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
                      controller: _mohaCodigo,
                      //onChanged: (v) => _fquantidadeController.text = v,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Motivo",
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
                      controller: _ithoHorainicio,
                      //onChanged: (v) => _fplataformaController.text = v,
                      keyboardType: TextInputType.text ,
                      decoration: InputDecoration(
                        labelText: "Hora Inicio",
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
                      controller: _ithoHorafim,
                      // onChanged: (v) => _fromaneioController.text = v,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Hora Fim",
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
                                            //pegar proxima hora
                                            widget.horatecnicaw.ithoHorainicio = int.parse(_ithoHorafim.text.toString().substring(0,2))*60+int.parse(_ithoHorafim.text.toString().substring(3,5));
                                            setStateHoraTecnicaInicio();
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

                                          HoraTecnica vhoratec = await  Navigator.push(  context, MaterialPageRoute(builder: (context) => ListaHoraTecnicaPage(widget.usu)),   );
                                          widget.text = "U" ;//gravado
                                          // print("widget: " + widget.text);

                                          widget.horatecnicaw= vhoratec;
                                          if (vhoratec.hoteCodigo > 0 ) {
                                            preencherDados(widget.horatecnicaw);
                                            print(" 2 obj id: " +
                                                widget.horatecnicaw.hoteCodigo.toString());

                                          }

                                          setStateHoraTecnica();
                                          //state

                                          //await  initState();

                                        },
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.safeBlockHorizontal * 20,
                                      // width: ( ( (SizeConfig.safeBlockHorizontal * 95) - (MediaQuery.of(context).padding.left + MediaQuery.of(context).padding.right )  )*0.25) ,
                                      //color: Colors.yellow,

                                      child: new IconButton(
                                        icon: new Image.asset("assets/encerrar3.jpeg"),
                                        tooltip: 'Encerrar',
                                        onPressed: () async {

                                          if (widget.horatecnicaw.hoteCodigo>0){
                                            widget.horatecnicaw.osEncerrar= "S";
                                            _updateDados(widget.horatecnicaw);
                                          }


                                          //state

                                          //await  initState();

                                        },
                                      ),
                                    ),



                                  ],

                          
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



