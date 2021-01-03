import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'AnualHevea.dart';
import 'AvaliacaoHevea.dart';
import 'DiariaHevea.dart';
import 'Fazenda.dart';
import 'FuncionariosRM.dart';
import 'MensalHevea.dart';
import 'Servico.dart';
import 'Tarefa.dart';

import 'package:sgihevea/model/Funcionario.dart';
import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:sgihevea/model/Usuario.dart';

class Importacao {

  final String urlpadrao = "http://138.197.170.221:8081/api";

  final db = DatabaseHelper.instance;

  Future <List<FuncionarioRM>> getDataFuncionarios(String url) async {

    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List funcionarioList = jsonDecode(response.body);
    List<FuncionarioRM> funcionarios = [];
    print("for antes restfull ");
    var i= 0;
    for (var ifuncionario in funcionarioList) {


      print("funcionario "+ifuncionario.toString());
      var jsonData = ifuncionario;
      FuncionarioRM funcionario1 =    FuncionarioRM.fromMap(jsonData);
      print("FuncionarioRM.fromMap(jsonData) ");
      funcionarios.add( funcionario1 );

      print(" matricula :"+ funcionarios[i].matricula);
      print(" nome :"+ funcionarios[i].nomefuncionario);
      print(" coord :"+ funcionarios[i].coord.toString());
      i+=1;
    }
    return funcionarios;
  }


  Future <List<Tarefa>> getDataTarefa(String url) async {
    //String myUrl = "http://192.168.0.250:8081/api/funcionariosrm/006043";
    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List tarefaList = jsonDecode(response.body);
    List<Tarefa> tarefas = [];
    var i = 0;
    for (var tarefa in tarefaList) {

      print("tarefa "+tarefa.toString());
      var jsonData = tarefa;
      Tarefa tarefa1 =   Tarefa.fromMap(jsonData);
      print("tarefa1");
      tarefas.add( tarefa1 );

      print(" tarefa1 :"+ tarefas[i].id_tarefa.toString());


      i+=1;


    }
    return tarefas;
  }

  Future <List<Servico>> getDataServicos(String url) async {
    //String myUrl = "http://192.168.0.250:8081/api/funcionariosrm/006043";
    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List servicoList = jsonDecode(response.body);
    List<Servico> servicos = [];
    var i = 0;
    for (var servico in servicoList) {

      print("servico "+servico.toString());
      var jsonData = servico;
      Servico servico1 =   Servico.fromMap(jsonData);
      print("servico");
      servicos.add( servico1 );

      print(" servicos :"+ servicos[i].id_serv.toString());

      i+=1;
    }
    return servicos;
  }

  // get data usuarios
  Future <List<Usuario>> getDataUsuarios(String url) async {

    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List usuarioList = jsonDecode(response.body);
    List<Usuario> usuarios = [];
    var i = 0;
    for (var usuario in usuarioList) {


      var jsonData = usuario;
      Usuario usuario1 =   Usuario.fromMap(jsonData);

      usuarios.add( usuario1 );



      i+=1;
    }
    return usuarios;
  }
  // fim get data usuarios

