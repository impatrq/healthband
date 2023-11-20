import 'dart:io';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf_wdgts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase/supabase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pdf_historial.dart';
import 'location.dart';
import 'package:geolocator/geolocator.dart';
void main() {
  runApp(const ExFetch());
}

class ExFetch extends StatefulWidget {

  const ExFetch({super.key});

  @override
  State<ExFetch> createState() => _ExFetchState();
}

class _ExFetchState extends State<ExFetch> {
  int myIndex = 0;
  final PageController pageController = PageController();
  final pdf = pdf_wdgts.Document();
  final SupabaseClient supabaseClient = SupabaseClient('https://bhqahbhnapapcazmqnkg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4');
  final Uri phone_number = Uri.parse('tel: +54-9-11-2691-3745');
  get stream => supabaseClient.from('healthdatos_datos').stream(primaryKey: ['id']).order('time', ascending: false).limit(1);

  Future <Position> determinePosition() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation()async{
    Position position = await determinePosition();
    print(position.latitude);
    print(position.longitude);
  }

  Future<List<dynamic>> fetchData() async {
    final response = await supabaseClient
      .from('healthdatos_datos')
      .select('id, pulsos, oxigenacion, time, movimiento,temperatura')
      .order('time', ascending: false)
      .limit(1);
      return response ;
  }

