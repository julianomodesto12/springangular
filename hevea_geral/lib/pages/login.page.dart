import 'package:sgihevea/model/Usuario.dart';
import 'package:sgihevea/dao/DatabaseHelper.dart';
import 'package:sgihevea/pages/menu.pages.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // referencia nossa classe single para gerenciar o banco de dados
  //final dbHelper = DatabaseHelper.instance;
  final db = DatabaseHelper.instance;

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
                  onPressed: () {

                    Usuario user1 = new Usuario();
                    user1.id_usua = 1;
                    user1.login_usua = "julianomodesto12";
                    user1.senha_usua = "12345";

                     Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => MenuPage("I",user1) ,// HomePage(),
                      ),
                    );

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