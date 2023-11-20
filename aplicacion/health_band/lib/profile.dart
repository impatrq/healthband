import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:health_band/pdf_generators/home_pdf_generator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'utils.dart';
import 'package:image_picker/image_picker.dart';
import 'registro1.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyProfile extends StatefulWidget {
  static String id = 'home_page';
  const MyProfile({super.key});
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final SupabaseClient supabaseClient = SupabaseClient('https://bhqahbhnapapcazmqnkg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4');
  int myIndex = 0;
  //final String? name;
  //final String? email;
  //final String? gender;
  //final String? number;
  //_MyProfileState({this.name, this.email, this.gender, this.number});

  Future<List<dynamic>> fetchData() async {
    // Fetch data from Supabase table
    final response = await supabaseClient
      .from('healthdatos_usuarios')
      .select('id, nombre, telefono, email, genero')
      .order('id')
      .limit(1);
      // Parse JSON data
      return response ;
  }

  Uint8List ? _image;
  void selectImage() async {
    Uint8List img = await pickImage (ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        flexibleSpace: Container(
          width: 393.0,
          padding: const EdgeInsets.fromLTRB(60.0, 50.0, 60.0, 10.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 14, 52, 96),
          ),
          child: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/logo_hb_en_.png', width: double.infinity, height: double.infinity,),
        ),
      ),*/
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 393,
            height: 852,
             padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
             child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot){
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                else if (snapshot.data == null){
                  return Text('null');
                }
                else{
                  final dataList = snapshot.data as List <dynamic>?;
                  if (dataList!.isEmpty){
                    return Text('lista de datos vacía');
                  }
                  final data = dataList?[0];
                  MapEntry data2 = data.entries.firstWhere((entry) => entry.key == 'nombre');
                  MapEntry data3 = data.entries.firstWhere((entry) => entry.key == 'telefono');
                  MapEntry data4 = data.entries.firstWhere((entry) => entry.key == 'email');
                  MapEntry data5 = data.entries.firstWhere((entry) => entry.key == 'genero');
                  final PageController pageController = PageController();
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Stack(
                                children: [
                                  _image != null ? CircleAvatar(
                                    radius: 65,
                                    backgroundImage: MemoryImage(_image!),
                                  ) :
                                  const CircleAvatar(
                                  radius: 65,
                                  //backgroundImage: NetworkImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/1144760.png'),
                                ),
                                  Positioned(child:IconButton(onPressed: selectImage , icon: Icon(Icons.add_a_photo),), bottom: -10, left: 80,),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Text('${data2.value}', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.amber),),
                              const SizedBox(height: 35,),
                              Column(
                                children: [
                                  Text('Información Personal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.amber),),
                                  SizedBox(height: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Correo Electrónico: ${data4.value}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                      SizedBox(height: 10,),
                                      Text('Fecha de Nacimiento:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                      SizedBox(height: 10,),
                                      Text('Sexo: ${data5.value} ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                      SizedBox(height: 10,),
                                      Text('Edad:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                      SizedBox(height: 10,),
                                      Text('Nacionalidad: ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                      SizedBox(height: 10,),
                                      Text('Número de Teléfono: ${data3.value} ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                    ],
                                  ),
                                  SizedBox(height: 30,),
                                  Column( crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Ficha Médica', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.amber),),
                                        SizedBox(height: 20,),
                                        Text('Diabetes:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                        SizedBox(height: 10,),
                                        Text('Grupo Sanguíneo:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                        SizedBox(height: 10,),
                                        Text('Peso:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                        SizedBox(height: 10,),
                                        Text('Tratamientos:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                        SizedBox(height: 10,),
                                        Text('Patologías Cardiorrespiratorias:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                        SizedBox(height: 10,),
                                        Text('Altura:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                        SizedBox(height: 10,),
                                        Text('Actividad Física Frecuente:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                        SizedBox(height: 10,),
                                    ],
                                  ),
                                  ]
                                )
                            ],
                            
                          )
                        ],
                      )
                    ],
                  );
                }
              },
               
             ),
          ),
        ),
      ),
    );
  }
}