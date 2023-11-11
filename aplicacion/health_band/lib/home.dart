import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:health_band/pdf_generators/home_pdf_generator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
///import 'package:health_band/graphics/linear_charts.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:health_band/utils.dart';
import 'package:provider/provider.dart';
import 'package:health_band/model/cat_model.dart';

Future<void> obtainData() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bhqahbhnapapcazmqnkg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4'
  );
}
final supabase = Supabase.instance.client;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bhqahbhnapapcazmqnkg.supabase.co',
    anonKey:  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4'
  );
runApp(const HomeView());
}

class DbService {
  SupabaseClient client = Supabase.instance.client;
  DbService(this.client);
}


class HomeView extends StatefulWidget {
  static String id = 'home_page';
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //late Future<Album> futureAlbum;
  int myIndex = 0;
  /*Album ? datos;
  @override
  void initState() {
    super.initState();
    getData();
    //futureAlbum = fetchAlbum();
  }*/

  /*Future<List<Category>> getData()  async{
    final response = await supabase.from('healthdatos_datos').select('pulsos, oxigenacion, time, movimiento,temperatura').order('time', ascending: false).limit(1);
    if (response.error != null){
      print('error en la consulta: ${response.error.message} ');
      return response.error.message;
    }
    final data = response.data;
    if (data.isNotEmpty ){
    final pulsos = data['pulsos'];
    final o2 = data['oxigenacion'];
    final temp = data['temperatura'];
    final move = data['movimiento'];
    print (pulsos);
    print (o2);
    print (temp);
    print(move);
  }
  else if (data.isEmpty || data == null){
    print("no hay datos");
    return response.error.message;
  }
  return data;
  }*/

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
      body:
      FutureBuilder<List<Cat>>(
        future: context.read<AppService>().getData(null),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index){
                final category = snapshot.data![index];
                return SingleChildScrollView(
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
                            Text(category.pulsos.toString(), style: TextStyle(color: Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
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
                            Text(category.o2.toString(), style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
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
                            Text(category.temp.toString(), style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0)),
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
                            Text(category.mov.toString(), style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
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
              ],
              )
            ),
            
          ),
        );
              });
          } else{
            return Center(child: CircularProgressIndicator());
          }
        },
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
                          