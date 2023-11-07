import 'package:health_band/model/base_model.dart';
//import 'package:json_annotation/json_annotation.dart';


class Cat implements BaseModel {

  @override
  final int id;
  final double pulsos;
  final double o2;
  final int temp;
  final String? mov;
  //Cat categoria;

  Cat({
     required this.id,
     required this.pulsos,
     required this.o2,
     required this.temp,
     this.mov,
  }
  );

  factory Cat.fromJson(Map<dynamic, dynamic> json) {
    return Cat(
      id: json[0]['id'],
      pulsos: json[1]['pulsos'],
      o2: json[2]['oxigenación'],
      temp: json[5]['temperatura'],
      mov: json[4]['movimiento'] ? json['movimiento'].toString() : null,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pulsos': pulsos,
      'oxigeno': o2,
      'temperatura': temp,
      'movimiento': mov != null && mov!.isNotEmpty ? true : false,
    };
  }

  @override
  Map value(){
    return {'cat':this};
  }
}

  /*Cat cat (Map<String, dynamic> data){
    return Cat(
      id: data['id'],
      pulsos: data ['pulsos'],
      o2: data ['oxigenacion'],
      temp: data['temperatura'],
      mov: data['movimiento']
    );
  }

  List <Cat> dataList = [];


  /*factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      pulsos: json['pulsos'],
      o2: json['oxigenacion'],
      temp: json['temperatura'],
      mov: json['movimiento']
    );
  }*/

  Map toMap() {
    return {
      'id': id,
      'pulsos': pulsos,
      'oxigenacion': o2,
      'temperatura': temp,
      'movimiento': mov
    };
  }

  @override
  Map value() {
    return toMap();
  }
}*/