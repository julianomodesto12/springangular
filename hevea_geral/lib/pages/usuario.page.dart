import 'package:flutter/material.dart';
import 'package:sgihevea/model/Usuario.dart';
import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:toast/toast.dart';


class UsuarioPage extends StatelessWidget {
  //passar parametro para page stateless
  String ptext;
  Usuario pusuario;


  UsuarioPage( this.ptext,this.pusuario );




  @override
  Widget build(BuildContext context ) {


    return  Scaffold(

      body: new UsuarioPagefulWidget(text :this.ptext , usuario : this.pusuario ),
    );

  }

}

class UsuarioPagefulWidget extends StatefulWidget {
  String text;
  Usuario usuario;
  //UsuarioPage(this.url, this.fileName,[this.extension='txt']);

  //UsuarioPage({Key key}) : super(key: key);
  UsuarioPagefulWidget({Key key,  @required this.text,  @required this.usuario  }) : super(key: key);

  @override
  _UsuarioPagefulWidgetState createState() => new _UsuarioPagefulWidgetState();

}

class _UsuarioPagefulWidgetState extends State<UsuarioPagefulWidget> {

  String ptexto ;
  Usuario user;

  void limparDados(){
    _floginController.clear();
    _fsenhaController.clear();
    _fchapaController.clear();
    _ffazendaController.clear();

  }


  void preencherDados(Usuario newusuario){
    _floginController.text = newusuario.login_usua;
    _fsenhaController.text = newusuario.senha_usua;
    _fchapaController.text = newusuario.chapa_usua.toString();
    _ffazendaController.text = newusuario.faze_usua;

  }

  Future initState()  {
    ptexto = widget.text;
    user = widget.usuario;

    preencherDados(widget.usuario);

    super.initState();
  }

  final db = DatabaseHelper.instance;



  final _floginController = TextEditingController();
  final _fsenhaController = TextEditingController();
  final _fchapaController = TextEditingController();
  final _ffazendaController = TextEditingController();





  Future<bool> _validarDados()  async {

    bool retorno = true;
    widget.usuario.chapa_usua;



    String login =  _floginController.text.isNotEmpty ?  _floginController.text   : "x" ;
    String senha =  _fsenhaController.text.isNotEmpty ?  _fsenhaController.text   : "x" ;
    int chapa =  _fchapaController.text.isNotEmpty ? int.parse(_fchapaController.text)   : 0 ;
    String faz =  _ffazendaController.text.isNotEmpty ?  _ffazendaController.text   : "x" ;

    //validar campos

    if (login == "x") {
      retorno = false;
      print("login invalido");
      Toast.show("login invalido", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }

    if (senha == "x") {
      retorno = false;
      print("senha invalida");
      Toast.show("senha invalida", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }

    if (( faz == "F5") || ( faz == "F15") || ( faz == "F12") || ( faz == "F42")  || ( faz == "F43") ) {

      print("fazenda valida");

    }
    else
      {
        retorno = false;
        print("fazenda invalida");
        Toast.show("fazenda invalida", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }

    //print("antes lista");

    if (chapa <= 0 ) {
      retorno = false;
      print("func invalido: $chapa"  );
      Toast.show("Funcionário inválido", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

    }




    print("RETORNO: $retorno");
    if (retorno){

      Usuario usersave = new Usuario();
      usersave.login_usua = login;
      usersave.chapa_usua = chapa;
      usersave.senha_usua = senha;
      usersave.faze_usua = faz;


      print("verifca usuario novo :"+widget.usuario.id_usua .toString());
      if (widget.usuario.id_usua > 0 ) //se existir dados na classe update , se nao insert
      {
        usersave.id_usua = chapa;
        print("_updateDados(usersave)");
        _updateDados(usersave);

      }

      if (widget.usuario.id_usua == 0 ) {
        print("saveDados(usersave)");
        usersave.id_usua = chapa;

        _saveDados(usersave);
      }


    }


    return retorno;

  }//validar dados

  void _saveDados(Usuario newuser){
    print("antes salvar");
    db.newUsuario(newuser);
    print("depois salvar");
    print("id "+newuser.id_usua.toString());
    print("usuario "+newuser.login_usua);
    print("senha "+newuser.senha_usua);
    print("chapa "+newuser.chapa_usua.toString());
    print("fazenda "+newuser.faze_usua);
    Toast.show("Registro efetuado com êxito", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  void _updateDados(Usuario newuser){
    db.updateUsuario(newuser);
    Toast.show("Registro efetuado com êxito", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Usuario'),
          centerTitle: true,
          backgroundColor: Color(0XFF4CAF50),
        ),
        body:
        Container(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20),
          color: Colors.white,
          child: ListView(
              children: <Widget>[


                TextFormField(
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  controller: _floginController,

                  decoration: InputDecoration(
                    labelText: "Login",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),

                TextFormField(
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  controller: _fsenhaController,
                  // onChanged: (v) => _fcoordenadorController.text = v,

                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),



                TextFormField(
                  // autofocus: true,
                  controller: _ffazendaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Fazenda",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),

                TextFormField(
                  // autofocus: true,
                  controller: _fchapaController,
                  //onChanged: (v) => _ftarefaController.text = v,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Chapa",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),



                SizedBox(
                  height: 40,

                ),
                Container(
                  height: 60,

                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1],
                      colors: [
                        Color(0xFF1B5E20),
                        Color(0XFF4CAF50),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: SizedBox.expand(
                      child: new Center(
                        child: new Row(
                          //spaceBetween
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            //dart treates everything as objects so we pass a function in onPressed value
                            new FlatButton(onPressed: () {
                              limparDados();
                              print("novo");
                              Usuario aux = new Usuario();
                              aux.id_usua = 0;
                              widget.usuario = aux;
                              widget.text = "I";
                              print("id: "+widget.usuario.id_usua.toString());
                            },
                                child: new Text('Novo'
                                  ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                )),
                            new FlatButton(onPressed: () async {
                              bool val = await  _validarDados();
                              if ( val ) {
                                print("ok");
                                print("widget: "+ widget.text);
                                widget.text = "P" ;//gravado
                              }
                              else
                              {
                                Toast.show("Dados estao incorretos", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                print("invalido");
                              }
                            },
                                child: new Text('Salvar'
                                  ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                )),

                            new FlatButton(onPressed: () async {


                              if (widget.usuario.id_usua > 0 ) {
                                await db.deleteUsuario(widget.usuario.id_usua);
                              }
                              print("excluir usuario");
                              print("usuario: " + widget.usuario.login_usua.toString());
                              print("excluir text");
                              print(widget.text);
                            },
                                child: new Text('Excluir'
                                  ,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                )),
                          ],

                        ),

                      )

                  ),
                ),

              ]
          ),
        )
    );
  }



}