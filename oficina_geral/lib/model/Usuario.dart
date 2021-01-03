import 'dart:convert';

Usuario UsuarioFromJson(String str) {
  final jsonData = json.decode(str);
  return Usuario.fromMap(jsonData);
}

String UsuarioToJson(Usuario data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Usuario {
  int userId;
  String userLogin;
  String userSenha;
  int funcChapa;
  int funcCodigo;



  Usuario({
    this.userId,
    this.userLogin,
    this.userSenha,
    this.funcChapa,
    this.funcCodigo

  });

  factory Usuario.fromMap(Map<String, dynamic> json) => new Usuario(
    userId: json["userId"],
    userLogin: json["userLogin"],
    userSenha: json["userSenha"],
    funcChapa: json["funcChapa"],
    funcCodigo: json["funcCodigo"],
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "userLogin": userLogin,
    "userSenha": userSenha,
    "funcChapa": funcChapa,
    "funcCodigo": funcCodigo,

  };
}