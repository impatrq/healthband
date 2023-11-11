from django.shortcuts import render
from . import models 
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .models import Datos
# Create your views here.

def home(request):
    return render(request, "home.html")

def about(request):
    return render(request, "about.html")

def team(request):
    return render(request, "team.html")

def contact(request):
    return render(request, "contact.html")

def projects(request):
    return render(request, "projects.html")

def blog(request):
    return render(request, "blog.html")


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
        pulsaciones = request.POST('PULSOS')
        oxigenacion = request.POST('OXIGENO')
        temperatura = request.POST('TEMPERATURA')
        movimiento = request.POST('MOVIMIENTO')
    return JsonResponse({'error': 'Método no permitido'}, status=405)
