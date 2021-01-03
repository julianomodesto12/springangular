import 'dart:convert';


class Fazenda {
  String id_faze;
  String nome_faze;




  Fazenda({
    this.id_faze,
    this.nome_faze
  });

/*
  Fazenda.fromJson(Map<String, dynamic> json) {
    id_faze = json['id_faze'];
    nome_faze = json['nome_faze'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_faze'] = this.id_faze;
    data['nome_faze'] = this.nome_faze;
    return data;
  }
*/

  factory Fazenda.fromMap(Map<String, dynamic> json) => new Fazenda(
    id_faze: json["id_faze"],
    nome_faze: json["nome_faze"],

  );

  Map<String, dynamic> toMap() => {
    "id_faze": id_faze,
    "nome_faze": nome_faze,


  };


  Fazenda FazendaFromJson(String str) {
    final jsonData = json.decode(str);
    return Fazenda.fromMap(jsonData);
  }

  String FazendaToJson(Fazenda data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}

