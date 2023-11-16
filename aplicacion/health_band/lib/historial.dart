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
    // Fetch data from Supabase table
    final response = await supabaseClient
      .from('healthdatos_datos')
      .select('id, pulsos, oxigenacion, time, movimiento,temperatura')
      .order('time', ascending: false)
      .limit(1);
      // Parse JSON data
      return response ;
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

            return ListView.builder(
              itemCount: listaDatos.length,
              itemBuilder: (context, index) {
                final DateTime tiempo = DateTime.parse(listaDatos[index]['time']);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Hora')),
                        DataColumn(label: Text('Minutos')),
                        DataColumn(label: Text('Día')),
                        DataColumn(label: Text('Mes')),
                        DataColumn(label: Text('Año')), 
                      ],
                      rows: listaDatos.map((dato) {
                        final DateTime tiempo = DateTime.parse(dato['time']);

                        return DataRow(cells: [
                          DataCell(Text(formatoHora(tiempo))),
                          DataCell(Text(formatoMinutos(tiempo))),
                          DataCell(Text(formatoDia(tiempo))),
                          DataCell(Text(formatoMes(tiempo))),
                          DataCell(Text(formatoAnio(tiempo))),
                        ]);
                      }).toList(),
                    ),
                    /*Text('Hora: ${formatoHora(tiempo)}'),
                    Text('Minutos: ${formatoMinutos(tiempo)}'),
                    Text('Día: ${formatoDia(tiempo)}'),
                    Text('Mes: ${formatoMes(tiempo)}'),
                    Text('Año: ${formatoAnio(tiempo)}'),*/
                    const SizedBox(height: 16),
                  ],
                );
              },
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

  String formatoDia(DateTime dateTime) {
    return DateFormat('dd').format(dateTime);
  }

  String formatoMes(DateTime dateTime) {
    return DateFormat('MM').format(dateTime);
  }

  String formatoAnio(DateTime dateTime) {
    return DateFormat('yyyy').format(dateTime);
  }
}
