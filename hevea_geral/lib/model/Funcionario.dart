import 'dart:convert';

Funcionario FuncionarioFromJson(String str) {
  final jsonData = json.decode(str);
  return Funcionario.fromMap(jsonData);
}

String FuncionarioToJson(Funcionario data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Funcionario {
  int id_func;
  int chapa_func;
  String nome_func;
  int coord_func;


  Funcionario({
    this.id_func,
    this.chapa_func,
    this.nome_func,
    this.coord_func
  });

  factory Funcionario.fromMap(Map<String, dynamic> json) => new Funcionario(
    id_func: json["id_func"],
    chapa_func: json["chapa_func"],
    nome_func: json["nome_func"],
    coord_func: json["coord_func"],

  );

  Map<String, dynamic> toMap() => {
    "id_func": id_func,
    "chapa_func": chapa_func,
    "nome_func": nome_func,
    "coord_func": coord_func,

  };
}