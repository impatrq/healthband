#define CON2_1 4 // El CON2-1 corresponde al D4
#define CON2_3 2 // El CON2-3 corresponde al D2
//#define CON2_13 A3 // El CON2-13 corresponde al A3
#define CON2_14 36 // Salida filtrada y amplificada
//#define CON2_15 A1 // Libre (por si es necesario)
#define CON2_16 39 // Salida del sensor
// Para hallar a qué pinMode corresponde un pin físico:
// Miramos el pin físico que queremos utilizar, por ejemplo, el pin CON-2 3.
// Lo buscamos en el esquema del micro del datasheet y miramos las funciones que
// puede realizar, en este caso: OC5/IC5/PMWR/CN13/RD4.
// Buscamos eso en el esquema de la hoja de correspondencia del PIC32 PINGUINO OTG
// y vemos que se corresponde con D2(BUT). Siguiendo la línea, nos lleva a D2.
// Como es un pin digital, no es necesario utilizar la D, por lo que el pinMode será 2
#define TM 10 // Define el tiempo de muestreo
#define LEDR CON2_3 // La señal del Led rojo vendrá por el CON-2 3
#define LEDIR CON2_1 // La señal del Led IR vendrá por el CON-2 1
int Te=1000*5; // Tiempo de encendido en ms
int cuentaTe=0;
int Ts=500; // Tiempo de separacion en ms
int cuentaTs=0;
int valorIR;
int valoraux;
int valorLEDR;
int valor0;
int Ti=0;
int Tf=0;
int Tx=0;
int parIR=0;
//Mejora del diseño de un prototipo de sensor no invasivo para la medida de glucosa en sangre 101
int parsep1=0;
int parLEDR=0;
int parsep2=0;
int aux;
int aux2;
unsigned char b0;
unsigned char b00;
unsigned char b1;
unsigned char b10;
unsigned char b2;
unsigned char b20;
unsigned char b3;
unsigned char b30;
void setup() {
pinMode(LEDR, OUTPUT); //salida para el led rojo
pinMode(LEDIR, OUTPUT); //slida para el led IR
pinMode(CON2_16, INPUT); //ADC A0
pinMode(CON2_14, INPUT); //ADC A2

Serial.begin(9600); //para comunicar la salida
}
void loop() {
parIR=0;
parsep1=0;
parLEDR=0;
parsep2=0;
//////////////////////// Enciende y apaga el LED IR /////////////////////////////////////////
digitalWrite(LEDIR, HIGH);
Ti=millis(); 
//cuentaTe = millis();
//lee el tiempo en ms desde el instante en que se ha empezado a ejecutar
 //if (parIR <1){
 // Serial.print("ok");
//}
while (parIR<1){
  
  if (cuentaTe>Te){digitalWrite(LEDIR, LOW);
  //Anexo A 102
    cuentaTe=0;
    parIR=2;
  }
  else {
    Tf=millis();
    Tx=Tf-Ti;
  if (Tx>TM){ aux=analogRead(CON2_16);
      b00=aux / 256;
      b10=aux % 256;

      b0=(b00 << 3) | (b10 >> 5);
      Serial.write(0x80 | b0);

      b1=b10 & 0x1f;
      Serial.write(0x0 | b1);

      aux2=analogRead(CON2_14);
      b20=aux2 / 256;
      b30=aux2 % 256;

      b2=(b20 << 3) | (b30 >> 5);
      Serial.write(0xA0 | b2);

      b3=b30 & 0x1f;
      Serial.write(0x0 | b3);

      Ti=Tf;
      cuentaTe=cuentaTe+TM;
  }
 }
//////////////////////// Tiempo de separación //////////////////////////////////////////////
//Ti=millis();
while (parsep1<1){
  
 if (cuentaTs>Ts){cuentaTs=0;
 parsep1=2;
 }
else{
 Tf=millis();
 Tx=Tf-Ti;
 if (Tx>TM){ Ti=Tf;

 aux=analogRead(CON2_16);
 b00=aux / 256;
 b10=aux % 256;

 b0=(b00 << 3) | (b10 >> 5);
 Serial.write(0x80 | b0);

 b1=b10 & 0x1f;
 Serial.write(0x20 | b1);

 aux2=analogRead(CON2_14);
 b20=aux2 / 256;
 b30=aux2 % 256;

 b2=(b20 << 3) | (b30 >> 5);
 Serial.write(0xA0 | b2);

 b3=b30 & 0x1f;
 Serial.write(0x20 | b3);

 cuentaTs=cuentaTs+TM;
 }
}
//////////////////////// Enciende y apaga el LED ROJO /////////////////////////////////////
digitalWrite(LEDR, HIGH);
//Ti=millis();
while (parLEDR<1){
  
 if (cuentaTe>Te){digitalWrite(LEDR, LOW);
//Anexo A 104
 cuentaTe=0;
 parLEDR=2;
 }
 else{
 Tf=millis();
 Tx=Tf-Ti;
 if (Tx>TM){ aux=analogRead(CON2_16);
    b00=aux / 256;
    b10=aux % 256;

    b0=(b00 << 3) | (b10 >> 5);
    Serial.write(0x80 | b0);

    b1=b10 & 0x1f;
    Serial.write(0x40 | b1);

    aux2=analogRead(CON2_14);
    b20=aux2 / 256;
    b30=aux2 % 256;

    b2=(b20 << 3) | (b30 >> 5);
    Serial.write(0xA0 | b2);

    b3=b30 & 0x1f;
    Serial.write(0x40 | b3);

    Ti=Tf;
    cuentaTe=cuentaTe+TM;
 }
 }
}
//////////////////////// Tiempo de separación /////////////////////////////////////////////
//Ti=millis();
while (parsep2<1){
 
  if (cuentaTs>Ts){cuentaTs=0;
    parsep2=2;
  //Mejora del diseño de un prototipo de sensor no invasivo para la medida de glucosa en sangre 105
  }
  else{
    Tf=millis();
    Tx=Tf-Ti;
  if (Tx>TM){ Ti=Tf;
      aux=analogRead(CON2_16);
      b00=aux / 256;
      b10=aux % 256;

      b0=(b00 << 3) | (b10 >> 5);
      Serial.write(0x80 | b0);

      b1=b10 & 0x1f;
      Serial.write(0x60 | b1);

      aux2=analogRead(CON2_14);
      b20=aux2 / 256;
      b30=aux2 % 256;

      b2=(b20 << 3) | (b30 >> 5);
      Serial.write(0xA0 | b2);

      b3=b30 & 0x1f;
      Serial.write(0x60 | b3);

      cuentaTs=cuentaTs+TM;
  }
}
}


