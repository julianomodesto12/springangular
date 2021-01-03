import 'dart:io';
import 'package:path/path.dart';
import 'package:sgihevea/model/AnualHevea.dart';
import 'package:sgihevea/model/Atividade.dart';
import 'package:sgihevea/model/AtividadeFuncionario.dart';
import 'package:sgihevea/model/AvaliacaoHevea.dart';
import 'package:sgihevea/model/DiariaHevea.dart';
import 'package:sgihevea/model/Funcionario.dart';
import 'package:sgihevea/model/MensalHevea.dart';
import 'package:sgihevea/model/Servico.dart';
import 'package:sgihevea/model/Tarefa.dart';
import 'package:sgihevea/model/Usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sgihevea/model/Fazenda.dart';


class DatabaseHelper {
  static final _databaseName = "SgiHevearss.db";
  static final _databaseVersion = 1;

  static final table_Usuarios = 'heve_usuarios';
  static final id_usua = 'id_usua';
  static final login_usua = 'login_usua';
  static final senha_usua = 'senha_usua';
  static final faze_usua = 'faze_usua';
  static final chapa_usua = 'chapa_usua';

  static final table_Fazenda = 'heve_fazenda';
  static final id_faze = 'id_faze';
  static final nome_faze = 'nome_faze';


  static final table_Funcionarios = 'heve_funcionarios';
  static final id_func = 'id_func';
  static final chapa_func = 'chapa_func';
  static final nome_func = 'nome_func';
  static final coord_func = 'coord_func';

  static final table_Servicos = 'heve_servicos';
  static final id_serv = 'id_serv';
  static final nome_serv = 'nome_serv';


  static final table_Tarefas = 'heve_tarefas';
  static final id_tarefa = 'id_tarefa';
  static final qtd_tarefa = 'qtd_tarefa';


  static final table_Atividades = 'heve_atividades';
  static final id_ativ = 'id_ativ';
  static final ativ_faze = 'ativ_faze';
  static final data_ativ = 'data_ativ';//tipo string
  static final chapa_ativ = 'chapa_ativ';
  static final coord_ativ = 'coord_ativ';
  static final pres_ativ = 'pres_ativ'; // p/f
  static final serv_ativ = 'serv_ativ'; //
  static final tarefa_ativ = 'tarefa_ativ'; //
  static final arvore_ativ = 'arvore_ativ'; //
  static final qtd_ativ = 'qtd_ativ'; //
  static final sang_ativ = 'sang_ativ'; //
  static final plat_ativ = 'plat_ativ'; //
  static final roma_ativ = 'roma_ativ'; //
  static final chavexp = 'chavexp'; //
  static final exportado = 'exportado'; //

  // tabelas de resumo

  static final table_Anualhevea = 'anualhevea';
  static final id_anh = 'id';
  static final tarefa_anh = 'tarefa';
  static final cortes_anh = 'cortes';
  static final coord_anh = 'coord';
  static final nomecoord_anh = 'nomecoord';
  static final faze_anh = 'faze';


  static final table_Mnsalhevea = 'mensalhevea';
  static final id_mhe = 'id';
  static final tarefa_mhe = 'tarefa';
  static final ano_mhe = 'ano';
  static final mes_mhe = 'mes';
  static final cortes_mhe = 'cortes';
  static final coord_mhe = 'coord';
  static final nomecoord_mhe = 'nomecoord';
  static final faze_mhe = 'faze';


  static final table_Diariahevea = 'diariahevea';
  static final id_dih = 'id';
  static final data_dih = 'data_ativ';
  static final chapa_dih = 'chapa';
  static final funcionario_dih = 'funcionario';
  static final tarefa_dih = 'tarefa';
  static final arvores_dih = 'arvores';
  static final coord_dih = 'coord';
  static final faze_dih = 'faze';


  static final table_AvaliacaoHevea = 'avaliacaohevea';
  static final aval_id = 'id';
  static final aval_chapa = 'chapa';
  static final aval_nomefunc = 'nomefunc';
  static final aval_ano = 'ano';
  static final aval_mes = 'mes';
  static final aval_nota = 'nota';
  static final aval_coord = 'coord';
  static final aval_faze = 'faze';

/*

  */


