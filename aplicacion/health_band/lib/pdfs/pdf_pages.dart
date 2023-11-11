import 'package:health_band/pdfs/pdf_class.dart';
import 'package:flutter/material.dart';
import 'package:health_band/example_fetching.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


/*void main() {
  runApp(MyApp());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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
    return Scaffold(

      body: FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final dataList = snapshot.data;
                    final data = dataList?[0];
                    MapEntry data2 = data.entries.firstWhere((entry) => entry.key == "pulsos");
                    MapEntry data3 = data.entries.firstWhere((entry) => entry.key == "oxigenacion");
                    MapEntry data4 = data.entries.firstWhere((entry) => entry.key == "temperatura");
                    MapEntry data5 = data.entries.firstWhere((entry) => entry.key == "movimiento");
                    final ficha = Pdf(pulsos: data2 as double, o2: data3 as double, temp: data4 as int, mov: data5 as String?);
                    return ListView(
                      children: [
                        
                      ],
                    );
                    }
                    
                }
      )
      

    );
  }
}
@override
Widget build(BuildContext context){
  return Scaffold
}*/
