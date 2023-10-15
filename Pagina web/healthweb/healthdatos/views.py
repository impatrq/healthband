from django.shortcuts import render
from .models import datos 
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json


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

def recibir_datos_json(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)  # Analiza el JSON recibido
            pulsaciones = data.get("pulsaciones")
            Spo2 = data.get("Spo2")
            datos.objects.create(pulsaciones=pulsaciones, oxigeno=Spo2)
            return JsonResponse({'message': 'Datos recibidos y almacenados exitosamente'})
        except json.JSONDecodeError:
            return JsonResponse({'error': 'Error al analizar JSON'}, status=400)
    return JsonResponse({'error': 'Método no permitido'}, status=405)
