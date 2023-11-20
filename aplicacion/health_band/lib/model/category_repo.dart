import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cat_model.dart';

/*class DataRepo{
  final SupabaseClient _client = Supabase.instance.client;
  Stream<List<Cat>> getAllData(){
    final query = """
    SELECT pulsos, oxigenacion, temperatura, movimiento
    FROM healthdatos_datos
    ORDER BY time DESC
    LIMIT 1;
  """;
    final allData =_client.from('healthdatos_datos').stream((queryBuilder){
      queryBuilder ..select('pulsos, oxigenacion, temperatura, movimiento')
    ..orderBy('time', descending: true)
    ..limit(1);
    });
      /*return event.map((e){
        return Cat.fromJson(e);
      }).toList();
    });*/
    return allData;
  }
}*/