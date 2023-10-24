from django.urls import path
from . import views
from django.views.decorators.csrf import csrf_exempt

urlpatterns = [path("", views.home, name="home"), 
path("nosotros/", views.nosotros, name="nosotros"),
path("tusalud/", views.tusalud, name="tusalud"),
path("tuexperiencia/", views.tuexperiencia, name="tuexperiencia"),
path("masinfo/", views.masinfo, name="masinfo"),
path("app/", views.app, name="app"),
path("datos/", views.mediciones, name="mediciones"),
]

