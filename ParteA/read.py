import mysql.connector as mariadb
import sys

def selecciona(): #Consulta al usuario por una opcion
    return int(input("""Seleciona la consulta a realizar, escribiendo el numero de la opcion:
    1. Mostrar los nombres de los medios de prensa guardados.
    2. Mostrar url del sitio web del medio Primera Plana
    3. Retorna el XPATH para leer el contenido de Guana Noticias
    4. Mostrar redes sociales de The Tico Times
    5. Mostrar categorias de The Couch  
    
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
elif(seleccion==2):
    cur.execute("select sitio_web from medio_prensa where nombre='Primera Plana'")
elif(seleccion==3):
    cur.execute("select xpath_contenido from ejemplo_noticia where id_medio=7")
elif(seleccion==4):
    cur.execute("select nombre_RRSS,nombre_cuenta from RRSS where id_medio=3")
elif(seleccion==5):
    cur.execute("select nombre_categoria from categoria where id_medio=2")

info=cur.fetchall() # Captura las consultas
if(seleccion==4):
    for i in info:
        print("Nombre cuenta:",i[1],";Red Social:",i[0])
elif(seleccion>5 or seleccion<1):
    print("Opcion no valida")
else:
    for i in info:
        print(i[0])

conn.close() # Cierra conexion