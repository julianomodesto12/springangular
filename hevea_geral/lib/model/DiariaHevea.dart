import 'dart:convert';

import 'dart:ffi';


class DiariaHevea {
  int id;
  String data_ativ;
  int chapa;
  String funcionario;
  int tarefa;
  double arvores;
  int coord;
  String faze;


  DiariaHevea(
      {this.id,
        this.data_ativ,
        this.chapa,
        this.funcionario,
        this.tarefa,
        this.arvores,
        this.coord,
        this.faze
    });

  factory DiariaHevea.fromMap(Map<String, dynamic> json) => new DiariaHevea(
    id: json["id"],
    data_ativ: json["data_ativ"],
    chapa: json["chapa"],
    funcionario: json["funcionario"],
    tarefa: json["tarefa"],
    arvores: json["arvores"],
    coord: json["coord"],
    faze: json["faze"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "data_ativ": data_ativ,
    "chapa": chapa,
    "funcionario": funcionario,
    "tarefa": tarefa,
    "arvores": arvores,
    "coord": coord,
    "faze": faze,

  };

  DiariaHevea DiariaHeveaFromJson(String str) {
    final jsonData = json.decode(str);
    return DiariaHevea.fromMap(jsonData);
  }

  String DiariaHeveadeToJson(DiariaHevea data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}