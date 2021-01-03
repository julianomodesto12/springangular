import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:oficinamobile/dao/DatabaseHelper.dart';
import 'package:oficinamobile/model/HoraTecnica.dart';

import 'HoraTecnicaExp.dart';



class Exportacao {

  final String urlpadrao = "http://138.197.170.221:8084/api";
  final db = DatabaseHelper.instance;

  Future<void> postDataHoraTecnica(HoraTecnica horatec) async {
    String url = "$urlpadrao/horatecnica";

    await http
        .post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: (horatec.HoraTecnicaToJson(horatec)))
        .then((response) async {
      if ((response.statusCode == 201) || (response.statusCode == 200) ) {

        print('post exportacao Response status : ${response.statusCode}');
        print('post exportacaoResponse body : ${response.body}');
        HoraTecnica hrtec = new HoraTecnica();

        hrtec.hoteCodigo = horatec.hoteCodigo  ;
        hrtec.hoteData = horatec.hoteData  ;
        hrtec.funcCod = horatec.funcCod;
        hrtec.funcChapa = horatec.funcChapa;
        hrtec.tipo = horatec.tipo;
        hrtec.ithoCodigo = horatec.ithoCodigo;
        hrtec.orseCodigo = horatec.orseCodigo;
        hrtec.compCodigo = horatec.compCodigo;
        hrtec.mohaCodigo = horatec.mohaCodigo;
        hrtec.ithoHorainicio = horatec.ithoHorainicio;
        hrtec.ithoHorafim = horatec.ithoHorafim;
        hrtec.valorhora = horatec.valorhora;
        hrtec.chavexp = horatec.chavexp;
        hrtec.osEncerrar = horatec.osEncerrar;

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
        hrtecexp.exportado ="S";

        await db.updateHoraTecnicaExp(hrtecexp);


      } else {
        throw Exception('Failed post');
      }
    });
  }


  Future <List<HoraTecnica>> getDataHoraTecnica(String url) async {


    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    print("url: "+url);

    List horatecList = null;
    List<HoraTecnica> ListHoratec = [];
    if (response.statusCode==404){
      print("status cod erro 404 ERRO HORA TECNICA");
    }
    else
    {
      horatecList =jsonDecode(response.body);

      for (var vhoratec in horatecList) {

        var jsonData = vhoratec;
        HoraTecnica horatec1 =    HoraTecnica.fromMap(jsonData);

        ListHoratec.add(horatec1);
      }
    }



    return ListHoratec;
  }




  Future <bool> existeHoraTecnica(String chave) async {
    bool retorno = false;

    String urlteste = "$urlpadrao/horatecnica/chave/$chave";
    print("url antes getdatata: "+urlteste );
    List<HoraTecnica > hrtecList = await  getDataHoraTecnica("$urlpadrao/horatecnica/chave/$chave");



    if (hrtecList.isNotEmpty) {
      retorno = true;

    }

    return retorno;

  }// verifica exportacao existente


  Future <void>  exportarListaHoraTecnicaChave( int id ) async {

    List<HoraTecnica> listHora = await db.getHoraTecnica(id);
    listHora.toList();
    listHora.forEach((hrtec) async {
      //ativid.chavexp = "";
      String pchave = hrtec.chavexp;
      print("chavexp: " + pchave);
      //await postDataAtividade(ativid);

      bool v = await existeHoraTecnica(pchave);
      print("v : " + v.toString());
      if (!v)
      {
        await postDataHoraTecnica(hrtec);
        }

      });




  }

  //put
  Future<void> putDataHoraTecnica(HoraTecnica horatec) async {
    String pChave = horatec.chavexp;
    String url = "$urlpadrao/horatecnica/encerramento/$pChave";

    await http
        .put(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: (horatec.HoraTecnicaToJson(horatec)))
        .then((response) async {
      if ((response.statusCode >= 201) && (response.statusCode <= 299) ) {

        print('post exportacao Response status : ${response.statusCode}');
        print('post exportacaoResponse body : ${response.body}');
        HoraTecnica hrtec = new HoraTecnica();

        hrtec.hoteCodigo = horatec.hoteCodigo  ;
        hrtec.hoteData = horatec.hoteData  ;
        hrtec.funcCod = horatec.funcCod;
        hrtec.funcChapa = horatec.funcChapa;
        hrtec.tipo = horatec.tipo;
        hrtec.ithoCodigo = horatec.ithoCodigo;
        hrtec.orseCodigo = horatec.orseCodigo;
        hrtec.compCodigo = horatec.compCodigo;
        hrtec.mohaCodigo = horatec.mohaCodigo;
        hrtec.ithoHorainicio = horatec.ithoHorainicio;
        hrtec.ithoHorafim = horatec.ithoHorafim;
        hrtec.valorhora = horatec.valorhora;
        hrtec.chavexp = horatec.chavexp;
        hrtec.osEncerrar = horatec.osEncerrar;

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
        hrtecexp.exportado ="S";

        await db.updateHoraTecnicaExp(hrtecexp);


      } else {
        throw Exception('Failed post');
      }
    });
  }

}