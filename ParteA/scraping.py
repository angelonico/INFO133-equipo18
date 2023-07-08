import mysql.connector as mariadb
import sys
from requests_html import HTMLSession
import random
import requests

def format_date(date):
        return(date.split("T")[0])

session = HTMLSession()

## Simular que estamos utilizando un navegador web
USER_AGENT_LIST = [
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1",
        "Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6",
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6",
        "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/19.77.34.5 Safari/537.1",
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5",
        "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
        "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3",
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24",
        "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"
]
headers = {'user-agent':random.choice(USER_AGENT_LIST) }


# Connect to MariaDB
try:
    conn = mariadb.connect(
        user="root",
        password="352616",
        host="localhost",
        #port=3306
    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

cur = conn.cursor() # Selecciona cursor

cur.execute("USE medios_prensa")

#Begin
print("Conexion exitosa!")

# Pregunta al usuario por la informacion
name=input("Esciba el nombe del medio de prensa: ")
URL=input("Escriba la URL de una noticia del medio: ")

# La idea es obtener los xpath del ejemplo de noticia del medio, para obtener la informacion del link solicitado

# Obtiene id del medio
cur.execute("SELECT id_medio FROM medio_prensa WHERE nombre='"+name+"'")
id_medio=cur.fetchall()

# Obtiene los XPATH
try:
    cur.execute("SELECT xpath_titulo,xpath_fecha FROM ejemplo_noticia WHERE id_medio="+str(id_medio[0][0]))
    XPATHS=cur.fetchall()
except IndexError:
    print("El medio no existe")
    sys.exit(0)

response = session.get(URL,headers=headers)

title = response.html.xpath(XPATHS[0][0])[0].text
print(title)
date = response.html.xpath(XPATHS[0][1])[0]
print(date)
print(format_date(date))


conn.commit() # Guarda cambios

conn.close() # Cierra conexion