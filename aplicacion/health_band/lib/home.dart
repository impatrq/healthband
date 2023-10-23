import 'package:flutter/material.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        flexibleSpace: Container(
          width: 393.0,
          padding: const EdgeInsets.fromLTRB(60.0, 50.0, 60.0, 10.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 14, 52, 96),
          ),
          child: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/logo_hb_en_.png', width: double.infinity, height: double.infinity,),
        ),
      ),
      body: Center(
        child: Container(
          width: 393.0,
          height: 852.0,
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
          child: Column(
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Bienvenido, Nombre', style: TextStyle(color: Color.fromARGB(255, 14, 52, 96), fontSize: 19.0),),
                SizedBox(width: 20,),
                MaterialButton(
                  onPressed: () {}, 
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/info-bBM.png', width: 18.0, height: 18.0,),
                        SizedBox(width: 8,),
                        Text('Descargar PDF', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 10.0),),
                      ],
                    ),
                  ),
                //AssetImage('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/info-bBM.png')
      
                ),
              ],
            ),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 15.0, height: 15.0,),
                        SizedBox(width: 10,),
                        Text('Ritmo Cardíaco', style: TextStyle(color: const Color.fromARGB(255, 14, 52, 96), fontSize: 10)),
                        SizedBox(width: 8,),
                        IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5,),
                        Text('X', style: TextStyle(color: Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
                      ],
                    ),
                    ],
                    //decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2.0)),
                    
                    
                  ),
                ),
                SizedBox(
                width: 10.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0.0, 0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 15.0, height: 15.0,),
                        SizedBox(width: 5,),
                        Text('Oxigeno en Sangre', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 10)),
                        IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5,),
                        Text('X', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
                      ],
                    ),
                    ], 
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 0.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 15.0, height: 15.0,),
                        SizedBox(width: 8,),
                        ConstrainedBox(constraints:BoxConstraints(maxWidth:65), child: Text('Temperatura Corporal', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 10))),
                        SizedBox(width: 12.0,),
                        IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5,),
                        Text('X', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0)),
                      ],
                    ),
                    ],
                    //decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2.0)), 
                  ),
                ),
                SizedBox(
                width: 10.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0.0, 0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.grey),
                  child: Column(
                   children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/pulse-bg.png', width: 15, height: 15,),
                        SizedBox(width: 8),
                        Text('Actividad', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 10),),
                        SizedBox(width: 18,),
                        IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('X', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
                      ],
                    ),
                    ], 
                  ),
                ),
              ],
            ),
            
          ],)
        ),
      ),
    );
  }
}
