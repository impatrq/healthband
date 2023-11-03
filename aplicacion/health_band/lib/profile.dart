import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:health_band/pdf_generators/home_pdf_generator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'utils.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  static String id = 'home_page';
  const MyProfile({super.key});
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int myIndex = 0;

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 393,
            height: 852,
             padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
             child: Column(
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
                             CircleAvatar(
                            radius: 65,
                            backgroundImage: NetworkImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/1144760.png'),
                          ),
                             Positioned(child:IconButton(onPressed: selectImage , icon: Icon(Icons.add_a_photo),), bottom: -10, left: 80,),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Text('Usuario', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.amber),),
                        SizedBox(height: 35,),
                        Column(
                          children: [
                            Text('Información Personal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.amber),),
                            SizedBox(height: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Correo Electrónico:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                SizedBox(height: 10,),
                                Text('Fecha de Nacimiento:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                SizedBox(height: 10,),
                                Text('Sexo:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                SizedBox(height: 10,),
                                Text('Edad:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                SizedBox(height: 10,),
                                Text('Nacionalidad:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
                                SizedBox(height: 10,),
                                Text('Número de Teléfono:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.amber)),
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
             ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(onTap:(index) {
        setState((){
          myIndex = index;
        });
      } ,
      currentIndex: myIndex,  
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Alarm")
      ],),
    );
  }
}