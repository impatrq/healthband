import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

import 'package:health_band/home.dart';

class RegisterWidget1 extends StatefulWidget {
  static String id = 'register_page';

  @override
 RegisterWidget1State createState() =>  RegisterWidget1State();
}

class  RegisterWidget1State extends State <RegisterWidget1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 4),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/backgroundbackground_registro.png',),fit: BoxFit.fill, opacity: 1),
              gradient: LinearGradient(colors:[ Color.fromRGBO(53, 169, 253, 1),Color.fromRGBO(75, 244, 244, 0.8799999952316284)])
          ),
          
          width: double.infinity, height: double.infinity,
          child: Column(
            children: [
              //Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/foto de bienvenida.png'),
              SizedBox(height: 100.0),
              Row( crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                children:[
                Transform.rotate(
                  angle: -180 * (math.pi / 180),
                  child: Container(
                    width: 40,
                    height: 40,
                    child: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView())),
                      
                    icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png'), ),
                  ),
                ),
                SizedBox(width: 60,),
                Text('Creá tu cuenta', style: TextStyle(fontSize: 25.0),)
               
            ],
              
            
                ),
                SizedBox(height: 12,),
                Text('Si sos nuevo en HealthBand, registrate y comenzá a comenzá a controlar tu salud en simples pasos.', style: TextStyle(fontSize: 16.0),),
                SizedBox(height: 32,),
                Column(
                  children:[
                    phoneNumberTextField(),
                  SizedBox(height: 36,),
                  nameTextField(),
                  SizedBox(height: 36,),
                  correoTextField(),
                  SizedBox(height: 36,),
                  buttonSubmit_1(),
                  ]
                   
                )
            ],
      ),
    ),
    )
  );
  }



Widget phoneNumberTextField() {
  return Container(
        //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children :[
            Text('Número de Teléfono', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 14, 52, 96),)),
            SizedBox(height: 4,),
            Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: const Color.fromARGB(255, 228, 228, 228)),
            child: TextField(decoration: InputDecoration(hintText: 'Ingrese su número de teléfono'),keyboardType: TextInputType.phone, onChanged: (value) {
              
            },),
          ),
          ] 
        ),
      );
}

 Widget nameTextField() {
  return Container(
     child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children :[
            Text('Nombre y Apellido', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color.fromRGBO(14, 52, 96, 1),)),
            SizedBox(height: 4,),
            Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: const Color.fromARGB(255, 228, 228, 228)),
            child: TextField(decoration: InputDecoration(hintText: 'Ingrese su nombre completo',),keyboardType: TextInputType.phone, onChanged: (value) {
              
            },),
          ),
          ] 
        ),
  );
 }

  Widget correoTextField () {
    return Container(
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children :[
            Text('Correo Electrónico', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 14, 52, 96),)),
            SizedBox(height: 4,),
            Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: const Color.fromARGB(255, 228, 228, 228)),
            child: TextField(decoration: InputDecoration(hintText: 'Ej: enzocarp912@gmail.com'),keyboardType: TextInputType.phone, onChanged: (value) {
              
            },),
          ),
          ] 
        ),
    );
    }
    Widget buttonSubmit_1(){
      return MaterialButton(
        onPressed: () {
          
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: LinearGradient(colors: [Color.fromARGB(255, 32, 92, 166), Color.fromARGB(255, 14, 52, 96)])),
          child: Text('Confirmar', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),),
        ),
      );
    }
}