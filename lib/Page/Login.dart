import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_city/Page/IndexPage.dart';
import 'package:flutter_city/service/http_service.dart';
import 'package:flutter_city/service/htttp_config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _loginPageSate();

}

class _loginPageSate extends State<LoginPage> {

  final username = TextEditingController();
  final password = TextEditingController();

  void _login() {
    final response = post(
        postLogin,
        data: {"username": username.text, "password": password.text}
    );

    response.then((response) {
      var data = json.decode(response.toString());
      if (data["code"] == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IndexPage(),));
        token = data["token"];
      }else{
        Fluttertoast.showToast(msg: "${data["msg"]}",toastLength: Toast.LENGTH_LONG);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              child: TextFormField(
                controller: username,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "用户名",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12, width: 2),
                    ),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              width: 250,
              child: TextFormField(
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "密码",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12, width: 2),
                    )
                ),
              ),
            ),

            SizedBox(height: 20,),

            Container(
              width: 250,
              height: 40,
              child: ElevatedButton(
                onPressed: (){
                  _login();
                },
                child: Text("登录"),
              ),
            )

          ],
        ),
      ),
    );
  }
}