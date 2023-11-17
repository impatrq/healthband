import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  State<Historial> createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {

  Future<List<dynamic>> fetchData() async {
    final SupabaseClient supabaseClient = SupabaseClient('https://bhqahbhnapapcazmqnkg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4');
    //final DateTime today = DateTime(2023, 11, 13); // Fecha actual (13 de noviembre de 2023)
    //final DateTime startOfDay = DateTime(today.year, today.month, today.day, 0, 0, 0);
    //final DateTime endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    // Fetch data from Supabase table
    final response = await supabaseClient
      .from('healthdatos_datos')
      .select('id, pulsos, oxigenacion, time, movimiento,temperatura')
      .order('time', ascending: false)
    //.filter('time', 'gte', startOfDay.toIso8601String())
      //.filter('time', 'lte', endOfDay.toIso8601String())
      .limit(10);
      return response;
      // Parse JSON data
      //final List<dynamic> responseData = response.data as List<dynamic>;
      //List<Map<String, dynamic>> allData = [];
        // ignore: unnecessary_null_comparison
        /*if (responseData != null) {
          allData = responseData.map((dynamic item) {
            if (item is Map<String, dynamic>) {
              return item;
            }
            return {};
          } as List<Map<String, dynamic>>).toList();
  }*/

  // Filtrar los resultados por rango de fechas en el lado del cliente
      /*List<Map<String, dynamic>> filteredData = allData
          .where((dato) {
            DateTime time = DateTime.parse(dato['time']);
            return time.isAfter(startOfDay) && time.isBefore(endOfDay);
          })
          .toList();
      return filteredData ;*/
  }
  Future<List<dynamic>> get datos => fetchData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mostrar Tiempo'),
      ),
      body: FutureBuilder(
        future: datos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<dynamic> listaDatos = snapshot.data as List<dynamic>;
            final data = listaDatos[0];
             MapEntry data2 = data.entries.firstWhere((entry) => entry.key == "pulsos");
             MapEntry data3 = data.entries.firstWhere((entry) => entry.key == "oxigenacion");
             MapEntry data4 = data.entries.firstWhere((entry) => entry.key == "temperatura");
             MapEntry data5 = data.entries.firstWhere((entry) => entry.key == "movimiento");
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                 columns: const [
                        DataColumn(label: Text('Hora')),
                        DataColumn(label: Text('Día')),
                        DataColumn(label: Text('Ritmo Cardíaco')),
                        DataColumn(label: Text('Oxigenación')),
                        DataColumn(label: Text('Temperatura')),
                        DataColumn(label: Text('Movimiento')), 
                      ],
                      rows: List<DataRow>.generate(
                            listaDatos.length,
                            (index) {
                        final DateTime tiempo = DateTime.parse(listaDatos[index]['time']);

                        return DataRow(cells: [
                          DataCell(Text(formatoFechaHora(tiempo)),),
                          DataCell(Text(formatoFechaCompleta(tiempo))),
                          DataCell(Text('${data2.value} BPM')),
                          DataCell(Text('${data3.value} %')),
                          DataCell(Text('${data4.value} C')),
                          DataCell(Text('${data5.value}')),
                        ]);
                      }).toList(),
                    ),
            );
                   
          }
        },
      ),
    );
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
}
