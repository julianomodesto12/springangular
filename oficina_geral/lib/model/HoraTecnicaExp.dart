import 'dart:convert';



class HoraTecnicaExp {
  int hoteCodigo;
  int funcCod;
  int funcChapa;
  String hoteData;
  int tipo;
  int ithoCodigo;
  int orseCodigo;
  int compCodigo;
  int mohaCodigo;
  int ithoHorainicio;
  int ithoHorafim;
  double valorhora;
  String osEncerrar;
  String chavexp;
  String exportado;



  HoraTecnicaExp({
    this.hoteCodigo,
    this.funcCod,
    this.funcChapa,
    this.hoteData,
    this.tipo,
    this.ithoCodigo,
    this.orseCodigo,
    this.compCodigo,
    this.mohaCodigo,
    this.ithoHorainicio,
    this.ithoHorafim,
    this.valorhora,
    this.osEncerrar,
    this.chavexp,
    this.exportado

  });

  factory HoraTecnicaExp.fromMap(Map<String, dynamic> json) => new HoraTecnicaExp(
    hoteCodigo: json["hoteCodigo"],
    funcCod: json["funcCod"],
    funcChapa: json["funcChapa"],
    hoteData: json["hoteData"],
    tipo: json["tipo"],
    ithoCodigo: json["ithoCodigo"],
    orseCodigo: json["orseCodigo"],
    compCodigo: json["compCodigo"],
    mohaCodigo: json["mohaCodigo"],
    ithoHorainicio: json["ithoHorainicio"],
    ithoHorafim: json["ithoHorafim"],
    valorhora: json["valorhora"],
    osEncerrar: json["osEncerrar"],
    chavexp: json["chavexp"],
    exportado: json["exportado"],


  );

  Map<String, dynamic> toMap() => {
    "hoteCodigo": hoteCodigo,
    "funcCod": funcCod,
    "funcChapa": funcChapa,
    "hoteData": hoteData,
    "tipo": tipo,
    "ithoCodigo": ithoCodigo,
    "orseCodigo": orseCodigo,
    "compCodigo": compCodigo,
    "mohaCodigo": mohaCodigo,
    "ithoHorainicio": ithoHorainicio,
    "ithoHorafim": ithoHorafim,
    "valorhora": valorhora,
    "osEncerrar": osEncerrar,
    "chavexp": chavexp,
    "exportado": exportado,

  };

  HoraTecnicaExp HoraTecnicaExpFromJson(String str) {
    final jsonData = json.decode(str);
    return HoraTecnicaExp.fromMap(jsonData);
  }

  String HoraTecnicaExpToJson(HoraTecnicaExp data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}