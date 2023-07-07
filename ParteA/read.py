import mysql.connector as mariadb
import sys

def selecciona(): #Consulta al usuario por una opcion
    return int(input("""Seleciona la consulta a realizar, escribiendo el numero de la opcion:
    1. Muestrar los nombres de los medios de prensa guardados.
    2.
    3.
    4.
    5.
    
    """))

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

#Begin
print("Conexion exitosa!")

seleccion=selecciona() # Obtiene eleccion de usuario

cur.execute("USE medios_prensa")

if(seleccion==1):
    cur.execute("""select nombre from medio_prensa""") # Realiza consulta

info=cur.fetchall() # Captura las consultas
for i in info:
    print(i[0])

conn.commit() # Guarda cambios

conn.close() # Cierra conexion