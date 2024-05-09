import 'package:flutter/material.dart';

class CambioPassword extends StatefulWidget {
  const CambioPassword({super.key});

  @override
  State<CambioPassword> createState() => _CambioPasswordState();
}

class _CambioPasswordState extends State<CambioPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 35.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                      Text("Cambiar Contraseña",
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
                      hintText: "Ingrese contraseña anterior",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        filled: true,
                        prefixIcon: Icon(Icons.password),
                        ),
                        ),
                        SizedBox(height: 30,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Ingrese contraseña nueva",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        filled: true,
                        prefixIcon: Icon(Icons.password),
                        ),
                        ),
                        SizedBox(height: 30,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Repetir contraseña nueva",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        filled: true,
                        prefixIcon: Icon(Icons.contact_emergency_outlined),
                        ),
                        ),
                  SizedBox(height: 50,),
                  ElevatedButton.icon(
                    onPressed: (){
                    }, 
                    icon: Icon(Icons.autorenew), 
                    label: Text("Guardar"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),), backgroundColor: Colors.blue,
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
      ),
    );
  }
}