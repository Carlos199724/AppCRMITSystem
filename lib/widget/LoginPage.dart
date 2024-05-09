import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import '../FogotPassword.dart';//
import '../checkbox.dart';
import '../pages/home_screen.dart';
import 'dart:convert'; //insertado
import 'package:shared_preferences/shared_preferences.dart'; //insertado

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  bool isPasswordVisible = true;
  bool isLoading=false;
  var usernameController = TextEditingController();
  var passController = TextEditingController();
  var iduser= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, //dar espacion de titulo con el formulario
            children: [
              _header(context),
              _inputField(context),
              //_forgotPassword(context),//
            ],
            ),
        ),
          ),
    );
  }
  _header(context){
    return Column(
      children: [
        Text("Iniciar Sesión", style: TextStyle(
          fontSize: 30,
          color: Colors.blueGrey.shade200, 
          fontWeight: 
          FontWeight.bold),),
      ],
    );
  }
  _inputField(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: "Usuario",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 15),
        TextField(
          controller: passController,
          decoration: InputDecoration(
            hintText: "Contraseña",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.password), // icono password
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: IconButton(
                onPressed: (){
                  setState(() {
                    isPasswordVisible=
                    !isPasswordVisible;
                  });
                }, 
                icon: Icon(
                  Icons.visibility,
                  color:Colors.blue,
                ), 
              ),
            ),
          ),
          obscureText: isPasswordVisible, // para ocultar contraseña ***
        ),
        SizedBox(height: 19),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CheckBox('Recordarme'),
        ),
        SizedBox(height: 19),
        ElevatedButton(
          onPressed: () async {
            if (isLoading) return;
            setState(() => isLoading = true);
            await Future.delayed(Duration(seconds: 4));
            setState(() => isLoading = false);
            login();
            },
            child: isLoading
            ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white),
                const SizedBox(width: 20),
                Text('Un momento por favor', style: TextStyle(color: Colors.white)),
                ],
                )
                : Text(
                  "Ingresar",
                  style: TextStyle(fontSize: 20, color: Colors.white), // Establecer color del texto
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue, // Establecer color de fondo
                    ),
                  )
      ],
    );
  }
  /*_forgotPassword(context){
    return TextButton(onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FogotPassword(),));
    }, child: Text("¿Olvidaste tu contraseña?"));
  }*/

//https://crm2.itscloud.store/api/login
  //extraer api
  Future<void> login() async {
    if(passController.text.isNotEmpty && usernameController.text.isNotEmpty){
    var response = await http.post(Uri.parse("http://127.0.0.1:8000/api/login"),
        body: ({
          'username': usernameController.text,
          'password': passController.text,
          'id': iduser.text
        }));
    if (response.statusCode == 200){
      var responseData = json.decode(response.body); //insertado
      String accessToken = responseData['access_token'];
      int userId = responseData['id'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setInt('userId', userId);
      
      Navigator.push(
        context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: 90,
                decoration: BoxDecoration(
                  color: Color(0xffc72c41),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline_outlined, color: Colors.white,size: 40,),
                    const SizedBox(width: 48,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("¡Oh algo salio mal!", style: TextStyle(fontSize: 20, color: Colors.white),),
                          Text("Las credenciales son incorrectas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),
            ],
          ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,  
            ));  
    }
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Container(
              padding: EdgeInsets.all(16),
              height: 90,
              decoration: BoxDecoration(color: Color.fromRGBO(170, 107, 13, 0.829),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.running_with_errors_outlined, color: Colors.white,size: 40,),
                    const SizedBox(width: 48,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("¡Oh! Te has olvidado de algo!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text("Por favor ingresar datos al campo vacio",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            )); 

    }
  }
}
