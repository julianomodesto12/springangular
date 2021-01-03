import 'dart:convert';

Componente ComponenteFromJson(String str) {
  final jsonData = json.decode(str);
  return Componente.fromMap(jsonData);
}

String ComponenteToJson(Componente data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Componente {
  int compCodigo;
  String compDescricao;



  Componente({
    this.compCodigo,
    this.compDescricao
  });

  factory Componente.fromMap(Map<String, dynamic> json) => new Componente(
    compCodigo: json["compCodigo"],
    compDescricao: json["compDescricao"],
  );

  Map<String, dynamic> toMap() => {
    "compCodigo": compCodigo,
    "compDescricao": compDescricao,
  };
}