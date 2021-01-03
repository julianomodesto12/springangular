import 'dart:convert';
import 'dart:core';





class FuncionarioRM {

  String matricula ;
  String cpf ;
  String celular ;
  int codcoligada;
  String nomefuncionario;
  int coord;
  String cod_faze;


  FuncionarioRM({
    this.matricula,
    this.cpf,
    this.celular,
    this.codcoligada,
    this.nomefuncionario,
    this.coord,
    this.cod_faze
  });


  factory FuncionarioRM.fromMap(Map<String, dynamic> json) => new FuncionarioRM(
    matricula: json["matricula"],
    cpf: json["cpf"],
    celular: json["celular"],
    codcoligada: json["codcoligada"],
    nomefuncionario: json["nomefuncionario"],
    coord: json["coord"],
    cod_faze: json["cod_faze"],
  );


  Map<String, dynamic> toMap() => {
    "matricula": matricula,
    "cpf": cpf,
    "celular": celular,
    "codcoligada": codcoligada,
    "nomefuncionario": nomefuncionario,
    "coord": coord,
    "cod_faze": cod_faze,
  };

/*
  factory FuncionarioRM.fromMap(Map<String, dynamic> json) => new FuncionarioRM(
    matricula: json["matricula"],
    cpf: json["cpf"],
    celular: json["celular"],
    codcoligada: json["codcoligada"],
    nomefuncionario: json["nomefuncionario"],
    coord: json["coord"],
    cod_faze: json["cod_faze"],
  );

  Map<String, dynamic> toMap() => {
    "matricula": matricula,
    "cpf": cpf,
    "celular": celular,
    "codcoligada": codcoligada,
    "nomefuncionario": nomefuncionario,
    "coord": coord,
    "cod_faze": cod_faze,
  };

*/




  FuncionarioRM FuncionarioRMFromJson(String str) {
    final jsonData = json.decode(str);
    return FuncionarioRM.fromMap(jsonData);
  }

  String FuncionarioRMToJson(FuncionarioRM data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}