  // torna esta classe singleton

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //static final DatabaseHelper _instance = new DatabaseHelper.internal();

  //factory DatabaseHelper() => _instance;


  //DatabaseHelper.internal();

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
            $id_usua INTEGER PRIMARY KEY,
            $login_usua TEXT NOT NULL,
            $senha_usua TEXT NOT NULL,
            $faze_usua TEXT NOT NULL,
            $chapa_usua INTEGER NOT NULL
          )
          ''');



    await db.execute('''
          CREATE TABLE $table_Fazenda (
            $id_faze TEXT NOT NULL PRIMARY KEY,
            $nome_faze TEXT NOT NULL
          )
          ''');


    await db.execute('''
          CREATE TABLE $table_Funcionarios (
            $id_func INTEGER PRIMARY KEY  AUTOINCREMENT,
            $chapa_func INTEGER NOT NULL,
            $nome_func TEXT NOT NULL,
            $coord_func INTEGER NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table_Servicos (
            $id_serv INTEGER PRIMARY KEY,
            $nome_serv TEXT NOT NULL
           )
          ''');

    await db.execute('''
          CREATE TABLE $table_Tarefas (
            $id_tarefa INTEGER PRIMARY KEY,
            $qtd_tarefa INTEGER NOT NULL
           )
          ''');


    await db.execute('''
          CREATE TABLE $table_Atividades (
            $id_ativ INTEGER PRIMARY KEY,
            $ativ_faze TEXT NOT NULL,
            $data_ativ TEXT NOT NULL,
            $chapa_ativ INTEGER NOT NULL,
            $coord_ativ INTEGER NOT NULL,
            $pres_ativ TEXT NOT NULL,
            $serv_ativ INTEGER NOT NULL,
            $tarefa_ativ INTEGER NOT NULL,
            $arvore_ativ INTEGER NOT NULL,
            $qtd_ativ REAL NOT NULL,
            $sang_ativ TEXT NOT NULL,
            $plat_ativ INTEGER NOT NULL,
            $roma_ativ INTEGER NOT NULL,
            $chavexp TEXT NOT NULL,
            $exportado TEXT NOT NULL
           )
          ''');


    await db.execute('''
          CREATE TABLE $table_Anualhevea (
            $id_anh INTEGER PRIMARY KEY,
            $tarefa_anh INTEGER NOT NULL,
            $cortes_anh REAL NOT NULL,
            $coord_anh INTEGER NOT NULL,
            $nomecoord_anh TEXT NOT NULL,
            $faze_anh TEXT NOT NULL            
           )
          ''');

    await db.execute('''
          CREATE TABLE $table_Mnsalhevea (
            $id_mhe INTEGER PRIMARY KEY,
            $tarefa_mhe INTEGER NOT NULL,
            $ano_mhe INTEGER NOT NULL,
            $mes_mhe INTEGER NOT NULL,
            $cortes_mhe REAL NOT NULL,
            $coord_mhe INTEGER NOT NULL,
            $nomecoord_mhe TEXT NOT NULL,
            $faze_mhe TEXT NOT NULL            
           )
          ''');

    await db.execute('''
          CREATE TABLE $table_Diariahevea (
            $id_dih INTEGER PRIMARY KEY,
            $data_dih TEXT NOT NULL,
            $chapa_dih INTEGER NOT NULL,
            $funcionario_dih TEXT NOT NULL,
            $tarefa_dih INTEGER NOT NULL,
            $arvores_dih REAL NOT NULL,
            $coord_dih INTEGER NOT NULL,
            $faze_dih TEXT NOT NULL            
           )
          ''');
    await db.execute('''
          CREATE TABLE $table_AvaliacaoHevea (
            $aval_id INTEGER PRIMARY KEY,
            $aval_chapa INTEGER NOT NULL,
            $aval_nomefunc TEXT NOT NULL,
            $aval_ano INTEGER NOT NULL,
            $aval_mes INTEGER NOT NULL,
            $aval_nota REAL NOT NULL,
            $aval_coord INTEGER NOT NULL,
            $aval_faze TEXT NOT NULL
            
          )
          ''');



  }


  newUsuario(Usuario newUsuario) async {
    final db = await database;


    var res = await db.insert("heve_usuarios", newUsuario.toMap());
    return res;
  }

  updateUsuario(Usuario newUsuario) async {
    final db = await database;
    var res = await db.update("heve_usuarios", newUsuario.toMap(),
        where: "id_usua = ?", whereArgs: [newUsuario.id_usua]);
    return res;
  }


  deleteUsuario(int id) async {
    final db = await database;
    db.delete("heve_usuarios", where: "id_usua = ?", whereArgs: [id]);
  }


  deleteAllUsuario() async {
    final db = await database;
    db.rawDelete("Delete * from heve_usuarios");
  }

  getUsuario(String plogin , String psenha) async {
    final db = await database;
    var res =await  db.query("heve_usuarios", where: "login_usua = ? AND senha_usua = ?", whereArgs: [plogin,psenha ]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Usuario> list =
    res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : [];

    return list;
  }

  getUsuarioId(int id) async {
    final db = await database;
    var res =await  db.query("heve_usuarios", where: "id_usua = ? ", whereArgs: [id]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Usuario> list =
    res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : [];

    return list;
  }


  getUsuarioAll() async {
    final db = await database;
    var res =await  db.query("heve_usuarios", where: "login_usua <> ? ", whereArgs: ["xx" ]);
    //return res.isNotEmpty ? Usuario.fromMap(res.first) : Null ;

    List<Usuario> list =
    res.isNotEmpty ? res.map((c) => Usuario.fromMap(c)).toList() : [];

    return list;
  }

  newFazenda(Fazenda newFazenda) async {
    final db = await database;
    var res = await db.insert("heve_fazenda", newFazenda.toMap());
    return res;
  }

  updateFazenda(Fazenda newFazenda) async {
    final db = await database;
    var res = await db.update("heve_fazenda", newFazenda.toMap(),
        where: "id_faze = ?", whereArgs: [newFazenda.id_faze]);
    return res;
  }


  deleteFazenda(String idfaze) async {
    final db = await database;
    db.delete("heve_fazenda", where: "id_faze = ?", whereArgs: [idfaze]);
  }

  deleteAllFazenda() async {
    final db = await database;
    db.delete("heve_fazenda", where: "id_faze <> ?", whereArgs: ["x"]);
  }

  getfazenda(String idfaze) async {
    final db = await database;
    var res =await  db.query("heve_fazenda", where: "id_faze = ? ", whereArgs: [idfaze ]);
    //return res.isNotEmpty ? Fazenda.fromMap(res.first) : Null ;
    List<Fazenda> list =
    res.isNotEmpty ? res.map((c) => Fazenda.fromMap(c)).toList() : [];

    return list;

  }

  getAllfazenda() async {
    final db = await database;
    String idfaze ="";
    var res =await  db.query("heve_fazenda", where: "id_faze <> ? ", whereArgs: [idfaze ]);
    //return res.isNotEmpty ? Fazenda.fromMap(res.first) : Null ;
    List<Fazenda> list =
    res.isNotEmpty ? res.map((c) => Fazenda.fromMap(c)).toList() : [];

    return list;

  }

  newFuncionario(Funcionario newFuncionario) async {
    final db = await database;

    var res = await db.insert("heve_funcionarios", newFuncionario.toMap());
    return res;
  }

  updateFuncionario(Funcionario newFuncionario) async {
    final db = await database;
    var res = await db.update("heve_funcionarios", newFuncionario.toMap(),
        where: "id_func = ?", whereArgs: [newFuncionario.id_func]);
    return res;
  }

  deleteFuncionario(int id) async {
    final db = await database;
    db.delete("heve_funcionarios", where: "id_func = ?", whereArgs: [id]);
  }


  deleteAllFuncionario() async {
    final db = await database;
    db.rawDelete("Delete  from heve_funcionarios");
  }

 getFuncionario(int pchapa) async {
    final db = await database;
    var res =await  db.query("heve_funcionarios", where: "chapa_func = ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<Funcionario> list =
    res.isNotEmpty ? res.map((c) => Funcionario.fromMap(c)).toList() : [];

    return list;
  }

  getAllFuncionario() async {
    final db = await database;
    int pchapa = 0;
    var res =await  db.query("heve_funcionarios", where: "chapa_func > ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<Funcionario> list =
    res.isNotEmpty ? res.map((c) => Funcionario.fromMap(c)).toList() : [];
    return list;
  }

  getCoordenador(int pchapa) async {
    final db = await database;
    var res =await  db.query("heve_funcionarios", where: "chapa_func = ?  AND coord_func = 1 ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;
    List<Funcionario> list =
    res.isNotEmpty ? res.map((c) => Funcionario.fromMap(c)).toList() : [];

    return list;
  }

  newServico(Servico newServico) async {
    final db = await database;
    var res = await db.insert("heve_servicos", newServico.toMap());
    return res;
  }

  updateServico(Servico newServico) async {
    final db = await database;
    var res = await db.update("heve_servicos", newServico.toMap(),
        where: "id_serv = ?", whereArgs: [newServico.id_serv]);
    return res;
  }

  deleteAllServico() async {
    final db = await database;
    db.rawDelete("Delete * from heve_servicos");
  }

  getServico(int pserv) async {
    final db = await database;
    var res =await  db.query("heve_servicos", where: "id_serv = ? ", whereArgs: [pserv]);
    //return res.isNotEmpty ? Servico.fromMap(res.first) : Null ;
    List<Servico> list =
    res.isNotEmpty ? res.map((c) => Servico.fromMap(c)).toList() : [];

    return list;
  }

  getAllServicos() async {
    final db = await database;
    var res =await  db.query("heve_servicos", where: "id_serv <> ? ", whereArgs: [0]);
    //return res.isNotEmpty ? Servico.fromMap(res.first) : Null ;
    List<Servico> list =
    res.isNotEmpty ? res.map((c) => Servico.fromMap(c)).toList() : [];

    return list;
  }

  newTarefa(Tarefa newTarefa) async {
    final db = await database;
    var res = await db.insert("heve_tarefas", newTarefa.toMap());
    return res;
  }

  updateTarefa(Tarefa newTarefa) async {
    final db = await database;
    var res = await db.update("heve_tarefas", newTarefa.toMap(),
        where: "id_tarefa = ?", whereArgs: [newTarefa.id_tarefa]);
    return res;
  }

  deleteAllTarefa() async {
    final db = await database;
    db.rawDelete("Delete * from heve_tarefas");
  }

  getTarefa(int id) async {
    final db = await database;
    var res =await  db.query("heve_tarefas", where: "id_tarefa= ? ", whereArgs: [id]);
    //return res.isNotEmpty ? Tarefa.fromMap(res.first) : Null ;
    List<Tarefa> list =
    res.isNotEmpty ? res.map((c) => Tarefa.fromMap(c)).toList() : [];

    return list;
  }

  newAtividade(Atividade newAtividade) async {
    //inserir id autoinc
    final db = await database;
    var res = await db.insert("heve_atividades", newAtividade.toMap());
    return res;
  }

  updateAtividade(Atividade newAtividade) async {
    final db = await database;
    var res = await db.update("heve_atividades", newAtividade.toMap(),
        where: "id_ativ = ?", whereArgs: [newAtividade.id_ativ]);
    return res;
  }

  deleteAllAtividade() async {
    final db = await database;
    db.rawDelete("Delete  from heve_atividades");
  }

  deleteAtividadeById(int Id) async {
    final db = await database;
    db.rawDelete("Delete  from heve_atividades where id_ativ = "+ Id.toString() );
  }

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

  newAnualHevea(AnualHevea newanualheve) async {
    //inserir id autoinc
    final db = await database;
    var res = await db.insert("anualhevea", newanualheve.toMap());
    return res;
  }


  updateAnualHevea(AnualHevea newanualheve) async {
    final db = await database;
    var res = await db.update("anualhevea", newanualheve.toMap(),
        where: "id = ?", whereArgs: [newanualheve.id]);
    return res;
  }

  deleteAllAnualHevea() async {
    final db = await database;
    db.rawDelete("Delete  from anualhevea");
  }

  deleteAnualHeveaById(int pId) async {
    final db = await database;
    db.rawDelete("Delete  from anualhevea where id = "+ pId.toString() );
  }

  getTarefaAnual(int tarefa , int codcoord , String fazenda  ) async {
    final db = await database;
    var res =await  db.query("anualhevea", where: "tarefa = ? AND coord = ? AND faze = ? ", whereArgs: [tarefa , codcoord ,fazenda ]);

    List<AnualHevea> list =
    res.isNotEmpty ? res.map((c) => AnualHevea.fromMap(c)).toList() : [];

    return list;
  }

// mensal
  newMensalHevea(MensalHevea newmensalheve) async {
    //inserir id autoinc
    final db = await database;
    var res = await db.insert("mensalhevea", newmensalheve.toMap());
    return res;
  }


  updateMensalHevea(MensalHevea newmensalheve) async {
    final db = await database;
    var res = await db.update("mensalhevea", newmensalheve.toMap(),
        where: "id = ?", whereArgs: [newmensalheve.id]);
    return res;
  }

  deleteAllMensalHevea() async {
    final db = await database;
    db.rawDelete("Delete  from mensalhevea");
  }

  deleteMensalHeveaById(int Id) async {
    final db = await database;
    db.rawDelete("Delete  from mensalhevea where id = "+ Id.toString() );
  }

  getTarefaMensal(int tarefa ,  int codcoord ,int mes, String fazenda  ) async {
    final db = await database;
    var res =await  db.query("mensalhevea", where: "tarefa= ? AND coord= ? AND mes = ? AND faze= ? ", whereArgs: [tarefa , codcoord ,mes ,fazenda ]);

    List<MensalHevea> list =
    res.isNotEmpty ? res.map((c) => MensalHevea.fromMap(c)).toList() : [];

    return list;
  }

  //resumo diario
  newDiariaHevea(DiariaHevea newdiariaheve) async {
    //inserir id autoinc
    final db = await database;
    var res = await db.insert("diariahevea", newdiariaheve.toMap());
    return res;
  }


  updateDiariaHevea(DiariaHevea newdiariaheve) async {
    final db = await database;
    var res = await db.update("diariahevea", newdiariaheve.toMap(),
        where: "id = ?", whereArgs: [newdiariaheve.id]);
    return res;
  }

  deleteAllDiariaHevea() async {
    final db = await database;
    db.rawDelete("Delete  from diariahevea");
  }

  deleteDiariaHeveaById(int Id) async {
    final db = await database;
    db.rawDelete("Delete  from diariahevea where id = "+ Id.toString() );
  }

  getTarefaDiaria(int tarefa ,  int codcoord ,String pdata, String fazenda  ) async {
    final db = await database;
    var res =await  db.query("diariahevea", where: "tarefa = ? AND coord = ? AND data_ativ = ? AND faze= ? ", whereArgs: [tarefa , codcoord ,pdata ,fazenda ]);

    List<DiariaHevea> list =
    res.isNotEmpty ? res.map((c) => DiariaHevea.fromMap(c)).toList() : [];

    return list;
  }



  getAllResumoAnual(String fazenda , int pTarefa) async {
    final db = await database;
    //RawQuery fazer join entre tabelas
    var res = await db.rawQuery(
        " SELECT "+
            " a.id, a.tarefa, a.cortes, a.coord "+
            " FROM anualhevea a   "+
            " WHERE a.faze = " +"'"+ fazenda.toString()+"'"+
            " AND a.tarefa = "+ pTarefa.toString()+
            " ORDER BY a.tarefa ");
    //var res =await  db.query("heve_funcionarios", where: "chapa_func > ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<AnualHevea> list =
    res.isNotEmpty ? res.map((c) => AnualHevea.fromMap(c)).toList() : [];
    return list;
  }



  getAllResumoMensal(String fazenda , int pTarefa) async {
    final db = await database;
    //RawQuery fazer join entre tabelas
    var res = await db.rawQuery(
        " SELECT "+
            " a.id, a.tarefa, a.ano, a.mes, a.cortes,a.coord "+
            " FROM mensalhevea a   "+
            " WHERE a.faze = " +"'"+ fazenda.toString()+"'"+
            "  AND a.tarefa = "+pTarefa.toString()+
            " ORDER BY a.tarefa, a.ano, a.mes ");
    //var res =await  db.query("heve_funcionarios", where: "chapa_func > ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<MensalHevea> list =
    res.isNotEmpty ? res.map((c) => MensalHevea.fromMap(c)).toList() : [];
    return list;
  }



  getAllResumoDiario(String fazenda , int pTarefa) async {
    final db = await database;
    //RawQuery fazer join entre tabelas
    var res = await db.rawQuery(
        " SELECT "+
            " a.id, a.data_ativ, a.chapa, a.funcionario, a.tarefa,a.arvores, a.coord "+
            " FROM diariahevea a   "+
            " WHERE a.faze = " +"'"+ fazenda.toString()+"'"+
            " AND a.tarefa = "+ pTarefa.toString()+
            " ORDER BY a.funcionario,a.tarefa,a.id ");
    //var res =await  db.query("heve_funcionarios", where: "chapa_func > ? ", whereArgs: [pchapa]);
    //return res.isNotEmpty ? Funcionario.fromMap(res.first) : null ;

    List<DiariaHevea> list =
    res.isNotEmpty ? res.map((c) => DiariaHevea.fromMap(c)).toList() : [];
    return list;
  }

  newAvaliacaoHevea(AvaliacaoHevea newavaliacaoHevea) async {
    final db = await database;
    var res = await db.insert("avaliacaohevea", newavaliacaoHevea.toMap());
    return res;
  }

  updateAvaliacaoHevea(AvaliacaoHevea newavaliacaoHevea) async {
    final db = await database;
    var res = await db.update("avaliacaohevea",newavaliacaoHevea.toMap(),
        where: "id = ?", whereArgs: [newavaliacaoHevea.id]);
    return res;
  }


  deleteAvaliacaoHevea(int id) async {
    final db = await database;
    db.delete("avaliacaohevea", where: "id = ?", whereArgs: [id]);
  }


  deleteAllUAvaliacaoHevea() async {
    final db = await database;
    db.rawDelete("Delete * from avaliacaohevea");
  }

  getAvaliacaoFuncionario(int pChapa  )  async {
    final db = await database;
    //RawQuery fazer join entre tabelas

    var res = await db.rawQuery(
        " SELECT "+
            " a.chapa, a.nomefunc,  a.ano, a.mes , a.nota, a.coord, a.faze "+

            " FROM avaliacaohevea a  "+
            " WHERE a.chapa = "+pChapa.toString()+
            //" AND a.coord = "+pCoord.toString()+
            " ORDER BY a.ano DESC , a.mes DESC ");


    List<AvaliacaoHevea> list =
    res.isNotEmpty ? res.map((c) => AvaliacaoHevea.fromMap(c)).toList() : [];


    return list ;
  }

  getAvaliacaoFaz(String pFaz , int pChapa , int pAno, int pMes )  async {
    final db = await database;
    //RawQuery fazer join entre tabelas

    var res = await db.rawQuery(
        " SELECT "+
            " a.chapa, a.nomefunc,  a.ano, a.mes , a.nota, a.coord, a.faze "+

            " FROM avaliacaohevea a  "+
            " WHERE a.faze = '"+pFaz+"'"+
            " AND a.chapa = "+pChapa.toString()+
            " AND a.ano = "+pAno.toString()+
            " AND a.mes = "+pMes.toString()+
            " ORDER BY a.ano DESC , a.mes DESC ");


    List<AvaliacaoHevea> list =
    res.isNotEmpty ? res.map((c) => AvaliacaoHevea.fromMap(c)).toList() : [];


    return list ;
  }

/*
 ler e escrever arquivo texto
   Future get _localPath async {
    // Application documents directory: /data/user/0/{package_name}/{app_name}
    final applicationDirectory = await getApplicationDocumentsDirectory();

    // External storage directory: /storage/emulated/0
    final externalDirectory = await getExternalStorageDirectory();

    // Application temporary directory: /data/user/0/{package_name}/cache
    final tempDirectory = await getTemporaryDirectory();

    return applicationDirectory.path;
  }

  Future get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/teste.txt');
  }

  Future _writeToFile(String text) async {


    final file = await _localFile;

    // Write the file
    File result = await file.writeAsString('$text');

    if (result == null ) {
      print("Writing to file failed");
    } else {
      print("Successfully writing to file");

      print("Reading the content of file");
      String readResult = await _readFile();
      print("readResult: " + readResult.toString());
    }
  }

  Future _readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      return await file.readAsString();
    } catch (e) {
      // Return null if we encounter an error
      return null;
    }
  }


*/


}