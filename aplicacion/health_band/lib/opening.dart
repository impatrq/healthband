import 'package:flutter/material.dart';
import 'package:health_band/home.dart';
import 'dart:async';


class OpeningWidget extends StatefulWidget {
  static String id = 'opening';

  const OpeningWidget({super.key});
  @override 
  _OpeningWidgetState createState() => _OpeningWidgetState();
}

class _OpeningWidgetState extends State<OpeningWidget> {
  double opacity = 1.0; // Initial opacity
  bool openingFrameVisible = true;

@override
  void initState() {
    super.initState();
    // Start a timer to control the opening frame visibility
    Timer(const Duration(seconds: 5), () {
      setState(() {
        opacity = 0.0; // Set opacity to 0 to make it disappear
      });

      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return const HomeView();
          }),
        );
      });
    });
  }
          @override
          Widget build(BuildContext context) {
          // Figma Flutter Generator OpeningWidget - FRAME
            return Scaffold(
              body: Stack(
                    children: [
                      AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(seconds: 1),
                      child:Stack(
                        alignment: Alignment.topCenter,
                      children: [
                        Image.asset('assets/images/fondo opening.png', width: 393.0, height: 892.0),
                      Container(
                      width: 393.0,
                      height: 892.0,
                      decoration: const BoxDecoration(
                        gradient : LinearGradient(
                        begin: Alignment(-0.718673586845398,-0.6252008676528931),
                        end: Alignment(-0.2704503536224365,1.461146354675293),
                        colors: [Color.fromRGBO(14, 52, 96, 1),Color.fromRGBO(4, 20, 39, 1)]
                                ),
                      //image: DecorationImage(image: AssetImage('assets/images/fondo opening.png'), fit: BoxFit.fill)
                )
              
                  ),
                  Center(
                  child: Image.asset('/Users/tobiaspagano/Documents/GitHub/healthband/aplicacion/health_band/lib/assets/images/logo hb app con lema en 1.png', width: 200.0, height: 200.0,),
                  ),
                      ],
                      ),
                      
                      )
                    ],
                  ),
            );
          }
        }
        