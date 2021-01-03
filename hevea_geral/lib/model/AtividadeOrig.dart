import 'dart:convert';

import 'dart:ffi';



class AtividadeOrig {
  int id_ativ;
  String ativ_faze;
  String data_ativ;
  int chapa_ativ;
  int coord_ativ;
  String pres_ativ;
  int serv_ativ;
  int tarefa_ativ;
  int arvore_ativ;
  double qtd_ativ;
  String sang_ativ;
  int plat_ativ;
  int roma_ativ;
  String chavexp;


  AtividadeOrig(
      {this.id_ativ,
        this.ativ_faze,
        this.data_ativ,
        this.chapa_ativ,
        this.coord_ativ,
        this.pres_ativ,
        this.serv_ativ,
        this.tarefa_ativ,
        this.arvore_ativ,
        this.qtd_ativ,
        this.sang_ativ,
        this.plat_ativ,
        this.roma_ativ,
        this.chavexp});

  factory AtividadeOrig.fromMap(Map<String, dynamic> json) => new AtividadeOrig(
    id_ativ: json["id_ativ"],
    ativ_faze: json["ativ_faze"],
    data_ativ: json["data_ativ"],
    chapa_ativ: json["chapa_ativ"],
    coord_ativ: json["coord_ativ"],
    pres_ativ: json["pres_ativ"],
    serv_ativ: json["serv_ativ"],
    tarefa_ativ: json["tarefa_ativ"],
    arvore_ativ: json["arvore_ativ"],
    qtd_ativ: json["qtd_ativ"],
    sang_ativ: json["sang_ativ"],
    plat_ativ: json["plat_ativ"],
    roma_ativ: json["roma_ativ"],
    chavexp: json["chavexp"],


  );

  Map<String, dynamic> toMap() => {
    "id_ativ": id_ativ,
    "ativ_faze": ativ_faze,
    "data_ativ": data_ativ,
    "chapa_ativ": chapa_ativ,
    "coord_ativ": coord_ativ,
    "pres_ativ":pres_ativ,
    "serv_ativ":serv_ativ,
    "tarefa_ativ": tarefa_ativ,
    "arvore_ativ":arvore_ativ,
    "qtd_ativ":qtd_ativ,
    "sang_ativ":sang_ativ,
    "plat_ativ":plat_ativ,
    "roma_ativ":roma_ativ,
    "chavexp":chavexp,


  };

  AtividadeOrig AtividadeOrigFromJson(String str) {
    final jsonData = json.decode(str);
    return AtividadeOrig.fromMap(jsonData);
  }

  String AtividadeOrigToJson(AtividadeOrig data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}
