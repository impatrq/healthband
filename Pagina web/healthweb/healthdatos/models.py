from django.db import models
import datetime 

class Datos(models.Model):
    pulsos = models.FloatField(default=None, null= True)
    oxigenacion = models.FloatField(default=None, null= True)
    temperatura = models.FloatField(default=None, null = True)
    movimiento = models.CharField (max_length=30, null = True)
    time = models.DateTimeField(default=datetime.datetime.now, null=True)