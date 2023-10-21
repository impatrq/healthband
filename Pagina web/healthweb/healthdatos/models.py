from django.db import models
import datetime 

class Datos(models.Model):
    pulsos = models.FloatField(default=None, null= True)
    oxigenacion = models.FloatField(default=None, null= True)
    time = models.DateTimeField(default=datetime.datetime.now, null=True)