import 'dart:convert';

Motivo MotivoFromJson(String str) {
  final jsonData = json.decode(str);
  return Motivo.fromMap(jsonData);
}

String MotivoToJson(Motivo data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Motivo {
  int mohaCodigo;
  String mohaDescricao;




  Motivo({
    this.mohaCodigo,
    this.mohaDescricao
  });

  factory Motivo.fromMap(Map<String, dynamic> json) => new Motivo(
    mohaCodigo: json["mohaCodigo"],
    mohaDescricao: json["mohaDescricao"],
  );

  Map<String, dynamic> toMap() => {
    "mohaCodigo": mohaCodigo,
    "mohaDescricao": mohaDescricao,
  };
}