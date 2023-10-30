import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:health_band/home.dart';
import 'package:health_band//Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/registro2.dart';
//import 'package:health_band/form_validator.dart';
//import 'package:flutter_laravel_form_validation/flutter_laravel_form_validation.dart';

class RegisterWidget1 extends StatefulWidget {
  static String id = 'register_page';
  TextEditingController ctrlNumber = TextEditingController();

  RegisterWidget1({super.key});
  @override
 RegisterWidget1State createState() =>  RegisterWidget1State();
}

class  RegisterWidget1State extends State <RegisterWidget1> {
  TextEditingController ctrlNumber = TextEditingController();
  TextEditingController ctrlMail = TextEditingController();
  TextEditingController ctrlName = TextEditingController();
  GlobalKey <FormState> keyForm = GlobalKey <FormState>();
  final _keyForm = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
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
                    buttonSubmit_1(),
                  ]
                   
                )
                )
                     
            ],
      ),
    ),
    )
  );
  }

    Widget buttonSubmit_1(){
      return MaterialButton(
        onPressed: () {
          if(_keyForm.currentState!.validate()){ 
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => const RegisterView2()));
          }
          

          
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(colors: [Color.fromARGB(255, 32, 92, 166), Color.fromARGB(255, 14, 52, 96)])),
          child: const Text('Confirmar', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),)
            ),
        );
      
    }
}