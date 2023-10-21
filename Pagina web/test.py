import requests
info = { 'PULSOS' : 60 , 'OXIGENO' : 50 }
requests.post("http://192.168.126.50:8080/datos/", json=info)