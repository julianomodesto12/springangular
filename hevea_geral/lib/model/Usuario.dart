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
  String faze_usua;
  int chapa_usua;




  Usuario({
    this.id_usua,
    this.login_usua,
    this.senha_usua,
    this.faze_usua,
    this.chapa_usua

  });

  factory Usuario.fromMap(Map<String, dynamic> json) => new Usuario(
    id_usua: json["id_usua"],
    login_usua: json["login_usua"],
    senha_usua: json["senha_usua"],
    faze_usua: json["faze_usua"],
    chapa_usua: json["chapa_usua"],
  );

  Map<String, dynamic> toMap() => {
    "id_usua": id_usua,
    "login_usua": login_usua,
    "senha_usua": senha_usua,
    "faze_usua": faze_usua,
    "chapa_usua": chapa_usua,

  };
}