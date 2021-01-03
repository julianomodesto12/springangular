import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sgihevea/model/Atividade.dart';

import 'AtividadeOrig.dart';
import 'FuncionariosRM.dart';
import 'Servico.dart';
import 'Tarefa.dart';

import 'package:sgihevea/dao/DatabaseHelper.dart';

class Exportacao {

  final String urlpadrao = "http://138.197.170.221:8081/api";
  final db = DatabaseHelper.instance;

  Future<void> postDataAtividade(AtividadeOrig atividadeorig) async {
    String url = "$urlpadrao/atividades";

    await http
        .post(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: (atividadeorig.AtividadeOrigToJson(atividadeorig)))
        .then((response) async {
      if ((response.statusCode == 201) || (response.statusCode == 200) ) {

        print('post exportacao Response status : ${response.statusCode}');
        print('post exportacaoResponse body : ${response.body}');

        Atividade pativ = new Atividade();
        pativ.id_ativ = atividadeorig.id_ativ;
        pativ.ativ_faze  = atividadeorig.ativ_faze;
        pativ.data_ativ  = atividadeorig.data_ativ;
        pativ.chapa_ativ  = atividadeorig.chapa_ativ;
        pativ.coord_ativ  = atividadeorig.coord_ativ;
        pativ.pres_ativ  = atividadeorig.pres_ativ;
        pativ.serv_ativ  = atividadeorig.serv_ativ;
        pativ.tarefa_ativ  = atividadeorig.tarefa_ativ;
        pativ.arvore_ativ  = atividadeorig.arvore_ativ;
        pativ.qtd_ativ  = atividadeorig.qtd_ativ;
        pativ.sang_ativ  = atividadeorig.sang_ativ;
        pativ.plat_ativ  = atividadeorig.plat_ativ;
        pativ.roma_ativ  = atividadeorig.roma_ativ;
        pativ.chavexp  = atividadeorig.chavexp;
        pativ.exportado = "S";

        await db.updateAtividade(pativ);


      } else {
        throw Exception('Failed post');
      }
    });
  }

/*
  Future <void>  exportarListaAtividade() async {

    List<Atividade> listAtiv = await db.getAllAtividade();
    listAtiv.toList();
    listAtiv.forEach((ativid) async {
      //ativid.chavexp = "";
      String pchave =  ativid.chavexp;
      print("chavexp: "+pchave);
      //await postDataAtividade(ativid);

      bool v = await existeAtividade(pchave);
      print("v : "+v.toString());
      if (!v) {
        await postDataAtividade(ativid);
      }
      else
        {
          print("chave ja existe: "+pchave);
        }

    });
  }
*/
  Future <void>  exportarListaAtividadeId( int pId ) async {

    List<Atividade> listAtiv = await db.getAtividadeById(pId);
    listAtiv.toList();
    listAtiv.forEach((ativid) async {
      //ativid.chavexp = "";
      String pchave =  ativid.chavexp;
      print("chavexp: "+pchave);
      //await postDataAtividade(ativid);

      bool v = await existeAtividade(pchave);
      print("v : "+v.toString());
      if (!v) {
        AtividadeOrig ativorig = new AtividadeOrig();

        ativorig.id_ativ = ativid.id_ativ;
        ativorig.ativ_faze  = ativid.ativ_faze;
        ativorig.data_ativ  = ativid.data_ativ;
        ativorig.chapa_ativ  = ativid.chapa_ativ;
        ativorig.coord_ativ  = ativid.coord_ativ;
        ativorig.pres_ativ  = ativid.pres_ativ;
        ativorig.serv_ativ  = ativid.serv_ativ;
        ativorig.tarefa_ativ  = ativid.tarefa_ativ;
        ativorig.arvore_ativ  = ativid.arvore_ativ;
        ativorig.qtd_ativ  = ativid.qtd_ativ;
        ativorig.sang_ativ  = ativid.sang_ativ;
        ativorig.plat_ativ  = ativid.plat_ativ;
        ativorig.roma_ativ  = ativid.roma_ativ;
        ativorig.chavexp  = ativid.chavexp;

        await postDataAtividade(ativorig);

        //ativid.exportado = "S";
        //await db.updateAtividade(ativid);
      }
      else
      {
        print("chave ja existe: "+pchave);
      }

    });
  }


  Future <List<AtividadeOrig>> getDataAtividade(String url) async {


    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    print("url: "+url);
    print("ant atividadeList ");
    List atividadeList = null;
    List<AtividadeOrig> atividades = [];
    if (response.statusCode==404){
       print("status cod erro 404");
    }
    else
      {
        atividadeList =jsonDecode(response.body);
        print("pos atividadeList ");
        for (var atividade in atividadeList) {
          print("atividade chv: "+atividade.toString());
          var jsonData = atividade;
          AtividadeOrig atividade1 =    AtividadeOrig.fromMap(jsonData);

          atividades.add(atividade1);
        }
      }



    return atividades;
  }

  Future <bool> existeAtividade(String chave) async {
    bool retorno = false;
    String urlteste = "$urlpadrao/atividades/chave/$chave";
    print("url antes getdatata: "+urlteste );
    List<AtividadeOrig > ativiList = await  getDataAtividade("$urlpadrao/atividades/chave/$chave");

    if (ativiList.isNotEmpty) {
      retorno = true;

    }

    return retorno;

  }// verifica exportacao existente

}