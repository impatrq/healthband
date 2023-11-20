
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

/*class PdfApi{
  final SupabaseClient supabaseClient = SupabaseClient('https://bhqahbhnapapcazmqnkg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4');

  Future<List<dynamic>> fetchData() async {
    // Fetch data from Supabase table
    final response = await supabaseClient
      .from('healthdatos_datos')
      .select('id, pulsos, oxigenacion, time, movimiento,temperatura')
      .order('time', ascending: false)
      .limit(1);
      // Parse JSON data
      return response ;
  }

   Future <File> generateCenteredText(String text) async{
    Document pdf = Document();

    pdf.addPage(
       Page(
        build:(context) => FutureBuilder(future: fetchData(), builder: (context, snapshot){
          if(snapshot.hasData){
             final dataList = snapshot.data;
                    final data = dataList?[0];
                    MapEntry data2 = data.entries.firstWhere((entry) => entry.key == "pulsos");
                    MapEntry data3 = data.entries.firstWhere((entry) => entry.key == "oxigenacion");
                    MapEntry data4 = data.entries.firstWhere((entry) => entry.key == "temperatura");
                    MapEntry data5 = data.entries.firstWhere((entry) => entry.key == "movimiento");
                    return PageView(
                      children: [
                        Container(
                          width: double.infinity, height: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                           child: Column(
                              children: [
                                Row( 
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text(
                                  'Ritmo Cardíaco' 
                                  ),
                                  SizedBox(width: 15),
                                  Text(),
                                  ]
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text
                                  ('Oxigenación en Sangre'),
                                  SizedBox(width: 15),
                                  Text(''),
                                  ]
                                ),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Temperatura Corporal'),
                                  SizedBox(width: 15),
                                  Text(''),
                                  ]
                                ),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Movimiento'),
                                  SizedBox(width: 15),
                                  Text(''),
                                  ]
                                ),
                              ]
                           )
                        );
                        
            );
                    );
                    
          }
        }
       
        )
       )
        //Center(child: Text(text, style: const TextStyle(fontSize: 48)),
        );
    return saveDocument(name: 'hb_ficha.pdf', pdf: pdf);
  }

  Future <File> saveDocument({
    required String name,
    required Document pdf,
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
    }
    
    
   
  
  */
