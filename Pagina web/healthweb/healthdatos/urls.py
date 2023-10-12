from django.urls import path
from . import views

urlpatterns = [path("", views.home, name="home"),
path("nosotros/", views.about, name="nosotros"),
path("team/", views.team, name="team"),
path("contact/", views.contact, name="contact"),
path("projects/", views.projects, name="projects"),
path("blog/", views.blog, name="blog")
]
