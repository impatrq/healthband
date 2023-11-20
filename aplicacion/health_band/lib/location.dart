import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ShareLocationButton extends StatelessWidget {
  const ShareLocationButton({Key? key}) : super(key: key);
  Future <Position> determinePosition() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation()async{
    Position position = await determinePosition();
    print(position.latitude);
    print(position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
            onPressed: () async {
              getCurrentLocation();
              // Aquí puedes utilizar la información de posición para compartir la ubicación actual.
            },
            child: Text('Compartir ubicación actual'),
          ),
        ),
      
    );
  }
}
