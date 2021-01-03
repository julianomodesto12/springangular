import 'dart:convert';

OrdemServico OrdemServicoFromJson(String str) {
  final jsonData = json.decode(str);
  return OrdemServico.fromMap(jsonData);
}

String OrdemServicoToJson(OrdemServico data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class OrdemServico {
  int orseCodigo;
  String orseDescricao;


  OrdemServico({
    this.orseCodigo,
    this.orseDescricao
  });

  factory OrdemServico.fromMap(Map<String, dynamic> json) => new OrdemServico(
    orseCodigo: json["orseCodigo"],
    orseDescricao: json["orseDescricao"],
  );

  Map<String, dynamic> toMap() => {
    "orseCodigo": orseCodigo,
    "orseDescricao": orseDescricao,
  };
}