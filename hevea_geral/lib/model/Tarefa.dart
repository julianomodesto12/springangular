import 'dart:convert';



class Tarefa {
  int id_tarefa;
  int qtd_tarefa;



  Tarefa({
    this.id_tarefa,
    this.qtd_tarefa
  });

  factory Tarefa.fromMap(Map<String, dynamic> json) => new Tarefa(
    id_tarefa: json["id_tarefa"],
    qtd_tarefa: json["qtd_tarefa"],

  );

  Map<String, dynamic> toMap() => {
    "id_tarefa": id_tarefa,
    "qtd_tarefa": qtd_tarefa,


  };

  Tarefa TarefaFromJson(String str) {
    final jsonData = json.decode(str);
    return Tarefa.fromMap(jsonData);
  }

  String TarefaToJson(Tarefa data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

}