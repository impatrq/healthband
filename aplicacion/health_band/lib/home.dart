import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:health_band/pdf_generators/home_pdf_generator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
///import 'package:health_band/graphics/linear_charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://healthband.com.ar/datos'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}*/

class Album {
  final int pulse;
  final int o2;
  final int temp;
  final String move;

  Album({
    required this.pulse,
    required this.o2,
    required this.temp,
    required this.move,
  });

  /*factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      pulse: json['PULSOS'] as int,
      o2: json['OXIGENO'] as int,
      temp: json['TEMPERATURA'] as int,
      move: json['MOVIMIENTO']as String
    );
  }*/
}

void main() => runApp(const HomeView());

class HomeView extends StatefulWidget {
  static String id = 'home_page';
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //late Future<Album> futureAlbum;
  int myIndex = 0;
  Album ? datos;
  @override
  void initState() {
    super.initState();
    _obtenerDatos();
    //futureAlbum = fetchAlbum();
  }

  Future<void> _obtenerDatos() async {
    final url = 'https://healthband.vercel.app/datos/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> datosJson = jsonDecode(response.body);
      setState(() {
          datos = Album(
          pulse: datosJson['pulsos'],
          o2: datosJson['oxigenacion'],
          temp: datosJson['temperatura'],
          move: datosJson['movimiento'],
        );
      });
    } else {
      print('Error al obtener los datos del servidor: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
      body: datos != null ?
      SingleChildScrollView(
        child: Center(
          child: Container(
            width: 393.0,
            height: 852.0,
            padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
            child: Column(
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Bienvenido, Nombre', style: TextStyle(color: Color.fromARGB(255, 14, 52, 96), fontSize: 19.0),),
                  const SizedBox(width: 20,),
                  MaterialButton(
                    onPressed: _createPDF, 
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/info-bBM.png', width: 18.0, height: 18.0,),
                          const SizedBox(width: 8,),
                          const Text('Descargar PDF', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 10.0),),
                        ],
                      ),
                    ),
                  //AssetImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/info-bBM.png')
        
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 15.0, height: 15.0,),
                          const SizedBox(width: 10,),
                          const Text('Ritmo Cardíaco', style: TextStyle(color: Color.fromARGB(255, 14, 52, 96), fontSize: 10)),
                          const SizedBox(width: 8,),
                          IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5,),
                          Text('${datos?.pulse}', style: TextStyle(color: Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
                        ],
                      ),
                      const SizedBox(height: 8,)
                      ],
                      //decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2.0)),
                      
                      
                    ),
                  ),
                  const SizedBox(
                  width: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0.0, 0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 15.0, height: 15.0,),
                          const SizedBox(width: 5,),
                          const Text('Oxigeno en Sangre', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 10)),
                          IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5,),
                          Text('${datos?.o2}', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
                        ],
                      ),
                      const SizedBox(height: 8,)
                      ], 
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 0.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 15.0, height: 15.0,),
                          const SizedBox(width: 8,),
                          ConstrainedBox(constraints:const BoxConstraints(maxWidth:70), child: const Text('Temperatura Corporal', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 10))),
                          const SizedBox(width: 12.0,),
                          IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5,),
                          Text('${datos?.temp}', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0)),
                        ],
                      ),
                      const SizedBox(height: 8,)
                      ],
                      //decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2.0)), 
                    ),
                  ),
                  const SizedBox(
                  width: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0.0, 0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
                    child: Column(
                     children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 15, height: 15,),
                          const SizedBox(width: 8),
                          const Text('Actividad', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 11),),
                          const SizedBox(width: 40,),
                          IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${datos?.move}', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
                        ],
                      ),
                      const SizedBox(height: 8,)
                      ], 
                    ),
                  ),
                ],
              ),
             
              const SizedBox(height: 30,),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                        borderRadius : BorderRadius.circular(16),
                        color : const Color.fromRGBO(218, 3, 3, 1),
                        ),
                  child: MaterialButton(
                        onPressed: () {
                          FlutterPhoneDirectCaller.callNumber('+5491126913745');
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius : BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),),
                                ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      image : DecorationImage(
                                      image: AssetImage('assets/images/Info.png'),
                                      fit: BoxFit.fitWidth
                                      ),
                                    )
                                  ),
                                  const SizedBox(width : 8),
                                  const Center(
                                    child: Text('Emergencias', textAlign: TextAlign.center, style: TextStyle(
                                    color: Color.fromRGBO(186, 186, 186, 1),
                                    fontFamily: 'Commissioner',
                                    fontSize: 11,
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
              ),

              //BotondeemergenciasWidget()
            ],)
          ),
          
        ),
      ) : Center(child: CircularProgressIndicator()),
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

Future <void> _createPDF() async{
  PdfDocument document = PdfDocument();
  document.pages.add();
  final page = document.pages.add();

  page.graphics.drawString('HealthBand', PdfStandardFont(PdfFontFamily.helvetica, 10));

  PdfGrid grid = PdfGrid();
  grid.columns.add(count: 4);
  grid.headers.add(1);
  grid.style = PdfGridStyle(
    font: PdfStandardFont(PdfFontFamily.timesRoman, 25),
    cellPadding: PdfPaddings(bottom: 2, top: 2, right: 2, left: 5));

  PdfGridRow header = grid.headers[0];
  header.cells[0].value='Pulsaciones';
  header.cells[1].value='Oxigenacion';
  header.cells[2].value='Movimiento';
  header.cells[3].value='Temperatura';

  PdfGridRow row = grid.rows.add();
  row.cells[0].value= '65';
  row.cells[1].value= '65';
  row.cells[2].value= '65';
  row.cells[3].value= '65';

  row = grid.rows.add();
  row.cells[0].value= '65';
  row.cells[1].value= '65';
  row.cells[2].value= '65';
  row.cells[3].value= '65';

  row = grid.rows.add();
  row.cells[0].value= '65';
  row.cells[1].value= '65';
  row.cells[2].value= '65';
  row.cells[3].value= '65';

  grid.draw(bounds: const Rect.fromLTWH(0, 0, 0, 0));

  List <int> bytes = await document.save();
  document.dispose();
  saveAndLaunchFile(bytes, 'Healthband.pdf');

} 

Future <Uint8List> _readImageData(String name) async{
  final data = await rootBundle.load('assets/lib/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}


        
        
/*class BotondeemergenciasWidget extends StatefulWidget {
  @override
  _BotondeemergenciasWidgetState createState() => _BotondeemergenciasWidgetState();}
        
   class _BotondeemergenciasWidgetState extends State<BotondeemergenciasWidget> {
   @override
   Widget build(BuildContext context) {
        // Figma Flutter Generator BotondeemergenciasWidget - FRAME - VERTICAL
        
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 127, vertical: 58),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color : Color.fromRGBO(255, 255, 255, 1),),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
        
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                  borderRadius : BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16),),
                  color : Color.fromRGBO(218, 3, 3, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
              
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),),
                          color : Color.fromRGBO(255, 255, 255, 1),
                          ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                image : DecorationImage(
                                image: AssetImage('assets/images/Info.png'),
                                fit: BoxFit.fitWidth
                                ),
                              )
                            ),
                            SizedBox(width : 8),
                            Text('Emergencias', textAlign: TextAlign.center, style: TextStyle(
                            color: Color.fromRGBO(186, 186, 186, 1),
                            fontFamily: 'Commissioner',
                            fontSize: 11,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1
                            ),
                            ),

                          ],
                        ),
                      ),

                          ],
                        ),
                      ),

                          ],
                        ),
                      ),
                  ],
                        ),
                      );
                          }
                          }*/
                          