from django.shortcuts import render
from . import models 
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .models import Datos

def home(request):
    return render(request, "home.html")

def nosotros(request):
    return render(request, "quienessomos.html")

def tusalud(request):
    valorpulso = Datos.objects.all().order_by('-time')[:1]
    return render(request, "tusalud.html", {'valorpulso':valorpulso})

def tuexperiencia(request):
    return render(request, "tuexperiencia.html")

def masinfo(request):
    return render(request, "masinfo.html")

def app(request):
    return render(request, "app.html")

@csrf_exempt
def mediciones(request):
    if request.method == 'POST': #le pide que reciba metodos POST nomas
        try: #Bucle que intenta infinitamente
            data = json.loads(request.body)  # Analiza el JSON recibido
            pulsaciones = data["PULSOS"] #Agarra del JSON la data que tenga de nombre pulsaciones
            oxigenacion = data["OXIGENO"] #Agarra del JSON la data que tenga de nombre OXIGENO
            temperatura = data["TEMPERATURA"] #Agarra del JSON la data que tenga de nombre TEMPERATURA
            movimiento = data["MOVIMIENTO"] #Agarra del JSON la data que tenga de nombre MOVIMIENTO
            models.Datos.objects.create(pulsos=pulsaciones, oxigenacion=oxigenacion, temperatura=temperatura, movimiento=movimiento)#Crea automaticamente valores en la tabla de la base de datos
            return JsonResponse({'message': 'Datos recibidos y almacenados exitosamente'}) 
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Error al analizar JSON'}, status=400)
    elif request.method  == 'GET':
        return data
    return JsonResponse({'error': 'Método no permitido'}, status=405)
