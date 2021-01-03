import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:sgihevea/model/Atividade.dart';
import 'package:sgihevea/model/Fazenda.dart';
import 'package:sgihevea/model/Funcionario.dart';
import 'package:sgihevea/model/Tarefa.dart';
import 'package:toast/toast.dart';

import 'Servico.dart'; // Contains the `Utf8Decoder` and `LineSplitter` stream transformers

//ler arquivos
class Garquivos {

  final db = DatabaseHelper.instance;

  String nomearquivo;

  String getNomeArquivo(){
    return this.nomearquivo ;
  }

  void setNomeArquivo(String nomef){
    this.nomearquivo = nomef;
  }

  Future<String> getDiretorio() async {
   final diretorio =   await getApplicationDocumentsDirectory(); //getExternalStorageDirectory();
   //getApplicationDocumentsDirectory();
   return diretorio.path;
  }

   void exportarArquivo(String nArquivo)  async{

     var arqv = nArquivo;
     switch(arqv) {
       case "atividades": {
         String direct = await getDiretorio();
         String pathfile = direct+"/"+getNomeArquivo();

         File file = new File('$pathfile');
         print("path criar: ");
         print(file.path);

         List<Atividade> listAtividade = await db.getAllAtividade();
         if (listAtividade.isNotEmpty )
         {
           print("inicio registro atividade : ");

           listAtividade.forEach((l) {

             String registro = l.id_ativ.toString()+";"+l.ativ_faze+";"+ l.data_ativ+";"+l.chapa_ativ.toString()
             +";"+l.coord_ativ.toString()+";"+l.pres_ativ+";"+l.serv_ativ.toString()+";"+l.tarefa_ativ.toString()
             +";"+l.arvore_ativ.toString()+";"+l.qtd_ativ.toString()+";"+l.sang_ativ+";"+l.plat_ativ.toString()
             +";"+l.roma_ativ.toString();


             file.writeAsStringSync('$registro', mode: FileMode.append  );

            } );
           print("fim registro atividade : ");
         }



         print("Excellent"); }
       break;

       case "B": {  print("Good"); }
       break;

       case "C": {  print("Fair"); }
       break;

       case "D": {  print("Poor"); }
       break;

       default: { print("Invalid choice"); }
       break;
     }
/*
     List letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"];
       final directory = await getApplicationDocumentsDirectory();
       String pathfile = directory.path+"/"+getNomeArquivo();
       //File('$path/textonovo1.txt');
       File file = new File('$pathfile');
       print("path criar: ");
       print(file.path);
       for (int i = 0; i < 10; i++) {
         print("listaa : "+letters[i].toString());

         file.writeAsStringSync('${letters[i]}', mode: FileMode.append  );

         print("listab : "+letters[i].toString());
       }
*/
   }



