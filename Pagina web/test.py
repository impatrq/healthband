import requests
info = { 'PULSOS' : 102 , 'OXIGENO' : 99.48 , 'TEMPERATURA' : 37 , 'MOVIMIENTO' : "No ha ocurrido nada" }
g = requests.post("http://172.20.10.3:8080/datos/", json=info)
print (g.json())