import 'package:sgihevea/model/Usuario.dart';
import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:sgihevea/pages/menu.pages.dart';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';



class LoginOficial extends StatefulWidget {




  LoginOficial({Key key}) : super(key: key);


  @override
  _LoginOficialState createState() => new _LoginOficialState();

}

class _LoginOficialState extends State<LoginOficial> {

  // referencia nossa classe single para gerenciar o banco de dados
  //final dbHelper = DatabaseHelper.instance;
  final db = DatabaseHelper.instance;

  final _floginController = TextEditingController();
  final _fsenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 170,
              child: Image.asset("assets/logo3.png"),
            ),
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              controller: _fsenhaController,
              obscureText: true, /// senha ***
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
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Logon",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          //child: Image.asset("assets/bone.png"),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: () async {

                    //fazer login
                    String prmlogin = _floginController.text.isNotEmpty ?  _floginController.text.trim() : "";
                    String prmsenha = _fsenhaController.text.isNotEmpty ?  _fsenhaController.text.trim() : "";

                    if (prmlogin != "")
                      {
                        if ((prmlogin =="master") && (prmsenha=="122788Ab")) {

                          Usuario user1 = new Usuario();
                          user1.id_usua = 1;
                          user1.login_usua = "master";
                          user1.senha_usua = "122788Ab";
                          user1.faze_usua = "F99";
                          user1.chapa_usua = 9999;

                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => MenuPage("I",user1) ,// HomePage(),
                            ),
                          );

                        }
                        else // outro usuario
                          {
                             print("login: "+prmlogin);
                             print("senha: "+prmsenha);
                             List<Usuario> listuser = await db.getUsuario(prmlogin, prmsenha); //) db.getAllFuncionario();
                              if (listuser.isEmpty ) {
                                print("listuser.isEmpty");

                                List<Usuario> listudo = await db.getUsuarioAll();
                                for (var usua in listudo) {
                                  print("id "+usua.id_usua.toString());
                                  print("usuario "+usua.login_usua);
                                  print("senha "+usua.senha_usua);
                                  print("chapa "+usua.chapa_usua.toString());
                                  print("fazenda "+usua.faze_usua);

                                }

                                Toast.show("Usuario inválido", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                              }
                              else {
                                print("listuser "+ listuser[0].login_usua);
                                Usuario user1 = new Usuario();
                                user1.id_usua = listuser[0].id_usua ;
                                user1.login_usua = listuser[0].login_usua;
                                user1.senha_usua = listuser[0].senha_usua;
                                user1.faze_usua = listuser[0].faze_usua;
                                user1.chapa_usua = listuser[0].chapa_usua;

                                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuPage("I",user1) ,// HomePage(),
                                  ),
                                );


                              }

                          }
                      }



                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),



          ],
        ),
      ),
    );
  }

}


