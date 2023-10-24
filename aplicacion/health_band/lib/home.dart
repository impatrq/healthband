import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int myIndex = 0;
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
      body: SingleChildScrollView(
        child: Center(
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
                      SizedBox(height: 8,)
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
                      SizedBox(height: 8,)
                      ], 
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
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
                          ConstrainedBox(constraints:BoxConstraints(maxWidth:70), child: Text('Temperatura Corporal', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 10))),
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
                      SizedBox(height: 8,)
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
                          Text('Actividad', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 11),),
                          SizedBox(width: 40,),
                          IconButton(onPressed: (){}, icon: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/chevron-Agw.png', width: 8.0, height: 8.0,))
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('X', style: TextStyle(color:  Color.fromARGB(255, 14, 52, 96), fontSize: 25.0),),
                        ],
                      ),
                      SizedBox(height: 8,)
                      ], 
                    ),
                  ),
                ],
              ),
             
              SizedBox(height: 30,),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                        borderRadius : BorderRadius.circular(16),
                        color : Color.fromRGBO(218, 3, 3, 1),
                        ),
                  child: MaterialButton(
                        onPressed: () {
                          FlutterPhoneDirectCaller.callNumber('+5491126913745');
                        },
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius : BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),),
                                ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      image : DecorationImage(
                                      image: AssetImage('assets/images/Info.png'),
                                      fit: BoxFit.fitWidth
                                      ),
                                    )
                                  ),
                                  SizedBox(width : 8),
                                  Center(
                                    child: Text('Emergencias', textAlign: TextAlign.center, style: TextStyle(
                                    color: Color.fromRGBO(186, 186, 186, 1),
                                    fontFamily: 'Commissioner',
                                    fontSize: 11,
                                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  
                                ],
                              ),
                            ),
                ),
              ),

              //BotondeemergenciasWidget()
            ],)
          ),
          
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(onTap:(index) {
        setState((){
          myIndex = index;
        });
      } ,
      currentIndex: myIndex,  
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Alarm")
      ],),
    );
  }
}


        
        
/*class BotondeemergenciasWidget extends StatefulWidget {
  @override
  _BotondeemergenciasWidgetState createState() => _BotondeemergenciasWidgetState();}
        
   class _BotondeemergenciasWidgetState extends State<BotondeemergenciasWidget> {
   @override
   Widget build(BuildContext context) {
        // Figma Flutter Generator BotondeemergenciasWidget - FRAME - VERTICAL
        
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 127, vertical: 58),
        child: Column(
          mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color : Color.fromRGBO(255, 255, 255, 1),),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
        
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                  borderRadius : BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16),),
                  color : Color.fromRGBO(218, 3, 3, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
              
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),),
                          color : Color.fromRGBO(255, 255, 255, 1),
                          ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          
                          children: <Widget>[
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                image : DecorationImage(
                                image: AssetImage('assets/images/Info.png'),
                                fit: BoxFit.fitWidth
                                ),
                              )
                            ),
                            SizedBox(width : 8),
                            Text('Emergencias', textAlign: TextAlign.center, style: TextStyle(
                            color: Color.fromRGBO(186, 186, 186, 1),
                            fontFamily: 'Commissioner',
                            fontSize: 11,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1
                            ),
                            ),

                          ],
                        ),
                      ),

                          ],
                        ),
                      ),

                          ],
                        ),
                      ),
                  ],
                        ),
                      );
                          }
                          }*/
                          