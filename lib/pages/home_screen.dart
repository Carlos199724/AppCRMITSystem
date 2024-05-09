import 'package:crmproyect/secon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../service/httpbd.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  final HttpService httpService = HttpService();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> Second(),));///////
    });
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:[Colors.white, Color.fromARGB(255, 117, 193, 255), Colors.blue],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Image.asset('assets/Logo-original-negro.png', height: 150,width:350),
            SizedBox(height: 20,),
            Text(
              'Bienvenido', 
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 32,
              ),),
              SizedBox(height: 20,),
              SpinKitWave(color: Colors.white,size: 50.0,),
          ],
        ),
      ),
      
    );
  }
}