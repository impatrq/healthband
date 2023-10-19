from django.db import models

class datos(models.Model):
    pulsos = models.IntegerField(default=None)
    oxigenacion = models.IntegerField(default=None)