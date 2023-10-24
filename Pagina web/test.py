import requests
info = { 'PULSOS' : 2200 , 'OXIGENO' : 30 , 'TEMPERATURA' : 2 , 'MOVIMIENTO' : "Estoy Ido" }
g = requests.post("https://www.healthband.com.ar/datos/", json=info)
print (g.json())