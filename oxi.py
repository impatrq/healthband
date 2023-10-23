import pulsometro
#se importa la libreria nexus del max la cual contiene los calculos y funciones para sensar pulso y oxigeno 
from pulsometro import Pulso
#de pulsometro se importa la clase pulso para futuras funciones
from machine import Timer
#se importa la libreria de timer
import _thread
# se importan los hilos para hacer multihilos en simultaneo (varias tareas)
import time
# se importa la libreria de time para utilizar funciones de tiempo
import urequests as requests
#se importa la funcion urequests y se le pide que se llame "requests"
import network
#se importa la funcion network
import ujson as json
#se importa la funcion ujson y se le pide que se llame "json"
import lm335
from lm335 import grados

def conexion():
    #se crea la funcion conexion
    sta_if = network.WLAN(network.STA_IF)
    #se crea la variable sta_if y se le dice que va a ser una red inalambrica (network.WLAN). se comporta como un cliente de red asi puede conectarse a un WIFI 
    if not sta_if.isconnected():
        print('Estableciendo conexion con la red')
        #se muestra en la pantalla un mensaje el cual dice "Estableciendo conexion con la red"
        sta_if.active(True)
        #Se declara que la variable STA_IF se pueda conectar a redes wifi
        sta_if.connect('Red Alumnos', '')
        #aqui se declara primero la red a conectarse y luego la contraseña 
        while not sta_if.isconnected():
            # si no se establece ninguna conexion, dejarla pasar. 
            pass
        print('Conexion Establecida')
        #cuando se extablece la conexion aparece un mensaje de "conexion establecida"
conexion()
#se ejecuta la funcion conexion 

Sensor = Pulso()
#Se declara la variable sensor que es = a pulso(), la cual es una clase establecida en pulsometro.py

temperatura = grados()

def test():
    #se declara la funcion test para luego llamar a la funcion muestra de pulsometro.py 
    Sensor.muestra()
def test2 ():
    temperatura.calentura()


def categorizar_pulsaciones(pulsaciones):
    #se declara la funcion categorizar_pulsaciones con el objetivo de brindar un mensaje dependiendo lo medido
    if 60 <= pulsaciones <= 80:
        #Si es mayor o igual a 60 o menor o igual a 80, son pulsaciones normales
        return "Pulsaciones normales"
    elif 85 <= pulsaciones <= 90:
        #Si es mayor o igual a 85 o menor o igual a 90, son pulsaciones con ejercicio moderado
        return "Ejercicio moderado"
    elif pulsaciones >= 100:
        #Si es mayor o igual a 100 son pulsaciones con ejercicio intenso
        return "Ejercicio intenso"
    elif pulsaciones < 40:
        #Si es menor o igual a 40 son pulsaciones criticamente bajas
        return "Pulso criticamente bajo"
    else:
        return "Pulsaciones bajas"

def categorizar_o2(Spo2):
    #se declara la funcion categorizar_o2 con el objetivo de brindar un mensaje dependiendo lo medido
    if Spo2 < 95:
        #si es menor a 95 hay baja oxigenacion
        return "Baja Oxigenacion"
    elif Spo2 > 100:
        #si es mayor a 100, entonces seria una muestra no valida ya que es imposible estar a un 101%, por lo contrario, es una buena oxigenacion.
        return "Muestra no valida"
    else:
        return "Buena Oxigenacion"
    
def categorizar_temp(temp):
    if temp < 34:
        return "Baja temperatura"
    elif temp > 37.2:
        return "Alta temperatura"
    elif 34.1 <= temp <= 37.5:
        return "Temperatura normal"
    


def mediciones():
    #Se declara la funcion mediciones 

    while True:
        #se declara un bucle, el cual es infinito hasta que se interrumpa manualmente
        pulsaciones = Sensor.datos
        #Se declara la variable pulsaciones, la cual almacena los datos del Sensor Bpm (pulsaciones) 
        Spo2= Sensor.datos2
        #Se declara la variable pulsaciones, la cual almacena los datos del Sensor Spo2 (Oxigeno)
        
        temp = temperatura.datos4


        
        mensaje = categorizar_pulsaciones(pulsaciones), categorizar_o2(Spo2), categorizar_temp(temp) 
        #Se declara la variable mensaje la cual toma los datos de pulsaciones y Spo2 y devuelve uno de los mensajes declarados arriba en las categorizaciones
        print("Pulsaciones: ",pulsaciones," BPM", " Spo2: ",Spo2, "%", "Temperatura", temp, "°c")
        #El bucle muestra lo medido en Pulsaciones y Spo2
        print(mensaje)
        #El bucle muestra el resultado de la categorizacion de Pulsaciones y Spo2
        time.sleep(4)
        #El codigo espera 4 segundos para volver a iniciar el bucle nuevamente
time.sleep(1)
#El codigo espera 1 segundo para volver a iniciar la funcion test
_thread.start_new_thread(test, ())
time.sleep(1)
#El codigo espera 1 segundo para vovler a inciar la funcion mediciones
_thread.start_new_thread(test2, ())
time.sleep(1)
_thread.start_new_thread(mediciones, ())

def web():
    #Se declara una funcion llamada web para lo que seria el traspaso de datos sensados
    pulsaciones = Sensor.datos
    #Se vuelve a llamar a la variable pulsaciones que contiene lo medido en BPM
    Spo2= Sensor.datos2
    
    temp = temperatura.datos4
    
    #Se vuelve a llamar a la variable Spo2 la cual contiene lo medido en Spo2
    if Sensor.datos > 40 and Sensor.datos < 130 and Sensor.datos2 > 50 and Sensor.datos2 < 110 and temperatura.datos4 > 30 and temperatura.datos4 < 45:
        #Se le dice a la funcion que SI Bpm esta ente 40 y 110 Y  que SI Spo2 esta entre 50 y 110, entonces ejecute lo siguiente
        info = { 'PULSOS' : pulsaciones , 'OXIGENO' : Spo2 , 'TEMPERATURA' : temp}
        #Se declara la variable info que contiene Pulsaciones y Spo2
        g = requests.post('http://1s92.168.126.50:8080/datos', json=info)
        #Se hace un request.post, el cual envia lo sensado a la pagina web en forma de json, el cual este llama a la variable info
        print (g.text)
        #Se muestra en la pantalla lo enviado a la pagina web
    time.sleep (2)
    #El codigo espera 2 segundos para volver a ejecutar el if
while True:
    #Se crea un bucle para que web se ejecute constantemente 
    web()
    time.sleep (2)
    #El codigo espera 2 segundos para volver a ejecutar web 
        



