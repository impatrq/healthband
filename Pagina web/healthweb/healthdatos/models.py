from django.db import models

class datos(models.Model): #Creacion de la clase datos, la cual va a contener la tabla de la base de datos
    pulsaciones = models.IntegerField() #aca se define la tabla con nombre pulsaciones 
    oxigeno= models.DecimalField(max_digits=5, decimal_places=2) #aca se define la tabla con nombre oxigeno 