  Future<List<dynamic>> fetchHistorialData() async {
    final response = await supabaseClient
      .from('healthdatos_datos')
      .select('id, pulsos, oxigenacion, time, movimiento, temperatura')
      .order('time', ascending: false)
      .limit(10);
      print (response);
      return response;
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:RefreshIndicator(
          onRefresh: () async{
            setState(() {
              fetchData();
            });
          },
            child: Stack(
              children: [
                ListView(
                  physics: const AlwaysScrollableScrollPhysics(),),
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: StreamBuilder(
                            stream: supabaseClient.from('healthdatos_datos').stream(primaryKey: ['id']).order('time', ascending: false).limit(1) ,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const SizedBox(
                                  width: 393, height: 713,
                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [CircularProgressIndicator()]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final dataList = snapshot.data as List<dynamic>?;
                                final data = dataList?[0];
                                MapEntry data2 = data.entries.firstWhere((entry) => entry.key == "pulsos");
                                MapEntry data3 = data.entries.firstWhere((entry) => entry.key == "oxigenacion");
                                MapEntry data4 = data.entries.firstWhere((entry) => entry.key == "temperatura");
                                MapEntry data5 = data.entries.firstWhere((entry) => entry.key == "movimiento");
                                final PageController pageController = PageController();
                                Color textColor2;
                                
                                if (data2.value < 40 || data2.value > 140) {
                                  textColor2 = const Color.fromARGB(255, 169, 26, 15);
                                } else if (data2.value >= 120 && data2.value <= 130) {
                                  textColor2 = const Color.fromARGB(255, 225, 167, 31);
                                } else if (data2.value >= 50 && data2.value <= 60) {
                                  textColor2 = const Color.fromARGB(255, 228, 107, 15);
                                } else {
                                  textColor2 = const Color.fromARGB(255, 45, 123, 47);
                                }
                                Color textColor3;
                                if(data3.value < 95 || data3.value > 100 ){
                                  textColor3 = const Color.fromARGB(255, 169, 26, 15);
                                }
                                else{
                                  textColor3 = const Color.fromARGB(255, 45, 123, 47);
                                }

                                Color textColor4;
                                if ((data4.value < 35 && data4.value > 34)|| (data4.value > 37.5 && data4.value < 38.5)){
                                  textColor4 = const Color.fromARGB(255, 228, 107, 15);
                                }
                                else if(data4.value < 34 || data4.value > 38.5){
                                  textColor4 = const Color.fromARGB(255, 169, 26, 15);
                                }
                                else{
                                  textColor4 = const Color.fromARGB(255, 45, 123, 47);
                                }
                                
                                if (data2.value < 40 && data5.value != 'No ha ocurrido nada'){
                                  launchDialer(phone_number as String);
                                  print('Llamando a Emergencias');
                                }

                                return SingleChildScrollView(
                                  child: RefreshIndicator(
                                    onRefresh: () async{
                                      setState(() {
                                        fetchData();
                                      });
                                      //fetchData();
                                    },
                                    child: Container(
                                      constraints: BoxConstraints(maxHeight: 713, maxWidth: 393),
                                      child: PageView(
                                            controller: pageController,
                                              children: [Center(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children:[ 
                                                      const SizedBox(height: 15,),
                                                        Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                const Text('Bienvenido a HealthBand', style: TextStyle(color: Color.fromARGB(255, 14, 52, 96), fontSize: 16.0, fontWeight: FontWeight.w500),),
                                                                const SizedBox(width: 10,),
                                                                MaterialButton(
                                                                  onPressed: () async{
                                                                    Future _createPDF() async{
                                                                    final document = pdf_wdgts.Document();
                                                                          document.addPage(
                                                                            pdf_wdgts.Page(
                                                                              build: (context) {
                                                                                return pdf_wdgts.Container(
                                                                                  child: pdf_wdgts.Center(child: 
                                                                                    pdf_wdgts.Stack(children: [
                                                                                    pdf_wdgts.Text('Ficha Médica'),
                                                                                    pdf_wdgts.SizedBox(height: 35),
                                                                                    pdf_wdgts.Column(
                                                                                    mainAxisAlignment:pdf_wdgts.MainAxisAlignment.spaceAround,
                                                                                    children: [
                                                                                      pdf_wdgts.Text("Ritmo cardíaco", style:const pdf_wdgts.TextStyle()),
                                                                                      pdf_wdgts.Text("Oxigenación en Sangre", style:const pdf_wdgts.TextStyle()),
                                                                                      pdf_wdgts.Text("Temperatura Corporal", style:const pdf_wdgts.TextStyle()),
                                                                                      pdf_wdgts.Text("Actividad", style:const pdf_wdgts.TextStyle()),
                                                                                    ]
                                                                                  ),
                                                                                    pdf_wdgts.Column(
                                                                                      mainAxisAlignment: pdf_wdgts.MainAxisAlignment.spaceAround,
                                                                                      children: [
                                                                                        pdf_wdgts.Text(data2.toString(), style:const pdf_wdgts.TextStyle()),
                                                                                        pdf_wdgts.Text(data3.toString(), style:const pdf_wdgts.TextStyle()),
                                                                                        pdf_wdgts.Text(data4.toString(), style:const pdf_wdgts.TextStyle()),
                                                                                        pdf_wdgts.Text(data5.toString(), style:const pdf_wdgts.TextStyle()),
                                                                                      ],
                                                                                    ),
                                                                                    pdf_wdgts.SizedBox(height: 35),
                                                                                     pdf_wdgts.Text('HealthBand Aid'),
                                                                                  ])
                                                                                  )
                                                                                  
                                                                                  
                                                                                );
                                                                              }, 
                                                                          )
                                                                        );
                                                                        return saveDocument(name: 'hb_ficha_medica.pdf', pdf: document);
                                                                        }
                                                                        final pdfFile = await _createPDF();
                                                                        openFile(pdfFile);
                                                                      },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                                                                    child: Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        //Image.asset('assets/images/info-bBM.png', width: 18.0, height: 18.0,),
                                                                        const SizedBox(width: 9,),
                                                                        TextButton(onPressed: () async{
                                                                          Future  _createPDF() async{
                                                                          final document = pdf_wdgts.Document();
                                                                          document.addPage(
                                                                            pdf_wdgts.Page(
                                                                              build: (context) {
                                                                                return pdf_wdgts.Container(
                                                                                  child: pdf_wdgts.Center(child: 
                                                                                    pdf_wdgts.Column(children: [
                                                                                    pdf_wdgts.Text('Ficha Médica - HealthBand Aid', style: const pdf_wdgts.TextStyle(fontSize: 15)),
                                                                                    pdf_wdgts.SizedBox(height: 50),
                                                                                    pdf_wdgts.Table(
                                                                                        border: pdf_wdgts.TableBorder.all(color: PdfColors.black, style: pdf_wdgts.BorderStyle.solid, width: 2),
                                                                                        children: [
                                                                                          pdf_wdgts.TableRow(children: [
                                                                                            pdf_wdgts.Column(children: [
                                                                                              pdf_wdgts.Text("Ritmo cardíaco", style:const pdf_wdgts.TextStyle(fontSize: 22)),
                                                                                              pdf_wdgts.SizedBox(height: 10 ),
                                                                                              pdf_wdgts.Text(data2.value.toString(), style:const pdf_wdgts.TextStyle(fontSize: 17)),
                                                                                              pdf_wdgts.SizedBox(height: 10 ),
                                                                                            ])
                                                                                          ]),
                                                                                          pdf_wdgts.TableRow(children: [
                                                                                            pdf_wdgts.Column(children: [
                                                                                              pdf_wdgts.Text("Oxigenación en Sangre", style:const pdf_wdgts.TextStyle(fontSize: 22)),
                                                                                              pdf_wdgts.SizedBox(height: 10 ),
                                                                                              pdf_wdgts.Text(data3.value.toString(), style:const pdf_wdgts.TextStyle(fontSize: 17)),
                                                                                              pdf_wdgts.SizedBox(height: 10 ),
                                                                                            ])
                                                                                          ]),
                                                                                          pdf_wdgts.TableRow(children: [
                                                                                            pdf_wdgts.Column(children: [
                                                                                              pdf_wdgts.Text("Temperatura Corporal", style:const pdf_wdgts.TextStyle(fontSize: 22)),
                                                                                              pdf_wdgts.SizedBox(height: 10 ),
                                                                                              pdf_wdgts.Text(data4.value.toString(), style:const pdf_wdgts.TextStyle(fontSize: 17)),
                                                                                              pdf_wdgts.SizedBox(height: 10 ),
                                                                                            ])
                                                                                          ]),
                                                                                          pdf_wdgts.TableRow(children: [
                                                                                            pdf_wdgts.Column(children: [
                                                                                              pdf_wdgts.Text("Movimiento", style:const pdf_wdgts.TextStyle(fontSize: 22)),
                                                                                              pdf_wdgts.SizedBox(height: 10 ),
                                                                                              pdf_wdgts.Text(data5.value.toString(), style:const pdf_wdgts.TextStyle(fontSize: 17)),
                                                                                              pdf_wdgts.SizedBox(height: 10 ),
                                                                                            ])
                                                                                          ]),
                                                                                        ]
                                                                                    
                                                                                  ),
                                                                                    pdf_wdgts.SizedBox(height: 35),
                                                                                    pdf_wdgts.Center(child: pdf_wdgts.Row(children: [
                                                                                      pdf_wdgts.Text(DateFormat.d().format(DateTime.now())),
                                                                                      pdf_wdgts.Text(' '),
                                                                                      pdf_wdgts.Text(DateFormat.MMM().format(DateTime.now())),
                                                                                      pdf_wdgts.Text(' '),
                                                                                      pdf_wdgts.Text(DateFormat.MMMMEEEEd().format(DateTime.now())),
                                                                                      pdf_wdgts.Text(' '),
                                                                                      pdf_wdgts.Text(DateFormat.jms().format(DateTime.now()))
                                                                                    ]),),
                                                                                    pdf_wdgts.SizedBox(height: 35),
                                                                                     //pdf_wdgts.Text('HealthBand Aid'),
                                                                                  ])
                                                                                  )
                                                                                  
                                                                                  
                                                                                );
                                                                              }
                                                                            )
                                                                          );
                                                                          return saveDocument(name: 'hb_ficha_medica.pdf', pdf: document);
                                                                        }
                                                                        final pdfFile = await _createPDF();
                                                                        openFile(pdfFile);
                                                                        },
                                                                        child: const Text('Descargar PDF', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 12.0),)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                //AssetImage('assets/images/info-bBM.png')
                                                      
                                                                ),
                                                              ],
                                                            ),
                                                            //const SizedBox(height: 3,),
                                                             Container(
                                                              decoration: const BoxDecoration(color: Color.fromARGB(255, 248, 248, 248)),
                                                              padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                                                               child: const Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                 children: [
                                                                  PDFHistorial()
                                                                 ]
                                                               ),
                                                             ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children:[ Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Center(
                                                                    child: Container(constraints: const BoxConstraints(maxWidth: 393),
                                                                      width: double.infinity,
                                                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Container(width: 158, height: 90, padding:const EdgeInsets.fromLTRB(8, 4, 8, 3),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(7)), 
                                                                              child: Column(
                                                                                children:[ 
                                                                                  const SizedBox(height: 10,),
                                                                                  const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Text('Ritmo Cardíaco', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color.fromARGB(255, 14, 52, 96)),),
                                                                                  ],
                                                                                ),
                                                                                  const SizedBox(height: 7,),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Text('${data2.value} BPM', style: TextStyle(fontWeight: FontWeight.w400, color:textColor2),)])])),
                                                                                    const SizedBox(width: 15,),
                                                                              Container(width: 158,height: 90, padding:const EdgeInsets.fromLTRB(8, 7, 4, 3),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(7)),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children:[ 
                                                                                  const SizedBox(height: 10,),
                                                                                const Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children:[
                                                                                  Text('Oxigenación en Sangre',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11, color: Color.fromARGB(255, 14, 52, 96)),),
                                                                                ]
                                                                                  
                                                                                ),
                                                                            const SizedBox(height: 7,),
                                                                            Text('${data3.value} %',style: TextStyle(fontWeight: FontWeight.w400, color: textColor3),)
                                                                            ]
                                                                            )
                                                                            ),
                                                                          ],
                                                                          ),
                                                                          const SizedBox(height: 20,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                            Container(width:158,height:90 ,padding:const EdgeInsets.fromLTRB(8, 7, 4, 3),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(7)),
                                                                            child: Column(
                                                                              children:[ 
                                                                                const SizedBox(height: 10,),
                                                                              const Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Text('Temperatura Corporal', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11, color: Color.fromARGB(255, 14, 52, 96)),),
                                                                                ],
                                                                              ),
                                                                                  
                                                                              const SizedBox(height: 10,),
                                                                                  
                                                                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                Text('${data4.value} °C',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color:textColor4),)
                                                                                ]
                                                                                )
                                                                                ]
                                                                                )
                                                                              ),
                                                                            
                                                                            const SizedBox(width: 15,),
                                                                                  
                                                                            Container(width: 158, height:90, padding:const EdgeInsets.fromLTRB(8, 7, 4, 3),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(7)),
                                                                            child: Column(children:[ 
                                                                              const SizedBox(height: 10,),
                                                                              const Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start ,
                                                                                children: [
                                                                                  Text('Actividad', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color.fromARGB(255, 14, 52, 96)),),
                                                                                ],
                                                                              ),
                                                                                  
                                                                              const SizedBox(height: 10,),
                                                                                  
                                                                              Row(children: [Text('${data5.value}',style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Color.fromARGB(255, 14, 52, 96)),)])])),
                                                                          ]
                                                                          ),
                                                                          ],
                                                                          ),
                                                                          ),
                                                                          ),
                                                                          ],
                                                                          ),
                                                                          ],
                                                                          ),
                                                
                                                                        
                                                                    const SizedBox(height: 50,),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children:[ Container(
                                                                        constraints: const BoxConstraints(maxWidth: 160, maxHeight: 60),
                                                                        padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                                                                        decoration: BoxDecoration(
                                                                              borderRadius : BorderRadius.circular(22),
                                                                              color : const Color.fromRGBO(218, 3, 3, 1),
                                                                              ),
                                                                        child: MaterialButton(
                                                                              onPressed: () async{
                                                                                print('Emergencias');
                                                                                print(await canLaunchUrl(phone_number));
                                                                               //launchDialer(phone_number as String);
                                                                               getCurrentLocation();
                                                                              },
                                                                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    decoration: const BoxDecoration(
                                                                                      borderRadius : BorderRadius.only(
                                                                                        topLeft: Radius.circular(12),
                                                                                        topRight: Radius.circular(12),
                                                                                        bottomLeft: Radius.circular(12),
                                                                                        bottomRight: Radius.circular(12),),
                                                                                      ),
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                                                    child: const Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: <Widget>[
                                                                                        Center(
                                                                                          child: Text('Emergencias', textAlign: TextAlign.center, style: TextStyle(
                                                                                          color: Color.fromRGBO(186, 186, 186, 1),
                                                                                          fontFamily: 'Commissioner',
                                                                                          fontSize: 12,
                                                                                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          height: 1
                                                                                          ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                        
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                                                  
                                                                                                                                                            ),
                                                    ]),
                                                                  
                                                                  
                                                                          ]
                                                                          
                                                                          ),
                                                
                                                                    ),
                                                                
                                                              ],
                                                            ),
                                    ),
                                  ),
                                );
                                
                              }}
                              ),
                )       
                                                ]                                  
                                                ),
          
          ),
        )
    );               
  }
  Future <File> saveDocument({
    required String name,
    required pdf_wdgts.Document pdf,
  }) async {
    final data = await fetchData();
    if (data.isNotEmpty){
      print("PDF Generado");
      final bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory();
       File file = File('${dir.path}/$name');
       await file.writeAsBytes(bytes);
      return file;
    }
    else{
      print("No se genero el PDF");
      return 'No se generó el PDF' as Future<File>;
    }
  }

  Future openFile(File file) async{
    final url = file.path;
    await OpenFile.open(url);
  }

Future <Uint8List> _readImageData(String name) async{
  final data = await rootBundle.load('assets/lib/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

launchDialer(String number) async {
  String url = 'tel:' + number;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Application unable to open dialer.';
  }
}

void _launchPhone(String phoneNumber) async {
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      print('No se pudo realizar la llamada.');
    }
  }

  String formatoHora(DateTime dateTime) {
    return DateFormat('HH').format(dateTime);
  }

  String formatoMinutos(DateTime dateTime) {
    return DateFormat('mm').format(dateTime);
  }

  String formatoFechaHora(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}

  String formatoDia(DateTime dateTime) {
    return DateFormat('dd').format(dateTime);
  }

  String formatoFechaCompleta(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

  String formatoMes(DateTime dateTime) {
    return DateFormat('MM').format(dateTime);
  }

  String formatoAnio(DateTime dateTime) {
    return DateFormat('yyyy').format(dateTime);
  }
  
  toList() {}
}
