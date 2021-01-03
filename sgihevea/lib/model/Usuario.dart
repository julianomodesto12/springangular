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
  int id_usua;
  String login_usua;
  String senha_usua;




  Usuario({
    this.id_usua,
    this.login_usua,
    this.senha_usua

  });

  factory Usuario.fromMap(Map<String, dynamic> json) => new Usuario(
    id_usua: json["id_usua"],
    login_usua: json["login_usua"],
    senha_usua: json["senha_usua"],
  );

  Map<String, dynamic> toMap() => {
    "id_usua": id_usua,
    "login_usua": login_usua,
    "senha_usua": senha_usua,

  };
}