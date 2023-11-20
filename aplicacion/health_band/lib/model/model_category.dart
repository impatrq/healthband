import 'package:supabase_flutter/supabase_flutter.dart';
import 'cat_model.dart';

/*class RepoData{
  final SupabaseClient _client = Supabase.instance.client;
  Stream<Map<String, dynamic>> getLatestData() {
  /*final queryBuilder = (queryBuilder) {
    queryBuilder
      ..select('pulsos, oxigenacion, temperatura, movimiento')
      ..from('healthdatos_datos')
      ..order('time', ascending: false)
      ..limit(1);
  };*/
  final stream = _client.from('healthdatos_datos').select('pulsos, oxigenacion, temperatura, movimiento').order('time', ascending: false).limit(1).stream();
  return stream ;
}
}*/