#include <plib.h>
int cuentaIR = 0; //para generar la onda cuadrada del IR
int cuentasalida = 0; //para leer la salida de mi sensor
int picoapico = 0; //para leer la salida de mi sensor
int mimax = 0;
int mimin = 1023;
int aux;
int estadoIR = 0; //0 apagado, 1 encendido
void setup() {
pinMode(3, OUTPUT); //pin 3 es el D2 salida ultrasonido (CON2 PIN 3 pinguino micro)
pinMode(4, OUTPUT); //pin 4 es el D4 salida led (CON2 PIN 1 pinguino micro)
pinMode(5, INPUT); //pin 5 es el D5 ADC A0 (CON2 PIN 16 pinguino micro)
Serial.begin(9600); //para comunicar la salida
T2CONCLR = T2_ON; // Apagar el temporizador
T2CON = T2_PS_1_1; // Establecer el preescalado
TMR2 = 0; // Reiniciar el contador
PR2 = 2048; // Establecer el periodo
T2CONSET = T2_ON; // Encender el temporizador
OC1R = 2048; // Cargar el valor inicial en el registro del ciclo de trabajo
OC1RS = 2048; // Cuando un periodo finalice el contenido de OC1RS se carga en OC1R
OC1CON = OC_TIMER2_SRC | OC_PWM_FAULT_PIN_DISABLE; // Establecer el temporizador 2 como
fuente
OC1CONSET = OC_ON;
}
void loop() {
SetDCOC1PWM(0);
delay(2); //4 ms en total para conseguir 250Hz
SetDCOC1PWM(1024);
delay(2);
aux = analogRead(4);
if (aux>mimax) mimax=aux;
if (aux<mimin) mimin=aux;
cuentaIR=cuentaIR+1;
if (cuentaIR == 125){//125*4=500ms encendido, 500 ms apagado
    cuentaIR = 0;
    if (estadoIR == 0){digitalWrite(4, HIGH);
        estadoIR = 1;
 }  else{digitalWrite(4, LOW);
        estadoIR = 0;
    cuentasalida=cuentasalida+1;
 /if (cuentasalida == 3){ //cada 3 segundos
 cuentasalida = 0;
picoapico = mimax-mimin;
 mimax=0;
mimin=1023;
Serial.print("valor: ");
Serial.println(picoapico);
 }
 }
 }
}