from django.db import models
import datetime 
from phonenumber_field.modelfields import PhoneNumberField

class Datos(models.Model):
    pulsos = models.FloatField(default=None, null= True)
    oxigenacion = models.FloatField(default=None, null= True)
    temperatura = models.FloatField(default=None, null = True)
    movimiento = models.CharField (max_length=30, null = True)
    time = models.DateTimeField(default=datetime.datetime.now, null=True)


class Usuarios(models.Model):
    nombre = models.CharField(default=None, null=True)
    telefono = PhoneNumberField(null=False, blank=False, unique=True)
    email = models.EmailField(default=None, null=True)
    genero = models.CharField(default=None, null=True)
    contraseña = models.CharField(default=None, null=True)