import requests, time, telebot, threading
# se importan las multiples librerias a utilizar en el bot de telegram. siendo la principal "telebot" 
# ya que es la conexion directa con telegram y el bot 
from bs4 import BeautifulSoup
# se importa la libreria beautifulsoup, encargada del chequeo de busqueda web

url = 'http://192.168.124.33:8080/tusalud/'
#se declara la variable URL, la cual contiene la pestada de "tu salud", la cual muestra los datos

bot = telebot.TeleBot('6755680497:AAGQbG6fIyhdbMxjJnKH6_1eXblJlZsHh2s')

#se declara la variable bot, la cual contiene el token para comunicar todo el proyecto con el bot

valores_esperados = {
    #Se declara la variable valores_esperados, siendo esta la que contiene las keys a evaluar para luego mandar la alerta o no
    "Pulsaciones": (40 , 140),
    #Pulsaciones entre 40 y 120
    "temperatura": (32 , 37.2),
    #temperatura entre 32 grados y 37.2
    "oxigeno": (90 , 100),
    #Oxigeno entre 90 y 100 %
    "movimiento": "Noocurrioningunaanormalidad"
    #Si lo mostrado en la pagina tiene el valor "No ocurrio ninguna anormalidad"
}

################################################################################################################################################
################################################################################################################################################
################################################################################################################################################

def check_website():
    #Se declara la funcion Check website, la cual es la encargada de chequear como su nombre indica, la pagina.
    response = requests.get(url)
    #Se declara la variable response, la cual tiene como objetivo realizar una solicitud GET a la URL indicada, para obtener 
    #la informaciond de dicha URL 
    soup = BeautifulSoup(response.content,)
    #se declara la variable soup, que contiene BeautifulSoup, siendo esta libreria la que extrae los datos de la web.
    #response.content es el contenido obtenido de la web

    #se declara el valor a buscar en el HTML
    pulsaciones = (soup.find(id = "Pulsaciones").text)
    #se declara la variable pulsacion, la cual utilizando la libreria soup le pide que busque en el HTML extraido, la id "Pulsaciones"
    #que en el HTML, esta es el dato extraido de la base de datos.
    pulsaciones = pulsaciones.replace("BPM", "")
    pulsaciones = pulsaciones.replace("\n", "")
    pulsaciones = pulsaciones.replace(" ", "")

    pulsaciones = float(pulsaciones)
    #Esta variable es importante, ya que el dato extraido del HTML, es un string(cadena). pero para una funcion futura, se necesita que los valores
    #numericos sean tomados como numeros y no como una cadena de texto.

    temperatura = (soup.find(id = "temperatura").text)
    temperatura = temperatura.replace("°c", "")
    temperatura = temperatura.replace("\n","")
    temperatura = temperatura.replace(" ", "")

    temperatura = round(float(temperatura), 2 ) 

    oxigeno = (soup.find(id= "oxigenacion").text)
    oxigeno = oxigeno.replace ("%", "")
    oxigeno = oxigeno.replace ("\n", "")
    oxigeno = oxigeno.replace (" ", "")

    oxigeno = float(oxigeno)

    movimiento = soup.find(id = "movimiento").text
    movimiento = movimiento.replace ("\n", "")
    movimiento = movimiento.replace (" ", "")

    return pulsaciones, temperatura, oxigeno, movimiento
    #return, se utiliza para luego, en el caso de que la funcion check website sea llamada. Esta, responde con lo devuelto por el return
    #en este caso, pulsaciones, temperatura, oxigeno, movimiento

################################################################################################################################################
################################################################################################################################################
################################################################################################################################################

def send_alertas(pulsaciones, temperatura, oxigeno, movimiento):
    #se declara la funcion send alertas, que recibe los datos returneados de la funcion check website 
    for key, value in valores_esperados.items():
        #el bucle for key, itera los valores del diccionario "valores esperados"
        if key == "Pulsaciones" and not (value[0] <= pulsaciones <= value[1]):
            #si la key, es igual a pulsaciones y el valor no es entre 0 (seria el primer valor dado y 1 (el segundo valor) entonces : )
            send_telegram_alert(f"Alerta: Valor de pulsaciones fuera de rango {pulsaciones} BPM")
            #manda una alerta con el mensaje "Alerta: Valor de pulsaciones fuera de rango y luego con {pulsaciones} se muestra el valor"
        elif key == "temperatura" and not (value[0] <= temperatura <= value[1]):
            send_telegram_alert(f"Alerta: Valor de temperatura fuera de rango {temperatura} °c")
        elif key == "oxigeno" and not (value[0] <= oxigeno <= value[1]):
            send_telegram_alert(f"Alerta: Valor de oxígeno fuera de rango {oxigeno} %")
        elif key == "movimiento" and movimiento != "Noocurrioningunaanormalidad":
            send_telegram_alert(f"Alerta: Estado de movimiento anormal")

    return pulsaciones, oxigeno, temperatura, movimiento

