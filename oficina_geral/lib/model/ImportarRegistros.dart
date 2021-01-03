import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:oficinamobile/dao/DatabaseHelper.dart';
import 'package:oficinamobile/model/Componente.dart';
import 'package:oficinamobile/model/OrdemServico.dart';


import 'Funcionario.dart';
import 'Motivo.dart';
import 'Usuario.dart';



class Importacao {

  final String urlpadrao = "http://138.197.170.221:8084/api";

  final db = DatabaseHelper.instance;

  Future <List<Funcionario>> getDataFuncionarios(String url) async {

    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List funcionarioList = jsonDecode(response.body);
    List<Funcionario> funcionarios = [];
    print("for antes restfull ");
    var i= 0;
    for (var ifuncionario in funcionarioList) {


      print("funcionario "+ifuncionario.toString());
      var jsonData = ifuncionario;
      Funcionario funcionario1 =    Funcionario.fromMap(jsonData);
      print("FuncionarioRM.fromMap(jsonData) ");
      funcionarios.add( funcionario1 );


      i+=1;
    }
    return funcionarios;
  }


  Future <List<Componente>> getDataComponente(String url) async {
    //String myUrl = "http://192.168.0.250:8081/api/funcionariosrm/006043";
    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List componenteList = jsonDecode(response.body);
    List<Componente> componentes = [];
    var i = 0;
    for (var componente in componenteList) {


      var jsonData = componente;
      Componente componente1 =   Componente.fromMap(jsonData);
      print("componente");
      componentes.add(componente1);

      print(" componente :"+ componentes[i].compCodigo.toString());


      i+=1;


    }
    return componentes;
  }

  Future <List<Motivo>> getDataMotivo(String url) async {
    //String myUrl = "http://192.168.0.250:8081/api/funcionariosrm/006043";
    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List motivoList = jsonDecode(response.body);
    List<Motivo> motivos = [];
    var i = 0;
    for (var motivo in motivoList) {


      var jsonData = motivo;
      Motivo motivo1 =   Motivo.fromMap(jsonData);

      motivos.add( motivo1);

      i+=1;
    }
    return motivos;
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

  Future <List<OrdemServico>> getDataOrdemServico(String url) async {

    http.Response response = await http.get(url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });


    List ordemList = jsonDecode(response.body);



    List<OrdemServico> ordemsl = [];

    var i = 0;
    for (var pordem in ordemList) {


      var jsonData = pordem;
      OrdemServico ordem1 =    OrdemServico.fromMap(jsonData);
      ordemsl.add( ordem1 );


      i+=1;

    }
    return ordemsl;
  }



  Future <void> importarFuncionarios() async {
    print(" antes List<FuncionarioRM> funcionariosrm: ");
    List<Funcionario> funcionarios = await  getDataFuncionarios("$urlpadrao/funcionario");
    print(" depois List<FuncionarioRM> funcionariosrm: ");
    if (funcionarios.isNotEmpty) {

      for (var funcionario in funcionarios) {
        print(" var funcrm in funcionariosrm ");
        List<Funcionario> listfunc = await db.getFuncionarioId(funcionario.funcCod);
        if (listfunc.isEmpty){
          print("listfunc.isEmpty");
          Funcionario  func = new Funcionario();
          func.funcCod = funcionario.funcCod;
          func.funcChapa = funcionario.funcChapa;
          func.funcNome = funcionario.funcNome ;

          await db.newFuncionario(func);


        }

      }


    }

  }// import funcionario

  Future <void> importarComponente() async {
    List<Componente> componentesList = await  getDataComponente("$urlpadrao/componente");

    if (componentesList.isNotEmpty) {

      for (var componente in componentesList) {

        List<Componente> listcomp = await db.getComponenteId(componente.compCodigo);
        if (listcomp.isEmpty){
          Componente comp = new Componente();
          comp.compCodigo = componente.compCodigo;
          comp.compDescricao = componente.compDescricao;

          await db.newComponente(comp);


        }

      }


    }

  }// import servicos

  // importar usuarios
  Future <void> importarUsuarios() async {
    List<Usuario> usuariosList = await  getDataUsuarios("$urlpadrao/usuario");

    if (usuariosList.isNotEmpty) {

      for (var usuario in usuariosList) {

        List<Usuario> listuser = await db.getUsuarioId (usuario.userId);
        if (listuser.isEmpty){
          Usuario user = new Usuario();
          user.userId = usuario.userId;
          user.userLogin = usuario.userLogin;
          user.userSenha = usuario.userSenha;
          user.funcChapa = usuario.funcChapa;
          user.funcCodigo = usuario.funcCodigo;

          await db.newUsuario(user);


        }

      }


    }

  }
  // fim importar usuarios

  Future <void> importarMotivo() async {

    List<Motivo> motivosList = await  getDataMotivo("$urlpadrao/motivo");

    if (motivosList.isNotEmpty) {

      for (var motivo in motivosList) {

        List<Motivo> listmot = await db.getmotivosId(motivo.mohaCodigo);
        if (listmot.isEmpty){

          Motivo motivo1 = new Motivo();
          motivo1.mohaCodigo = motivo.mohaCodigo;
          motivo1.mohaDescricao = motivo.mohaDescricao;

          await db.newMotivo(motivo1);


        }

      }


    }

  }// import servicos


  Future <void> importarOrdemServico() async {
    List<OrdemServico> ordemList = await  getDataOrdemServico("$urlpadrao/ordemservico");


    if (ordemList.isNotEmpty) {

      for (var vordem in ordemList) {

        List<OrdemServico> lisordemservico = await db.getOrdemServicoId( vordem.orseCodigo );
        if (lisordemservico.isEmpty){

          OrdemServico ordserv = new OrdemServico();
          ordserv.orseCodigo = vordem.orseCodigo ;
          ordserv.orseDescricao = vordem.orseDescricao;

          await db.newOrdemServico(ordserv);

        }

      }


    }

  }// import ordem serv


  Future <void> importarTudo() async {

    await importarOrdemServico();
    await importarComponente();
    await importarMotivo();
    await importarUsuarios();
    await importarFuncionarios();


  }









}