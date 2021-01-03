import 'package:flutter/material.dart';
import 'package:oficinamobile/dao/DatabaseHelper.dart';
import 'package:oficinamobile/model/Usuario.dart';
import 'package:toast/toast.dart';

import 'menu.pages.dart';

class LoginPage extends StatefulWidget {




  LoginPage({Key key}) : super(key: key);


  @override
  _LoginPageState createState() => new _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

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
              child: Image.asset("assets/oficina1.png"),
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
                    Color(0xFF1B5E20), // azul 0xFF0D47A1
                    Color(0xFF4CAF50), //azul 0xFF2962FF
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
                        user1.userId = 1;
                        user1.userLogin = "master";
                        user1.userSenha = "122788Ab";
                        user1.funcChapa = 00;
                        user1.funcCodigo = 00;

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


                          }

                          Toast.show("Usuario inválido", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                        }
                        else {

                          Usuario user1 = new Usuario();
                          user1.userId = listuser[0].userId;
                          user1.userLogin = listuser[0].userLogin;
                          user1.userSenha = listuser[0].userSenha;
                          user1.funcChapa = listuser[0].funcChapa;
                          user1.funcCodigo = listuser[0].funcCodigo;

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