  Future <List<Fazenda>> getDataFazendas(String url) async {
    //String myUrl = "http://192.168.0.250:8081/api/funcionariosrm/006043";
    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });

    Fazenda faze = new Fazenda();
    List fazendaList = jsonDecode(response.body);



    List<Fazenda> fazendas = [];
    print("antes for fazendas");
    var i = 0;
    for (var fazend in fazendaList) {

       print("impfazenda: "+fazend.toString());
       var jsonData = fazend;
       Fazenda faz =    Fazenda.fromMap(jsonData);
       fazendas.add( faz );

      print(" id_faze :"+ fazendas[i].id_faze);
      print(" nome_faze :"+ fazendas[i].nome_faze);
      i+=1;

    }
    return fazendas;
  }

  Future <void> importarFuncionarios(String fazenda) async {
    print(" antes List<FuncionarioRM> funcionariosrm: ");
    List<FuncionarioRM> funcionariosrm = await  getDataFuncionarios("$urlpadrao/funcionarioshevea/fazenda/$fazenda");
    print(" depois List<FuncionarioRM> funcionariosrm: ");
    if (funcionariosrm.isNotEmpty) {

      for (var funcrm in funcionariosrm) {
        print(" var funcrm in funcionariosrm ");
        List<Funcionario> listfunc = await db.getFuncionario( int.parse(funcrm.matricula.trim()) );
        if (listfunc.isEmpty){
          print("listfunc.isEmpty");
          Funcionario  func = new Funcionario();
          func.id_func = int.parse(funcrm.matricula.trim()) ;
          func.chapa_func= int.parse(funcrm.matricula.trim()) ;
          func.nome_func = funcrm.nomefuncionario;
          func.coord_func = funcrm.coord;
          print("id_func: "+func.id_func.toString());
          print("chapa_func: "+func.chapa_func.toString());
          print("nome_func: "+func.nome_func);
          print("coord_func: "+func.coord_func.toString());

          //(id_func, chapa_func, nome_func, coord_func

          await db.newFuncionario(func);
          print("impor func ok: "+func.nome_func);

        }

      }


    }

  }// import funcionario

  Future <void> importarServicos() async {
    List<Servico> servicosList = await  getDataServicos("$urlpadrao/servicos");

    if (servicosList.isNotEmpty) {

      for (var servico in servicosList) {

        List<Servico> listserv = await db.getServico( servico.id_serv);
        if (listserv.isEmpty){
          Servico seriv = new Servico();
          seriv.id_serv = servico.id_serv;
          seriv.nome_serv = servico.nome_serv;
          await db.newServico(seriv);


        }

      }


    }

  }// import servicos

  // importar usuarios
  Future <void> importarUsuarios() async {
    List<Usuario> usuariosList = await  getDataUsuarios("$urlpadrao/usuarioshevea");

    if (usuariosList.isNotEmpty) {

      for (var usuario in usuariosList) {

        List<Usuario> listuser = await db.getUsuarioId (usuario.id_usua);
        if (listuser.isEmpty){
          Usuario user = new Usuario();
          user.id_usua = usuario.id_usua;
          user.login_usua = usuario.login_usua;
          user.senha_usua = usuario.senha_usua;
          user.faze_usua = usuario.faze_usua;
          user.chapa_usua = usuario.chapa_usua;

          await db.newUsuario(user);


        }

      }


    }

  }
  // fim importar usuarios

  Future <void> importarFazendas() async {
    print("antes Importr List faz");
    List<Fazenda> fazendasList = await  getDataFazendas("$urlpadrao/fazendas");
    print("depois Importr List faz");
    if (fazendasList.isNotEmpty) {
      print(" fazendasList isNotEmpty");
      for (var fazenda in fazendasList) {
        print(" for (var fazenda in fazendasList)");
        List<Fazenda> listfaz = await db.getfazenda( fazenda.id_faze);
        if (listfaz.isEmpty){
          print(" if (listfaz.isEmpty)");
          Fazenda fazenda1 = new Fazenda();
          fazenda1.id_faze = fazenda.id_faze;
          fazenda1.nome_faze = fazenda.nome_faze;
          print(" fazenda1.id_faze"+ fazenda1.id_faze);
           await db.newFazenda(fazenda1);


        }

      }


    }

  }// import servicos


  Future <void> importarTarefas(String fazenda) async {
    List<Tarefa> tarefasList = await  getDataTarefa("$urlpadrao/tarefas/fazenda/$fazenda");

    //incluir tarefa 0; para servicos sem tarefas
    List<Tarefa> listarefazero = await db.getTarefa(0);
    if (listarefazero.isEmpty) {
      Tarefa tarefazero = new Tarefa();
      tarefazero.id_tarefa = 0;
      tarefazero.qtd_tarefa = 0;
      await db.newTarefa(tarefazero);
    }


    if (tarefasList.isNotEmpty) {

      for (var vtarefa in tarefasList) {

        List<Tarefa> listarefa = await db.getTarefa(vtarefa.id_tarefa);
        if (listarefa.isEmpty){
          Tarefa tarefa = new Tarefa();
          tarefa.id_tarefa = vtarefa.id_tarefa;
          tarefa.qtd_tarefa = vtarefa.qtd_tarefa;
          await db.newTarefa(tarefa);

        }
        else {
          /* alterar arvores tarefa */
          Tarefa tarefa = new Tarefa();
          tarefa.id_tarefa = vtarefa.id_tarefa;
          tarefa.qtd_tarefa = vtarefa.qtd_tarefa;
          await db.updateTarefa(tarefa);

        }

      }


    }

  }// import tarefas


  Future <void> importarTudo(String pfazenda , int pcoord) async {

    await importarFazendas();
    print("import fazenda");
    await importarServicos();
    print("import servico");
    await importarTarefas(pfazenda);
    print("import tarefa");
    await importarFuncionarios(pfazenda);
    print("import funcionarios");

    //await importarResumoSangriaDiaria(pfazenda , pcoord);
    //await importarResumoSangriaMensal(pfazenda , pcoord);
    //await importarResumoSangriaAnual(pfazenda , pcoord);

   // await importarAvaliacaoHevea(pfazenda , pcoord) ;
    print("import Avaliacao");

  }

  //importar resumo sangrias

  Future <List<AnualHevea>> getDataAnualHevea(String url) async {

    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List anualheveaList = jsonDecode(response.body);
    List<AnualHevea> lista = [];
    print("url:  "+url);
    print("incio anual ");
    var i = 0;
    for (var elemento in anualheveaList) {

      print("elem: "+elemento.toString());
      var jsonData = elemento;
      AnualHevea anuhevea =   AnualHevea.fromMap(jsonData);

      print("elemento: "+anuhevea.id.toString());
      lista.add( anuhevea );
      print(" id :"+ lista[i].id.toString());
      print(" faze :"+ lista[i].faze.toString());
      i+=1;


    }
    return lista;
  }

  Future <void> importarResumoSangriaAnual(String fazenda , int codcoord) async {

    List<AnualHevea> anualheveaList = await  getDataAnualHevea("$urlpadrao/anualhevea/fazenda/$fazenda/$codcoord");



    if (anualheveaList.isNotEmpty) {

      for (var velemento in anualheveaList) {

        List<AnualHevea> lista = await db.getTarefaAnual(velemento.id , velemento.coord , velemento.faze  );
        print(" id:"+velemento.id.toString());
        print(" coord:" +velemento.coord.toString());
        print("Faz: "+ velemento.faze);

        if (lista.isEmpty){
          AnualHevea anuheve = new AnualHevea();
          anuheve.id = velemento.id;
          anuheve.tarefa  = velemento.tarefa;
          anuheve.cortes  = velemento.cortes;
          anuheve.coord  = velemento.coord;
          anuheve.nomecoord  = velemento.nomecoord;
          anuheve.faze  = velemento.faze;

          await db.newAnualHevea(anuheve);

        } else
          {

            AnualHevea anuheve = new AnualHevea();
            anuheve.id = velemento.id;
            anuheve.tarefa  = velemento.tarefa;
            anuheve.cortes  = velemento.cortes;
            anuheve.coord  = velemento.coord;
            anuheve.nomecoord  = velemento.nomecoord;
            anuheve.faze  = velemento.faze;

            await db.updateAnualHevea(anuheve);
          }

      }


    }

  }// anual

  Future <List<MensalHevea>> getDataMensalHevea(String url) async {

    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List mensalheveaList = jsonDecode(response.body);
    List<MensalHevea> lista = [];
    var i = 0;
    for (var elemento in mensalheveaList) {


      var jsonData = elemento;
      MensalHevea mensahevea =   MensalHevea.fromMap(jsonData);

      lista.add( mensahevea );

      i+=1;


    }
    return lista;
  }

  Future <void> importarResumoSangriaMensal(String fazenda , int codcoord) async {

    List<MensalHevea> mensalheveaList = await  getDataMensalHevea("$urlpadrao/mensalhevea/fazenda/$fazenda/$codcoord");



    if (mensalheveaList.isNotEmpty) {

      for (var velemento in mensalheveaList) {

        print("lista cadastro mensal");
        print(" id :"+ velemento.id.toString());
        print(" faze :"+ velemento.faze.toString());
        print(" coord :"+ velemento.coord.toString());
        print(" coordia :"+ velemento.coord.toString());

        List<MensalHevea> lista = await db.getTarefaMensal(velemento.tarefa , velemento.coord ,velemento.mes , velemento.faze.toString()  );
        if (lista.isEmpty){
          MensalHevea mensalheve = new MensalHevea();
          mensalheve.id = velemento.id;
          mensalheve.tarefa = velemento.tarefa;
          mensalheve.ano  = velemento.ano;
          mensalheve.mes  = velemento.mes;
          mensalheve.cortes  = velemento.cortes;
          mensalheve.coord  = velemento.coord;
          mensalheve.nomecoord  = velemento.nomecoord;
          mensalheve.faze  = velemento.faze;

          await db.newMensalHevea(mensalheve);


        } else
        {
          MensalHevea mensalheve = new MensalHevea();
          mensalheve.id = velemento.id;
          mensalheve.tarefa = velemento.tarefa;
          mensalheve.ano  = velemento.ano;
          mensalheve.mes  = velemento.mes;
          mensalheve.cortes  = velemento.cortes;
          mensalheve.coord  = velemento.coord;
          mensalheve.nomecoord  = velemento.nomecoord;
          mensalheve.faze  = velemento.faze;

          await db.updateMensalHevea(mensalheve);

        }

      }


    }

  }// mensal

  //diaria
  Future <List<DiariaHevea>> getDataDiariaHevea(String url) async {

    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List diariaheveaList = jsonDecode(response.body);
    List<DiariaHevea> lista = [];
    var i = 0;
    for (var elemento in diariaheveaList) {


      var jsonData = elemento;
      DiariaHevea diariaheve =   DiariaHevea.fromMap(jsonData);

      lista.add( diariaheve );
      print("url import");
      print(" id :"+ lista[i].id.toString());
      print(" faze :"+ lista[i].faze.toString());
      print(" coord :"+ lista[i].coord.toString());
      print(" coordia :"+ diariaheve.coord.toString());


      i+=1;


    }
    return lista;
  }

  Future <void> importarResumoSangriaDiaria(String fazenda , int codcoord) async {

    List<DiariaHevea> diariaheveaList = await  getDataDiariaHevea("$urlpadrao/diariahevea/fazenda/$fazenda/$codcoord");



    if (diariaheveaList.isNotEmpty) {

      for (var velemento in diariaheveaList) {
        print("lista cadastro");
        print(" id :"+ velemento.id.toString());
        print(" faze :"+ velemento.faze.toString());
        print(" coord :"+ velemento.coord.toString());
        print(" coordia :"+ velemento.coord.toString());

        List<DiariaHevea> lista = await db.getTarefaDiaria(velemento.tarefa , velemento.coord ,velemento.data_ativ , velemento.faze.toString()  );
        if (lista.isEmpty){

          DiariaHevea diariaheve = new DiariaHevea();
          diariaheve.id = velemento.id;
          diariaheve.data_ativ = velemento.data_ativ;
          diariaheve.chapa  = velemento.chapa;
          diariaheve.funcionario  = velemento.funcionario;
          diariaheve.tarefa  = velemento.tarefa;
          diariaheve.arvores  = velemento.arvores;
          diariaheve.coord = velemento.coord;
          diariaheve.faze  = velemento.faze;
          print("antes newDiariaHevea ");
          await db.newDiariaHevea(diariaheve);
          print("depois newDiariaHevea ");

        } else
        {
          DiariaHevea diariaheve = new DiariaHevea();
          diariaheve.id = velemento.id;
          diariaheve.data_ativ = velemento.data_ativ;
          diariaheve.chapa  = velemento.chapa;
          diariaheve.funcionario  = velemento.funcionario;
          diariaheve.tarefa  = velemento.tarefa;
          diariaheve.arvores  = velemento.arvores;
          diariaheve.coord = velemento.coord;
          diariaheve.faze  = velemento.faze;

          await db.updateDiariaHevea(diariaheve);

        }

      }


    }

  }
  //fim diaria
  //fim resumo sangrias
  Future <List<AvaliacaoHevea>> getDataAvaliacaoHevea(String url) async {
    //String myUrl = "http://192.168.0.250:8081/api/funcionariosrm/006043";
    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List avaliacaoList = jsonDecode(response.body);
    List<AvaliacaoHevea> avalhevea = [];
    var i = 0;
    for (var avaliacao in avaliacaoList) {


      var jsonData = avaliacao;
      AvaliacaoHevea avaliacao1 =   AvaliacaoHevea.fromMap(jsonData);

      avalhevea.add( avaliacao1);

      i+=1;
    }
    return avalhevea;
  }

  Future <void> importarAvaliacaoHevea(String pFaz , int pCoord) async {
    print(" antes importarAvaliacaoHevea: ");
    List<AvaliacaoHevea> avalheveaList = await  getDataAvaliacaoHevea("$urlpadrao/avaliacaohevea/fazenda/$pFaz/$pCoord");
    print(" depois importarAvaliacaoHevea: ");
    if (avalheveaList.isNotEmpty) {

      for (var avaliacao in avalheveaList) {
        print(" var avaliacao ");
        List<AvaliacaoHevea> listavaliacao = await db.getAvaliacaoFaz(avaliacao.faze , avaliacao.chapa , avaliacao.ano, avaliacao.mes);
        if (listavaliacao.isEmpty){
          print("listavaliacao.isEmpty");

          await db.newAvaliacaoHevea(avaliacao);


        }

      }


    }

  }
//avl hevea

}