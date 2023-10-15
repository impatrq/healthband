from django.db import models

class datos(models.Model):
    pulsaciones = models.IntegerField()
    oxigeno= models.DecimalField(max_digits=5, decimal_places=2)

