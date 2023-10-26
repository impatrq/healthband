import requests
info = { 'PULSOS' : 2200 , 'OXIGENO' : 30 , 'TEMPERATURA' : 2 , 'MOVIMIENTO' : "Estoy Ido" }
g = requests.post("http://192.168.1.111:8080/datos/", json=info)
print (g.json())