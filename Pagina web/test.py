import requests
info = { 'PULSOS' : 102 , 'OXIGENO' : 99.48 , 'TEMPERATURA' : 37 , 'MOVIMIENTO' : "No ha ocurrido nada" }
g = requests.post("http://192.168.111.236:8080/datos/", json=info)
print (g.json())