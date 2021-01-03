import 'dart:convert';

import 'dart:ffi';


class MensalHevea {
  int id;
  int tarefa;
  int ano;
  int mes;
  double cortes;
  int coord;
  String nomecoord;
  String faze;


  MensalHevea(
      {this.id,
        this.tarefa,
        this.ano,
        this.mes,
        this.cortes,
        this.coord,
        this.nomecoord,
        this.faze
      });

  factory MensalHevea.fromMap(Map<String, dynamic> json) => new MensalHevea(
    id: json["id"],
    tarefa: json["tarefa"],
    ano: json["ano"],
    mes: json["mes"],
    cortes: json["cortes"],
    coord: json["coord"],
    nomecoord: json["nomecoord"],
    faze: json["faze"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "tarefa": tarefa,
    "ano": ano,
    "mes": mes,
    "cortes": cortes,
    "coord": coord,
    "nomecoord": nomecoord,
    "faze": faze,

  };

  MensalHevea MensalHeveaFromJson(String str) {
    final jsonData = json.decode(str);
    return MensalHevea.fromMap(jsonData);
  }

  String MensalHeveadeToJson(MensalHevea data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}