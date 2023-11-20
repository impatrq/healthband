import 'package:flutter/material.dart';

enum Strength {
    empty('', 0 / 4, Colors.transparent),
    weak('weak', 1 / 4, Colors.red),
    medium('medium', 2 / 4, Colors.orange),
    strong('strong', 3 / 4, Colors.yellow),
    veryStrong('very strong', 4 / 4, Colors.green),
    ;

    final String text;
    final double value;
    final Color color;
  
    const Strength(this.text, this.value, this.color);
  }

class Example extends StatefulWidget {
    const Example({super.key});
  
    @override
    State<StatefulWidget> createState() {
      return ExampleState();
    }
  }
class ExampleState extends State<Example> {
   String? _pswrd = "";

  String? validatePassword (String? value){
     if (value!.length < 5 || value.isEmpty) {
  return "Ingrese una contraseña válida";  
}
return null;
  }
  
  Strength _strength = Strength.empty;
  
    void _updatePasswordStrength(String value) {
      setState(() {
        _strength = _calculatePasswordStrength(value);
      });
    }
  
    Strength _calculatePasswordStrength(String value) {
      if (value.length < 6) {
        return Strength.weak;
      } else if (value.length < 10) {
        return Strength.medium;
      } else {
        final containsRecommendedChars = value.contains(RegExp(r'[A-Z]'))
            && value.contains(RegExp(r'[a-z]'))
            && value.contains(RegExp(r'[0-9]'))
            && value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  
        if (!containsRecommendedChars) {
          return Strength.strong;
        } else {
          return Strength.veryStrong;
        }
      }
    }
    @override
    Widget build(BuildContext context) {
      return Column(
        children:[
          TextFormField(
            validator: validatePassword,
            onSaved: (value){
              _pswrd = value;
            },
          onChanged: (value) => _updatePasswordStrength(value),
          decoration: InputDecoration(hintText: 'Ingrese su contraseña', hintStyle:TextStyle(color: Color.fromARGB(255, 172, 172, 172))),
        ),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: LinearProgressIndicator(
                minHeight: 10,
                value: _strength.value,
                backgroundColor: Colors.grey,
                color: _strength.color,
                borderRadius: BorderRadius.circular(5),
              ),
        ),
          const SizedBox(
              height: 5,
            ),
            Text(_strength.text.isNotEmpty ? 'Your password is ${_strength.text}' : '') 
        ]
      );
    }
  }