from django.db import models

class datos(models.Model):
    pulsos = models.FloatField(default=None)
    oxigenacion = models.FloatField(default=None)