#include <Ticker.h>
#include <esp32-hal-ledc.h>
int cuentaIR = 0; //para generar la onda cuadrada del IR
int cuentasalida = 0; //para leer la salida de mi sensor
int picoapico = 0; //para leer la salida de mi sensor
int mimax = 0;
int mimin = 1023;
int aux;
int estadoIR = 0; //0 apagado, 1 encendido
const int pwmPin = 4;
Ticker timer;
void toggleIRLED() {
  static int estadoIR = 0; // Variable estática para mantener el estado
  if (estadoIR == 0) {
    digitalWrite(4, HIGH);
    estadoIR = 1;
  } else {
    digitalWrite(4, LOW);
    estadoIR = 0;
  }
}
void setup() {
pinMode(4, OUTPUT);
pinMode(2, OUTPUT);
pinMode(36, INPUT); 
pinMode(39, INPUT);
Serial.begin(9600); //para comunicar la salida
pinMode(pwmPin, OUTPUT);
analogWrite(pwmPin, 250);
timer.attach_ms(500, toggleIRLED);
}
void loop() {
analogWrite(0, 128); // Generamos una señal PWM con un valor de 128 (ciclo de trabajo del 50%)
delay(2);       // Esperamos 1 segundo
analogWrite(0, 0);   // Apagamos la señal PWM
delay(2);
/*aux = analogRead(36);
if (aux>mimax) mimax=aux;
if (aux<mimin) mimin=aux;*/
cuentaIR=cuentaIR+1;
if (cuentaIR == 125){//125*4=500ms encendido, 500 ms apagado
    cuentaIR = 0;
    if (estadoIR == 0){digitalWrite(4, HIGH);
        estadoIR = 1;
 }  else{digitalWrite(4, LOW);
        estadoIR = 0;
    cuentasalida=cuentasalida+1;
  if (cuentasalida == 3){ //cada 3 segundos
 cuentasalida = 0;
picoapico = mimax-mimin;
Serial.print("min:");
Serial.println(mimin);
Serial.print("max:");
Serial.println(mimax);
 mimax=0;
mimin=1023;
Serial.print("cuentair:");
Serial.println(cuentaIR);
Serial.print("cuentasalida");
Serial.println(cuentasalida);
Serial.print("aux:");
Serial.println(aux);
Serial.print("valor: ");
Serial.println(picoapico);
 }
 }
 }
}