  Future importarArquivo(String nArquivo) async {

    var arqv = nArquivo;
    switch(arqv) {
      case "servicos": {

        String direct = await getDiretorio();
        String pathfile = direct+"/"+getNomeArquivo();
        BuildContext pcontext;
        Toast.show("Path import : "+pathfile, pcontext , duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

        File file = new File('$pathfile');
        print("path importar arquivo: ");
        print(file.path);

        // sync
        print("sync importar arquivo: ");
        List<String> lines = file.readAsLinesSync();
        lines.forEach((l)  async {
          print(l);
          Servico serv = new Servico();
          String registro = l;
          String field1 ="";
          String trocar ="";
          String descricao="";
          int i = 0;
          int x = registro.indexOf(";");
          while (x > 0) {
            i = i + 1;
            field1 = registro.substring(0, x);
            switch (i) {

              case 1:
                serv.id_serv = int.parse(field1);
                break;

            }
            trocar = registro.substring(x+1, registro.length);
            registro = trocar;
            x = registro.indexOf(";");

          }
          field1= registro;
          descricao = registro;


          serv.nome_serv = descricao ;
         
          List<Servico> listserv = await db.getServico(serv.id_serv ) ;
          if (listserv.isEmpty )
            {
              await db.newServico(serv);
            }



         }  );

        print("Excellent");
      }
      break;

      case "fazendas": {

        await db.deleteAllFazenda();

        String direct = await getDiretorio();
        String pathfile = direct+"/"+getNomeArquivo();

        File file = new File('$pathfile');
        print("path importar arquivo: ");
        print(file.path);

        // sync
        print("sync importar arquivo: ");
        List<String> lines = file.readAsLinesSync();
        lines.forEach((l)  async {
          print(l);
          Fazenda faz = new Fazenda();
          String registro = l;
          String field1 ="";
          String trocar ="";
          String descricao="";
          int i = 0;
          int x = registro.indexOf(";");
          while (x > 0) {
            i = i + 1;
            field1 = registro.substring(0, x);
            switch (i) {

              case 1:
                faz.id_faze = (field1);
                break;

            }
            trocar = registro.substring(x+1, registro.length);
            registro = trocar;
            x = registro.indexOf(";");

          }
          field1= registro;
          descricao = registro;


          faz.nome_faze = descricao ;
          await db.newFazenda(faz);



        }  );

        print("Good");
      }
      break;

      case "tarefas": {


        String direct = await getDiretorio();
        String pathfile = direct+"/"+getNomeArquivo();

        File file = new File('$pathfile');
        print("path importar arquivo: ");
        print(file.path);

        // sync
        print("sync importar arquivo: ");
        List<String> lines = file.readAsLinesSync();
        lines.forEach((l)  async {
          print(l);
          Tarefa taref = new Tarefa();
          String registro = l;
          String field1 ="";
          String trocar ="";
          String descricao="";
          int i = 0;
          int x = registro.indexOf(";");
          while (x > 0) {
            i = i + 1;
            field1 = registro.substring(0, x);
            switch (i) {

              case 1:
                taref.id_tarefa = int.parse(field1);
                break;

            }
            trocar = registro.substring(x+1, registro.length);
            registro = trocar;
            x = registro.indexOf(";");

          }
          field1= registro;
          descricao = registro;


          taref.qtd_tarefa = int.parse(field1);

          List<Tarefa> listtarefa = await db.getTarefa(taref.id_tarefa) ;
          if (listtarefa.isEmpty )
          {
            await db.newTarefa(taref);
          }



        }  );

        print("Fair");
      }
      break;

      case "funcionarios": {



        String direct = await getDiretorio();
        String pathfile = direct+"/"+getNomeArquivo();

        File file = new File('$pathfile');
        print("path importar arquivo: ");
        print(file.path);

        // sync
        print("sync importar arquivo: ");
        List<String> lines = file.readAsLinesSync();
        lines.forEach((l)  async {
          print(l);
          Funcionario funcio = new Funcionario();
          String registro = l;
          String field1 ="";
          String trocar ="";
          String descricao="";


          int coord_func;

          int i = 0;
          int x = registro.indexOf(";");
          while (x > 0) {
            i = i + 1;
            field1 = registro.substring(0, x);
            switch (i) {

              case 1:
                funcio.id_func = int.parse(field1);
                break;
              case 2:
                funcio.chapa_func = int.parse(field1);
                break;
              case 3:
                funcio.nome_func = field1;
                break;

            }
            trocar = registro.substring(x+1, registro.length);
            registro = trocar;
            x = registro.indexOf(";");

          }
          field1= registro;
          descricao = registro;


          funcio.coord_func = int.parse(field1);

          List<Funcionario> listfuncionario = await db.getFuncionario(funcio.chapa_func)  ;
          if (listfuncionario.isEmpty )
          {
            await db.newFuncionario(funcio);
          }



        }  );

        print("Poor");
      }
      break;

      default: { print("Invalid choice"); }
      break;
    }




    // async
    /*
    print("async readFileByLines: ");
    file.readAsLines().then((lines) =>
        lines.forEach((l) => print(l))
    );

     */


  }






}