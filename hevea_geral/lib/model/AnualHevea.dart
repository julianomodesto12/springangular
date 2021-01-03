import 'dart:convert';

import 'dart:ffi';


class AnualHevea {
  int id;
  int tarefa;
  double cortes;
  int coord;
  String nomecoord;
  String faze;

  AnualHevea(
      {this.id,
        this.tarefa,
        this.cortes,
        this.coord,
        this.nomecoord,
        this.faze
      });

  factory AnualHevea.fromMap(Map<String, dynamic> json) => new AnualHevea(
    id: json["id"],
    tarefa: json["tarefa"],
    cortes: json["cortes"],
    coord: json["coord"],
    nomecoord: json["nomecoord"],
    faze: json["faze"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "tarefa": tarefa,
    "cortes": cortes,
    "coord": coord,
    "nomecoord": nomecoord,
    "faze": faze,

  };

  AnualHevea AnualHeveaFromJson(String str) {
    final jsonData = json.decode(str);
    return AnualHevea.fromMap(jsonData);
  }

  String AnualHeveadeToJson(AnualHevea data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}