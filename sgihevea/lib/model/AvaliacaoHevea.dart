import 'dart:convert';

class AvaliacaoHevea {
  int id ;
  int chapa ;
  String nomefunc;
  int ano ;
  int mes ;
  double nota ;
  int coord ;
  String faze;



  AvaliacaoHevea({
    this.id,
    this.chapa,
    this.nomefunc,
    this.ano,
    this.mes,
    this.nota,
    this.coord,
    this.faze

  });

  factory AvaliacaoHevea.fromMap(Map<String, dynamic> json) => new AvaliacaoHevea(
    id: json["id"],
    chapa: json["chapa"],
    nomefunc: json["nomefunc"],
    ano: json["ano"],
    mes: json["mes"],
    nota: json["nota"],
    coord: json["coord"],
    faze: json["faze"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "chapa": chapa,
    "nomefunc": nomefunc,
    "ano": ano,
    "mes": mes,
    "nota": nota,
    "coord": coord,
    "faze": faze,

  };

  AvaliacaoHevea AvaliacaoHeveaFromJson(String str) {
    final jsonData = json.decode(str);
    return AvaliacaoHevea.fromMap(jsonData);
  }

  String AvaliacaoHeveaToJson(AvaliacaoHevea data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}