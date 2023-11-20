import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';
import 'package:health_band/home.dart';
import 'package:health_band/model/cat_model.dart';
import 'package:postgrest/postgrest.dart';
//import 'package:uuid/uuid.dart';
pickImage (ImageSource source) async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile ? _file = await _imagePicker.pickImage(source :source);
  if (_file != null){
    return await _file.readAsBytes();
  }
  else {print('No images Selected');
}
}


class AppService extends ChangeNotifier{
  /*Future<void> refreshSession() async {
    if (supabase.auth.currentSession != null) {
      final expiresAt = DateTime.fromMillisecondsSinceEpoch(
          supabase.auth.currentSession!.expiresAt! * 1000);
      if (expiresAt
          .isBefore(DateTime.now().subtract(const Duration(seconds: 2)))) {
        await supabase.auth.refreshSession();
      }
    }
  }*/
  Future <List<Cat>> getData(String ? filter)  async{
    final query = supabase.from('healthdatos_datos').select('id, pulsos, oxigenacion, time, movimiento,temperatura').order('time', ascending: false).limit(1);
    late PostgrestResponse response;

    if (filter == null || filter.isEmpty) {
      response = await query.execute();
    }
    
    if (response.status !=200){
      throw Exception('Failed to load data');
    }

    if (response.data != null){
      return (response.data as List<dynamic>).map((json) => Cat.fromJson(json)).toList();
    } else {
      return [];
    }

    /*try{
      await query;
      return (query as List<dynamic>).map((json) => Cat.fromJson(json)).toList();
    }catch(e){
      throw Exception(e);
    }*/
  }

    
    /*final response = await supabase.from('healthdatos_datos').select('pulsos, oxigenacion, time, movimiento,temperatura').order('time', ascending: false).limit(1);
    if (response.error != null && response.status != null){
      print('error en la consulta: ${response.error.message} ');
      return response.error.message;
    }
    final data = response.data;
    if (data != null){
        final pulsos = data!['pulsos'] as String;
        final o2 = data!['oxigenacion'] as String;
        final temp = data!['temperatura'] as String;
        final move = data!['movimiento'] as String;
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

  
}