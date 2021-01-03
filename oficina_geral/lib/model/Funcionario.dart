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
  int funcCod;
  int funcChapa;
  String funcNome;




  Funcionario({
    this.funcCod,
    this.funcChapa,
    this.funcNome
  });

  factory Funcionario.fromMap(Map<String, dynamic> json) => new Funcionario(
    funcCod: json["funcCod"],
    funcChapa: json["funcChapa"],
    funcNome: json["funcNome"],
  );

  Map<String, dynamic> toMap() => {
    "funcCod": funcCod,
    "funcChapa": funcChapa,
    "funcNome": funcNome,

  };
}