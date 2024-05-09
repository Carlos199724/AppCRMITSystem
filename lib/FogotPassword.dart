import 'package:flutter/material.dart';

class FogotPassword extends StatefulWidget {
  const FogotPassword({super.key});

  @override
  State<FogotPassword> createState() => _FogotPasswordState();
}

class _FogotPasswordState extends State<FogotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/Logo-simplificado-negro.png', height: 20,width:180),
              ],
            ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.grey,)),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recuperar Contraseña",
                        style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                             ),
                        ),
                  ],
                ),
                SizedBox(height: 30,),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Ingrese correo electrónico",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                      fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      filled: true,
                      prefixIcon: Icon(Icons.attach_email),
                      ),
                      ),
                SizedBox(height: 50,),
                ElevatedButton.icon(
                  onPressed: (){
                  }, 
                  icon: Icon(Icons.check_circle_outline), 
                  label: Text("Enviar"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),),
                    padding: EdgeInsets.all(1.0),
                    fixedSize: Size(411, 45),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    elevation: 10,
                    shadowColor: Colors.lightBlue[100],
                    side: BorderSide(color: Colors.blue, width: 1),
                    ),
                    ),
                
                
        ],
          ),
      ),
    );
  }
}