import 'package:flutter/material.dart';
import 'package:health_band/enums.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:health_band/home.dart';
import 'package:health_band//Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/registro2.dart';
//import 'package:email_validator/email_validator.dart';
//import 'package:health_band/form_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//import 'package:flutter_laravel_form_validation/flutter_laravel_form_validation.dart';
import'package:supabase/supabase.dart';
import 'package:phonenumbers/phonenumbers.dart';
import 'blank.dart';

class SupabaseManager {

  /*Future<void> signUpUser(context, {String? email, String? password, String? number, String? gender }) async {
    debugPrint("email:$email password:$password");
    final result = await client.auth.signUp(email:email.toString(), password: password.toString(), phone: number.toString());

    debugPrint(result.data!.toJson().toString());

    if (result.data != null) {
      showToastMessage('Registration Success', isError: false);
      Navigator.pushReplacementNamed(context, 'login');
      showToastMessage('Success', isError: false);
    } else if (result.error?.message != null) {
      showToastMessage('Error:${result.error!.message.toString()}',
          isError: true);
    }
  }*/
}

class RegisterWidget1 extends StatefulWidget {
  static String id = 'register_page';
  TextEditingController ctrlNumber = TextEditingController();

  RegisterWidget1({super.key});
  @override
 RegisterWidget1State createState() =>  RegisterWidget1State();
}

class  RegisterWidget1State extends State <RegisterWidget1> {
  final client = SupabaseClient('https://bhqahbhnapapcazmqnkg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4');
  //final TextEditingController ctrlNumber = TextEditingController();
  final phoneNumberController = PhoneNumberEditingController();
  final TextEditingController ctrlMail = TextEditingController();
  final TextEditingController ctrlName = TextEditingController();
  GlobalKey <FormState> keyForm = GlobalKey <FormState>();
  final _keyForm = GlobalKey<FormState>();
  String ? selectedOption;
  //bool _isValid = false;
  String? name = "";
  String? email = "";
  String? phone = "";
  String? gender = "";
  final String _pswrd = "";

bool isValidated = false;

  String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}
String? validateUsername(String? value){
  if (value!.length < 5 || value.isEmpty) {
  return "Ingrese un nombre válido";  
}
return null;
}

/*String?  validateMobile(String? value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  if ( value!.isEmpty|| value.length < 10) {
      return 'Please enter mobile number';
  } else if (regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
  }
  else return '';
} */

/*Future <GotrueSessionResponse> createNewUser(
  String email, String password) async {
    final res = SupabaseClient('https://bhqahbhnapapcazmqnkg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4').auth.signUp(email: email, password:password);
    return res;
  }
}*/


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://bhqahbhnapapcazmqnkg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(RegisterWidget1());
}

Future <void> addRow({String? name, String? gender, String? phone, String? pswrd, String? email})async{
  final table = client.from('healthdatos_usuarios');
  await table.insert({
    'email': email,
    'telefono': phone,
    'nombre':name,
    'contraseña': pswrd,
    'genero':gender,
  }).execute();

}

@override
  void dispose() {
    phoneNumberController.dispose(); // to save environment
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          //constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/backgroundbackground_registro.png',),fit: BoxFit.none, opacity: 1),
              gradient: LinearGradient(colors:[ Color.fromRGBO(53, 169, 253, 1),Color.fromRGBO(75, 244, 244, 0.8799999952316284)])
          ),
            child: Wrap(
              children:[ 
                Column(
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
                    
                    ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Form(
                        key: _keyForm,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          //shrinkWrap: true,
                        children:[
                          const SizedBox(height: 4,),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: TextFormField( validator: validateEmail, onSaved: (value){email = value;}, controller: ctrlMail,
                              decoration: InputDecoration(hintText: 'ej: enzocarp912@gmail.com', hintStyle:TextStyle(color: Color.fromARGB(255, 172, 172, 172))),),
                          ),
                            const SizedBox(height: 36,),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Example(),
                              ),
                              SizedBox(height: 36,),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),
                                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: TextFormField(controller: ctrlName,validator:validateUsername, onSaved: (value){name = value;}, decoration: InputDecoration(hintText: 'Ej: Enzo Salomón Rondón', hintStyle:TextStyle(color: Color.fromARGB(255, 172, 172, 172))),)),
                            const SizedBox(height: 36,),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),
                              child: SingleChildScrollView(
                                child: DropdownButtonFormField(decoration:InputDecoration(hintText: 'Elija su género', hintStyle:TextStyle(color: Color.fromARGB(255, 172, 172, 172))), items: [
                                  DropdownMenuItem(value: 'Opción 1', child: Text('Femenino'),),
                                  DropdownMenuItem(value: 'Opción 2', child: Text('Masculino'),)
                                ], onChanged: (value){
                                  setState(() {
                                    selectedOption = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Por favor, elige una opción';
                                  }
                                  return null;},
                                onSaved: (value){gender = value;},
                                ),
                              ),
                            ),
                            
                            SizedBox(height: 36),
                            Container(
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.white),
                                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: PhoneNumberField( controller:phoneNumberController,
                                decoration: InputDecoration(hintText: 'Ingrese su numero de telefono', hintStyle:TextStyle(color: Color.fromARGB(255, 172, 172, 172))),),
                              ),
                            const SizedBox(height: 36,),
                            buttonSubmit_1(),
                          ]
                           
                        )
                        ),
                      ]
                    )
                           
                  ],
                    ),
              
              ]
            ),
          
    ),
    )
  );
  }

    Widget buttonSubmit_1(){
      return MaterialButton(
        onPressed: () {
          if(_keyForm.currentState!.validate()){ 
            try{
              addRow(name:ctrlName.text, gender: selectedOption, email: ctrlMail.text, pswrd: _pswrd, phone: phoneNumberController.value.toString());
              print('Operacion Exitosa');
          }
          catch(e){
            print('error: $e');
          }
            
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => const Blank()));
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Revise su formulario y complete todos sus campos correctamente')));
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