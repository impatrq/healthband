import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:health_band/home.dart';


class RegisterView2 extends StatefulWidget{
  static String id = 'register_page';

  const RegisterView2({super.key});
  @override
 RegisterWidget2State createState() =>  RegisterWidget2State();
}

class RegisterWidget2State extends State <RegisterView2>{
  final _keyForm = GlobalKey <FormState>();

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/backgroundbackground_registro.png',),fit: BoxFit.fill, opacity: 1),
              gradient: LinearGradient(colors:[ Color.fromRGBO(53, 169, 253, 1),Color.fromRGBO(75, 244, 244, 0.8799999952316284)])
          ),
          
          width: double.infinity, height: double.infinity,
          child: Column(
            children: [
              //Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/foto de bienvenida.png'),
              const SizedBox(height: 100.0),
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                children:[
                Transform.rotate(
                  angle: -180 * (math.pi / 180),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView())),
                      
                    icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png'), ),
                  ),
                ),
                const SizedBox(width: 60,),
                const Text('Creá tu cuenta', style: TextStyle(fontSize: 25.0),)
               
                ],
              
            
              ),
              const SizedBox(height: 12),
              const Text('Si sos nuevo en HealthBand, registrate y comenzá a comenzá a controlar tu salud en simples pasos.', style: TextStyle(fontSize: 16.0),),
              const SizedBox(height: 32),
              Form(
                key: _keyForm,
                child: ListView(
                children:[
                  const SizedBox(height: 36,),
                  TextFormField( validator: (value) {
                    if (value == null || value.isEmpty || value.length < 13){
                      return 'Este campo debe contener al menos 13 caracteres';
                      }
                    return null;
                      }
                    ),
                    const SizedBox(height: 36,),
                    TextFormField( validator: (value) {
                      if (value == null || value.isEmpty || value.length < 13){
                        return 'Este campo debe contener al menos 13 caracteres';
                      }
                      return null;
                      }
                    ),
                    const SizedBox(height: 36,),
                    TextFormField( validator: (value) {
                      if (value == null || value.isEmpty || value.length < 13){
                        return 'Este campo debe contener al menos 13 caracteres';
                      }
                      return null;
                      }
                    ),
                    const SizedBox(height: 36,),
                    //buttonSubmit_1(),
                  ]
                   
                )
                )
                     
            ],
      ),
    ),
  ),
);
  }
}