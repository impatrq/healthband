import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:health_band/home.dart';


class RegisterView2 extends StatefulWidget{
  static String id = 'register_page';
  RegisterView2({super.key});
  @override
 RegisterWidget2State createState() =>  RegisterWidget2State();
}

class RegisterWidget2State extends State <RegisterView2>{
  final _keyForm = GlobalKey <FormState>();
  //RegisterWidget2State ()
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
           padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/backgroundbackground_registro.png',),fit: BoxFit.none, opacity: 1),
              gradient: LinearGradient(colors:[ Color.fromRGBO(53, 169, 253, 1),Color.fromRGBO(75, 244, 244, 0.8799999952316284)])
          ),
          
          width: double.infinity, height: double.infinity,
            //constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height,),
              child: Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height,),
                //width: double.infinity, height: double.infinity,
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
                            
                          icon: Icon(Icons.arrow_back, color: Colors.black,) ),
                        ),
                      ),
                      const SizedBox(width: 60,),
                      const Text('Creá tu cuenta', style: TextStyle(fontSize: 25.0),)
                     
                      ],
                    
                  
                    ),
                    const SizedBox(height: 12),
                    const Text('Si sos nuevo en HealthBand, registrate y comenzá a comenzá a controlar tu salud en simples pasos.', style: TextStyle(fontSize: 16.0),),
                    const SizedBox(height: 32),
                    ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Form(
                        key: _keyForm,
                        child: Column(
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
                        ),
                      ]
                    )
                           
                  ],
                    ),
              ),
            
          
    ),
  ),
);
  }
}