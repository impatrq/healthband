import requests
info = { 'PULSOS' : 94 , 'OXIGENO' : 98.8766 }
requests.post("http://192.168.126.50:8080/datos/", json=info)