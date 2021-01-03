import 'dart:convert';

Servico ServicoFromJson(String str) {
  final jsonData = json.decode(str);
  return Servico.fromMap(jsonData);
}

String ServicoToJson(Servico data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Servico {
  int id_serv;
  String nome_serv;


  Servico({
    this.id_serv,
    this.nome_serv
  });

  factory Servico.fromMap(Map<String, dynamic> json) => new Servico(
    id_serv: json["id_serv"],
    nome_serv: json["nome_serv"],

  );

  Map<String, dynamic> toMap() => {
    "id_serv": id_serv,
    "nome_serv": nome_serv,


  };
}