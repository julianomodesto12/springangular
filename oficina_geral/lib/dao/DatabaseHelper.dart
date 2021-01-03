import 'dart:io';

import 'package:oficinamobile/model/Componente.dart';
import 'package:oficinamobile/model/Funcionario.dart';
import 'package:oficinamobile/model/HoraTecnica.dart';
import 'package:oficinamobile/model/HoraTecnicaExp.dart';
import 'package:oficinamobile/model/Motivo.dart';
import 'package:oficinamobile/model/OrdemServico.dart';
import 'package:oficinamobile/model/Usuario.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  static final _databaseName = "OficinaMobil3.db";
  static final _databaseVersion = 1;


  static final table_Usuarios = 'usuarios';
  static final userId = 'userId';
  static final userLogin = 'userLogin';
  static final userSenha = 'userSenha';
  static final funcChapa = 'funcChapa';
  static final funcCodigo = 'funcCodigo';


  static final table_Componente = 'componentes';
  static final compCodigo = 'compCodigo';
  static final compDescricao = 'compDescricao';


  static final table_Motivo = 'motivos';
  static final mohaCodigo = 'mohaCodigo';
  static final mohaDescricao = 'mohaDescricao';


  static final table_OrdemServico = 'ordemservicos';
  static final orseCodigo = 'orseCodigo';
  static final orseDescricao = 'orseDescricao';

  static final table_Funcionarios = 'funcionarios';
  static final funcCod = 'funcCod';
  static final funcChapa1 = 'funcChapa';
  static final funcNome = 'funcNome';


  static final table_HoraTecnica = 'horatecnica';
  static final hoteCodigo = 'hoteCodigo';
  static final funcCod1 = 'funcCod';
  static final funcChapa2 = 'funcChapa';
  static final hoteData = 'hoteData';
  static final tipo = 'tipo';
  static final ithoCodigo = 'ithoCodigo';
  static final orseCodigo1 = 'orseCodigo';
  static final compCodigo1 = 'compCodigo';
  static final mohaCodigo1 = 'mohaCodigo';
  static final ithoHorainicio = 'ithoHorainicio';
  static final ithoHorafim = 'ithoHorafim';
  static final valorhora = 'valorhora';
  static final osEncerrar = 'osEncerrar';
  static final chavexp = 'chavexp';
  static final exportado = 'exportado';




