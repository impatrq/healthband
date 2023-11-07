import 'package:flutter/material.dart';
import 'dart:convert'; // for JSON decoding
import 'package:supabase/supabase.dart'; // import Supabase library

void main() {
  runApp(ExFetch());
}

class ExFetch extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Supabase Data'),
        ),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final dataList = snapshot.data;
              final data = dataList?[0];
              MapEntry data2 = data.entries.firstWhere((entry) => entry.key == "pulsos");
              MapEntry data3 = data.entries.firstWhere((entry) => entry.key == "oxigenacion");
              MapEntry data4 = data.entries.firstWhere((entry) => entry.key == "temperatura");
              MapEntry data5 = data.entries.firstWhere((entry) => entry.key == "movimiento");
              //String pulsos = jsonData?['pulsos'];
              return Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Row(children: [
                      Container(padding:EdgeInsets.symmetric(horizontal: 5, vertical: 5),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(7)), 
                      child: Column(
                        children:[ Row(
                          children: [
                            Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 5,height: 5,),
                            Text('Ritmo Cardíaco', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 7, color: Colors.blue),),
                            IconButton(onPressed: () => {}, icon:Icon(Icons.arrow_forward_ios, size:5,) )
                          ],
                        ),
                          SizedBox(height: 3,),
                          Row(
                          children: [Text('${data2.value}', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.blue),)])])),
                      SizedBox(width: 15,),
                      Container(padding:EdgeInsets.symmetric(horizontal: 5, vertical: 5),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(7)),child: Text('Oxígeno en Sangre: ${data3.value}',style: TextStyle(fontWeight: FontWeight.w400, color: Colors.blue), )),
                      ],
                      ),
                      SizedBox(height: 15,),
                      Row(children:[
                        Container(padding:EdgeInsets.symmetric(horizontal: 5, vertical: 5),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(7)),
                        child: Column(children:[ 
                          Row(),
                              
                          SizedBox(height: 15,),
                              
                          Row(children: [Text('Temperatura: ${data4.value}',style: TextStyle(fontWeight: FontWeight.w400, color: Colors.blue),)])])
                          ),
                        
                        SizedBox(width: 15,),
                              
                        Container(padding:EdgeInsets.symmetric(horizontal: 5, vertical: 5),decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(7)),
                        child: Column(children:[ 
                          Row(),
                              
                          SizedBox(height: 15,),
                              
                          Row(children: [Text('movimiento: ${data5.value}',style: TextStyle(fontWeight: FontWeight.w400, color: Colors.blue),)])])),
                      ]
                      )
                      ]),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
