import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFHistorial extends StatefulWidget {
  const PDFHistorial({super.key});

  @override
  State<PDFHistorial> createState() => _PDFHistorialState();
}

class _PDFHistorialState extends State<PDFHistorial> {
  Future<List<dynamic>> fetchData() async {
   final SupabaseClient supabaseClient = SupabaseClient('https://bhqahbhnapapcazmqnkg.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJocWFoYmhuYXBhcGNhem1xbmtnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgwOTE0NjYsImV4cCI6MjAxMzY2NzQ2Nn0.o8plzbWgGL7cB7hRoypxtI3sXmjZq6t3hceXksV67U4');
    final response = await supabaseClient
      .from('healthdatos_datos')
      .select('id, pulsos, oxigenacion, time, movimiento,temperatura')
      .order('time', ascending: false);
      return response;
  }

  Future<List<dynamic>> get datos => fetchData();

  Future<pw.Document> generatePdfDocument(List<dynamic> listaDatos) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (context) {
        return pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Text('Hora'),
                pw.Text('Día'),
                pw.Text('Ritmo Cardíaco'),
                pw.Text('Oxigenación'),
                pw.Text('Temperatura'),
                pw.Text('Movimiento'),
              ],
            ),
            for (final dato in listaDatos)
              pw.TableRow(
                children: [
                  pw.Text(formatoFechaHora(DateTime.parse(dato['time']))),
                  pw.Text(formatoFechaCompleta(DateTime.parse(dato['time']))),
                  pw.Text('${dato['pulsos']} BPM'),
                  pw.Text('${dato['oxigenacion']} %'),
                  pw.Text('${dato['temperatura']} C'),
                  pw.Text('${dato['movimiento']}'),
                ],
              ),
          ],
        );
      },
    ));

    return pdf;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: datos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<dynamic> listaDatos = snapshot.data as List<dynamic>;
            return Center(
              child: TextButton(
                onPressed: () async {
                  final pdf = await generatePdfDocument(listaDatos);
                  // Guardar o mostrar el PDF según tus necesidades
                  // Ejemplo: Guardar en el directorio temporal y abrir con una aplicación PDF
                  final file = File('${(await getTemporaryDirectory()).path}/historial_hb.pdf');
                  await file.writeAsBytes(await pdf.save());
                  OpenFile.open(file.path);
                },
                child: Text('Informe Completo', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 11)),
              ),
            );
          }
        },
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
  // Métodos de formato de fecha y hora omitidos para mayor claridad
}