/*

  */


  // torna esta classe singleton

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();



  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }
  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table_Usuarios (
            $userId INTEGER PRIMARY KEY,
            $userLogin TEXT NOT NULL,
            $userSenha TEXT NOT NULL,
            $funcChapa INTEGER NOT NULL,
            $funcCodigo INTEGER NOT NULL
          )
          ''');


    await db.execute('''
          CREATE TABLE $table_Componente (
            $compCodigo INTEGER PRIMARY KEY,
            $compDescricao TEXT NOT NULL
          )
          ''');


    await db.execute('''
          CREATE TABLE $table_Motivo (
            $mohaCodigo INTEGER PRIMARY KEY,
            $mohaDescricao TEXT NOT NULL
          )
          ''');



    await db.execute('''
          CREATE TABLE $table_OrdemServico (
            $orseCodigo INTEGER PRIMARY KEY,
            $orseDescricao TEXT NOT NULL
          )
          ''');


    await db.execute('''
          CREATE TABLE $table_Funcionarios (
            $funcCod INTEGER PRIMARY KEY,
            $funcChapa1 INTEGER NOT NULL,
            $funcNome TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table_HoraTecnica (
            $hoteCodigo INTEGER PRIMARY KEY,
            $funcCod1 INTEGER NOT NULL,
            $funcChapa2 INTEGER NOT NULL,
            $hoteData TEXT NOT NULL,
            $tipo INTEGER NOT NULL,
            $ithoCodigo INTEGER NOT NULL,
            $orseCodigo1 INTEGER NOT NULL,
            $compCodigo1 INTEGER NOT NULL,
            $mohaCodigo1 INTEGER NOT NULL,
            $ithoHorainicio INTEGER NOT NULL,
            $ithoHorafim INTEGER NOT NULL,
            $valorhora REAL NOT NULL,
            $osEncerrar TEXT NOT NULL,
            $chavexp TEXT NOT NULL  ,
            $exportado   TEXT          
          )
          ''');




  }


  newUsuario(Usuario newUsuario) async {
    final db = await database;


    var res = await db.insert("usuarios", newUsuario.toMap());
    return res;
  }

  updateUsuario(Usuario newUsuario) async {
    final db = await database;
    var res = await db.update("usuarios", newUsuario.toMap(),
        where: "userId = ?", whereArgs: [newUsuario.userId]);
    return res;
  }


  deleteUsuario(int id) async {
    final db = await database;
    db.delete("usuarios", where: "userId = ?", whereArgs: [id]);
  }


  deleteAllUsuario() async {
    final db = await database;
    db.rawDelete("Delete * from usuarios");
  }

  getUsuario(String plogin , String psenha) async {
    final db = await database;
    var res =await  db.query("usuarios", where: "userLogin = ? AND userSenha = ?", whereArgs: [plogin,psenha ]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Usuario> list =
    res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : [];

    return list;
  }

  getUsuarioId(int id) async {
    final db = await database;
    var res =await  db.query("usuarios", where: "userId = ? ", whereArgs: [id]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Usuario> list =
    res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : [];

    return list;
  }


  getUsuarioAll() async {
    final db = await database;
    var res =await  db.query("usuarios", where: "userLogin <> ? ", whereArgs: ["xx" ]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Usuario> list =
    res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : [];

    return list;
  }

  newComponente(Componente newComponente) async {
    final db = await database;


    var res = await db.insert("componentes", newComponente.toMap());
    return res;
  }

  updateComponente(Componente newComponente) async {
    final db = await database;
    var res = await db.update("componentes", newComponente.toMap(),
        where: "compCodigo = ?", whereArgs: [newComponente.compCodigo]);
    return res;
  }




  deleteAllComponente() async {
    final db = await database;
    db.rawDelete("Delete * from componentes");
  }

  getComponenteId(int id) async {
    final db = await database;
    var res =await  db.query("componentes", where: "compCodigo = ? ", whereArgs: [id]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Componente> list =
    res.isNotEmpty ? res.map((c) => Componente.fromMap(c)).toList() : [];

    return list;
  }


  newFuncionario(Funcionario newFuncionario) async {
    final db = await database;


    var res = await db.insert("funcionarios", newFuncionario.toMap());
    return res;
  }

  updateFuncionario(Funcionario newFuncionario) async {
    final db = await database;
    var res = await db.update("funcionarios", newFuncionario.toMap(),
        where: "funcCod = ?", whereArgs: [newFuncionario.funcCod]);
    return res;
  }




  deleteAllFuncionario() async {
    final db = await database;
    db.rawDelete("Delete * from funcionarios");
  }

  getFuncionarioId(int id) async {
    final db = await database;
    var res =await  db.query("funcionarios", where: "funcCod = ? ", whereArgs: [id]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Funcionario> list =
    res.isNotEmpty ? res.map((c) => Funcionario.fromMap(c)).toList() : [];

    return list;
  }

  getFuncionarioChapa(int chapa) async {
    final db = await database;
    var res =await  db.query("funcionarios", where: "funcChapa = ? ", whereArgs: [chapa]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Funcionario> list =
    res.isNotEmpty ? res.map((c) => Funcionario.fromMap(c)).toList() : [];

    return list;
  }

  newMotivo(Motivo newMotivo) async {
    final db = await database;


    var res = await db.insert("motivos", newMotivo.toMap());
    return res;
  }

  updateMotivo(Motivo newMotivo) async {
    final db = await database;
    var res = await db.update("motivos", newMotivo.toMap(),
        where: "mohaCodigo = ?", whereArgs: [newMotivo.mohaCodigo]);
    return res;
  }




  deleteAllMotivo() async {
    final db = await database;
    db.rawDelete("Delete * from motivos");
  }

  getmotivosId(int id) async {
    final db = await database;
    var res =await  db.query("motivos", where: "mohaCodigo = ? ", whereArgs: [id]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Motivo> list =
    res.isNotEmpty ? res.map((c) => Motivo.fromMap(c)).toList() : [];

    return list;
  }

  newOrdemServico(OrdemServico newOrdemServico) async {
    final db = await database;


    var res = await db.insert("ordemservicos", newOrdemServico.toMap());
    return res;
  }

  updateOrdemServico(OrdemServico newOrdemServico) async {
    final db = await database;
    var res = await db.update("ordemservicos", newOrdemServico.toMap(),
        where: "orseCodigo = ?", whereArgs: [newOrdemServico.orseCodigo]);
    return res;
  }




  deleteAllOrdemServico() async {
    final db = await database;
    db.rawDelete("Delete * from ordemservicos");
  }

  getOrdemServicoId(int id) async {
    final db = await database;
    var res =await  db.query("ordemservicos", where: "orseCodigo = ? ", whereArgs: [id]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<OrdemServico> list =
    res.isNotEmpty ? res.map((c) => OrdemServico.fromMap(c)).toList() : [];

    return list;
  }


  newHoraTecnica(HoraTecnica newHoraTecnica) async {
    final db = await database;


    var res = await db.insert("horatecnica", newHoraTecnica.toMap());
    return res;
  }

  updateHoraTecnica(HoraTecnica newHoraTecnica) async {
    final db = await database;
    var res = await db.update("horatecnica", newHoraTecnica.toMap(),
        where: "hoteCodigo = ?", whereArgs: [newHoraTecnica.hoteCodigo]);
    return res;
  }


  updateHoraTecnicaExp(HoraTecnicaExp newHoraTecnicaExp) async {
    final db = await database;
    var res = await db.update("horatecnica", newHoraTecnicaExp.toMap(),
        where: "hoteCodigo = ?", whereArgs: [newHoraTecnicaExp.hoteCodigo]);
    return res;
  }


  deleteHoraTecnica(int id) async {
    final db = await database;
    db.delete("horatecnica", where: "hoteCodigo = ?", whereArgs: [id]);
  }


  deleteAllHoraTecnica() async {
    final db = await database;
    db.rawDelete("Delete * from horatecnica");
  }

  getHoraTecnica(int id) async {
    final db = await database;
    var res =await  db.query("horatecnica", where: "hoteCodigo = ? ", whereArgs: [id]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<HoraTecnica> list =
    res.isNotEmpty ? res.map((c) => HoraTecnica.fromMap(c)).toList() : [];

    return list;
  }

  getHoraTecnicaByDataChapa(String pData, int Chapa)  async {
    final db = await database;
    var res =await  db.query("horatecnica", where: "hoteData = ? AND funcChapa = ? ", whereArgs: [pData, Chapa]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<HoraTecnica> list =
    res.isNotEmpty ? res.map((c) => HoraTecnica.fromMap(c)).toList() : [];

    return list;

  }

  getHoraTecnicaByData(String pData)  async {
    final db = await database;
    var res =await  db.query("horatecnica", where: "hoteData = ?  ", whereArgs: [pData]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<HoraTecnica> list =
    res.isNotEmpty ? res.map((c) => HoraTecnica.fromMap(c)).toList() : [];

    return list;

  }

  getHoraTecnicaExpByData(String pData)  async {
    final db = await database;
    var res =await  db.query("horatecnica", where: "hoteData = ?  ", whereArgs: [pData]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<HoraTecnicaExp> list =
    res.isNotEmpty ? res.map((c) => HoraTecnicaExp.fromMap(c)).toList() : [];

    return list;

  }

  Future<int> getNewIdHoraTecnica() async {
    final db = await database;

    var result = await db.rawQuery('SELECT MAX(hoteCodigo + 1) AS hoteCodigo FROM horatecnica' );
    int newid = Sqflite.firstIntValue(result);
    //result.isNotEmpty ? result.map((c) => Atividade.fromMap(c)).toList() : [];

    return newid;
    //return result.toList();
  }

 getUltimaHoraTec(String pData , int pChapa )  async {
    final db = await database;
    //RawQuery fazer join entre tabelas

    var res = await db.rawQuery(
        " SELECT "+
            " a.hoteCodigo, a.funcCod,  a.funcChapa, a.hoteData , a.tipo, a.ithoCodigo, a.orseCodigo, a.compCodigo,  "+
            " a.mohaCodigo, a.ithoHorainicio, a.ithoHorafim, a.valorhora, a.osEncerrar, a.chavexp  "+
            " FROM horatecnica a  "+
            " WHERE a.funcChapa = "+pChapa.toString()+
            " and a.hoteData = '"+pData+"'"+
            " ORDER BY a.ithoHorafim DESC");
    //var res =await  db.query("heve_funcionarios", where: "chapa_func > ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<HoraTecnica> list =
    res.isNotEmpty ? res.map((c) => HoraTecnica.fromMap(c)).toList() : [];


    return list ;
  }




  /*



























  getAllAtividade() async {
    final db = await database;
    var res = await db.query("heve_atividades");
    List<Atividade> list =
    res.isNotEmpty ? res.map((c) => Atividade.fromMap(c)).toList() : [];
    return list;
  }

  getAtividadeById(int id)  async {
    final db =  await  database;

    var res =  await db.query("heve_atividades", where: "id_ativ = ? ", whereArgs: [id]);

    List<Atividade> list = res.map((c) => Atividade.fromMap(c)).toList();
    //res.isNotEmpty ? res.map((c) => Atividade.fromMap(c)).toList() : [];
    return list;
  }

  getAtividadeExportarData(String pData)  async {
    final db =  await  database;

    var res =  await db.query("heve_atividades", where: "data_ativ = ? ", whereArgs: [pData]);

    List<Atividade> list = res.map((c) => Atividade.fromMap(c)).toList();
    //res.isNotEmpty ? res.map((c) => Atividade.fromMap(c)).toList() : [];
    return list;
  }

  getAtividadeByData(String pData)  async {
    final db = await database;
    //RawQuery fazer join entre tabelas
    var res = await db.rawQuery(
        " SELECT "+
            " a.id_ativ, a.ativ_faze,  a.data_ativ, a.chapa_ativ,b.nome_func, a.coord_ativ,  a.pres_ativ,  a.serv_ativ,  a.tarefa_ativ, a.arvore_ativ, "+
            " a.qtd_ativ,  a.sang_ativ,  a.plat_ativ,  a.roma_ativ,  a.chavexp , a.exportado "+
            " FROM heve_atividades a , heve_funcionarios b  "+
            " WHERE a.chapa_ativ=b.chapa_func "+
            " and a.data_ativ= '"+pData+"'"+
            " ORDER BY a.id_ativ ");
    //var res =await  db.query("heve_funcionarios", where: "chapa_func > ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<AtividadeFuncionario> list =
    res.isNotEmpty ? res.map((c) => AtividadeFuncionario.fromMap(c)).toList() : [];
    return list;
  }


  getAtividadeByDataAexportar(String pData)  async {
    final db = await database;
    //RawQuery fazer join entre tabelas
    var res = await db.rawQuery(
        " SELECT "+
            " a.id_ativ, a.ativ_faze,  a.data_ativ, a.chapa_ativ,b.nome_func, a.coord_ativ,  a.pres_ativ,  a.serv_ativ,  a.tarefa_ativ, a.arvore_ativ, "+
            " a.qtd_ativ,  a.sang_ativ,  a.plat_ativ,  a.roma_ativ,  a.chavexp , a.exportado "+
            " FROM heve_atividades a , heve_funcionarios b  "+
            " WHERE a.chapa_ativ=b.chapa_func "+
            " and a.data_ativ= '"+pData+"'"+
            " and  a.exportado= '"+"N"+"'"+
            " ORDER BY a.id_ativ ");
    //var res =await  db.query("heve_funcionarios", where: "chapa_func > ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<AtividadeFuncionario> list =
    res.isNotEmpty ? res.map((c) => AtividadeFuncionario.fromMap(c)).toList() : [];
    return list;
  }

  getFuncAtividade( int pchapa ) async {
    final db = await database;
    //var result = await db.query("contato", columns: [columnId, columnTitle, columnDescription]);
    var result = await db.rawQuery('SELECT * FROM heve_atividades WHERE chapa_ativ =  '+ pchapa.toString() );
    List<Atividade> list =
    result.isNotEmpty ? result.map((c) => Atividade.fromMap(c)).toList() : [];

    return list;
    //return result.toList();
  }

  Future<int> getNewIdAtividade() async {
    final db = await database;

    var result = await db.rawQuery('SELECT MAX(id_ativ+1) AS id_ativ FROM heve_atividades' );
    int newid = Sqflite.firstIntValue(result);
    //result.isNotEmpty ? result.map((c) => Atividade.fromMap(c)).toList() : [];

    return newid;
    //return result.toList();
  }


  getAllAtividadeFuncionario() async {
    final db = await database;
    //RawQuery fazer join entre tabelas
    var res = await db.rawQuery(
        " SELECT "+
            " a.id_ativ, a.ativ_faze,  a.data_ativ, a.chapa_ativ,b.nome_func, a.coord_ativ,  a.pres_ativ,  a.serv_ativ,  a.tarefa_ativ, a.arvore_ativ, "+
            " a.qtd_ativ,  a.sang_ativ,  a.plat_ativ,  a.roma_ativ,  a.chavexp "+
            " FROM heve_atividades a , heve_funcionarios b  "+
            " WHERE a.chapa_ativ=b.chapa_func "+
            " ORDER BY a.id_ativ ");
    //var res =await  db.query("heve_funcionarios", where: "chapa_func > ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<AtividadeFuncionario> list =
    res.isNotEmpty ? res.map((c) => AtividadeFuncionario.fromMap(c)).toList() : [];
    return list;
  }






   */




}