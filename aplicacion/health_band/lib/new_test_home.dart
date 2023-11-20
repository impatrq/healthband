import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_band/model/model_category.dart';
import 'package:health_band/utils.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:health_band/model/cat_model.dart';
import 'package:health_band/model/category_repo.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}):super(key: key);
  static String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final SupabaseClient _client = Supabase.instance.client;
  //final RepoData _dataRepo = RepoData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(title: Text('Health Band')),
          body: FutureBuilder<List<Cat>> (future: context.read<AppService>().getData(null),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index){
                  final _cat = snapshot.data![index];
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    children: [
                      Text(_cat.pulsos.toString()),
                      Text(_cat.o2.toString()),
                      Text(_cat.temp.toString()),
                      Text(_cat.mov.toString()),
                    ],
                  )/*ListTile(title: Text(_cat.pulsos.toString())*/);
              });
            }
            else{
              return Center(
                child: Column(children :[
                  Text(snapshot.error.toString()),
                  const SizedBox(height: 15,),
                  const CircularProgressIndicator()
                ] ),
              );} 
              
          },
          )
          
          
          /*StreamBuilder<Map<String, dynamic>>(
            stream: _dataRepo.getLatestData(),
            builder: (context, snapshot){
              if (snapshot.hasData){
                Map<String, dynamic> allData = snapshot.data as Map<String, dynamic>;
                return ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (context, index){
                    final pulsos = allData['pulsos'];
                    final o2 = allData['o2'];
                    final temp = allData['temperatura'];
                    final mov = allData['mov'];
                    //RepoData _cat = allData[index];
                    return Column(children:[
                      Text('pulsos:$pulsos'),
                      Text('o2:$o2'),
                      Text('temperatura: $temp'),
                      Text('actividad:$mov')
                    ]);
                  });
              }
              else if(snapshot.hasError){
                return const Center(child: Text('something wrong'),);
              }
              return const Center(child: CircularProgressIndicator(),);
            } ,
          ),*/
          
          /*FutureBuilder<List<Cat>>(future: context.read<AppService>().getData(null),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index){
                  final category = snapshot.data![index];
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5), child:Card( child: ListTile(title: Text(category.pulsos.toString()),
                  ),
                  ),
                  );
              });
            }else if (snapshot.hasError){
              return Text(snapshot.error.toString());
            }
      
            return const Center(child: CircularProgressIndicator(),);
      
          } 
         ),*/
        ),
      ),
    );
  }
}