def send_telegram_alert(message):
    #se declara la funcion send telegram alert
    chat_id = '6186765051'
    #'5819988713'
    #la variable chat_id contiene nuestra id de usuario de telegram 
    bot.send_message(chat_id, message)
    #la funcion bot de la libreria telebot, envia el mensaje.

################################################################################################################################################
################################################################################################################################################
################################################################################################################################################

def bot_commands():
    #se define la funcion bot commands la cual contiene todos los comandos creados por nosotros 
    @bot.message_handler(commands=['ayuda'])
    #se utiliza un comando de telebot, el cual reacciona a cuando la persona escribe /ayuda en telegram
    def send_welcome(message):
        #se declara la funcion send_welcome
        bot.reply_to(message,
    """
    _Lista de comandos:_

/misalud - Chequea tu estado actual.

/recomendado - Indica los valores estandar de pulso, oxigeno en sangre y temperatura esperados para una persona.

/emergencias - Numeros de telefono auxiliares en caso de urgencia.


    """,
                    parse_mode='Markdown')
        #se utiliza bot.reply_to, para ingresar lo que le va a aparecer a la persona cuando escriba /ayuda, en este caso la lista de comandos
        #a su vez, parse_mode = 'marldown' se utiliza para que se puedan utilizar funciones markdown ** negrita __ italica, etc.


    @bot.message_handler(commands=['misalud'])
    def send_welcome(message):
        pulsaciones, oxigeno, temperatura, movimiento = check_website()
        bot.reply_to(message, f"""Tu estado actual es: 
({pulsaciones}) BPM
({oxigeno}) % oxigeno en sangre 
({temperatura}) °c""")


    @bot.message_handler(commands=['recomendado'])
    def send_welcome(message):
        bot.reply_to(message,
    """
    _Los valores esperados para una persona son:_

    *Pulsos:* Una frecuencia cardíaca en reposo normal para los adultos oscila entre 60 y 100 latidos por minuto.

    *Oxigeno:* Una oxigenacion estandar varia entre los 96 y 100 %.

    *Temperatura:*  Una temperatura moderada es entre 34 y 37 Grados. 

    Si alguno de estos parametros no concuerdan con su estado actual de salud, es recomendable visitar a un medico. 
    """,
                    parse_mode='Markdown')

    @bot.message_handler(commands=['emergencias'])
    def send_welcome(message):
        bot.reply_to(message, 
    """
    *En caso de emergencias, comuniquese con estos números:*

    *107* - Linea de emergencias médicas

    *100* - Bomberos

    *911* - Central de emergencias nacional 

    """,
                    parse_mode='Markdown')

    @bot.message_handler(func=lambda message: True)
    def echo_all(message):
        bot.reply_to(message, "No te entiendo, intenta escribiendo /ayuda para ver los comandos que puedes utilizar.")
        #todo este comando es para cuando alguien escribe cualquier cosa que no sean los comandos declarados, le aparezca un mensaje 
        #indicandole que comando tiene que escribir para que el bot pueda ayudar

    bot.infinity_polling()
    #el bot constantemente espera una respuesta del usuario, o sea, funciona siempre los comandos


def alertas():
    #se declara la funcion alerta la cual contiene check website y send alertas. todo adentro de un while, que hace esa funcion constantemente
    #con un descanso de 5 segundos
    while True:
        pulsaciones, temperatura, oxigeno, movimiento = check_website()
        send_alertas(pulsaciones, temperatura, oxigeno, movimiento)
        time.sleep (5)

t1 = threading.Thread(target=bot_commands)
#se crean las variables t1 y t2 las cuales contienen un thread, o sea un hilo, para que funcionen muchas funciones al mismo tiempo.
t2 = threading.Thread(target=alertas)

t1.start()
#se les pide a t1 y t2 que empiecen a funcionar. 
t2.start()


