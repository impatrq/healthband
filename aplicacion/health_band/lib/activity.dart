import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        flexibleSpace: Container(
          width: 393.0,
          padding: const EdgeInsets.fromLTRB(60.0, 50.0, 60.0, 10.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 14, 52, 96),
            image: DecorationImage(image:AssetImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/actividad pattern.png'), opacity: 0.1, fit: BoxFit.fill )
          ),
        ),
        title: Text('Actividad', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300),),
      ) ,
     body: Center(
       child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text('Actividad Normal', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700, color: Colors.black),),
              SizedBox(height: 15,),
              Text('No se registra ningún movimiento anormal o caída', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black),),
              SizedBox(height: 35,),
            ]
          )
       )
     )
    );
  }
}