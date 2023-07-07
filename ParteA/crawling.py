import mysql.connector
from mysql.connector import Error

# Función para establecer la conexión con la base de datos
def conectar_bd():
    try:
        conexion = mysql.connector.connect(
            host="localhost",
            database='medios_prensa',
            user="root",
            password="352616",
        )
        return conexion
    except Error as e:
        print("Error al conectar a la base de datos:", str(e))
        return None

# Función para obtener el FK_id_medio según el nombre del medio
def obtener_FK_id_medio(nombre_medio):
    try:
        conexion = conectar_bd()
        if not conexion:
            return None

        cursor = conexion.cursor()
        consulta = "SELECT id_medio FROM medio_prensa WHERE nombre = %s"
        cursor.execute(consulta, (nombre_medio,))
        resultado = cursor.fetchone()

        if resultado:
            return resultado[0]
        else:
            return None

    except Error as e:
        print("Error al obtener el FK_id_medio:", str(e))
        return None

    finally:
        if conexion:
            conexion.close()

# Función para obtener el PK_id_categoria y la URL de la categoría según el nombre de la categoría y el FK_id_medio
def obtener_PK_id_categoria_y_URL(nombre_categoria, FK_id_medio):
    try:
        conexion = conectar_bd()
        if not conexion:
            return None, None

        cursor = conexion.cursor()
        consulta = "SELECT id_categoria, url_categoria FROM categoria WHERE nombre_categoria = %s AND id_medio = %s"
        cursor.execute(consulta, (nombre_categoria, FK_id_medio))
        resultado = cursor.fetchone()

        if resultado:
            return resultado[0], resultado[1]
        else:
            return None, None

    except Error as e:
        print("Error al obtener el PK_id_categoria y la URL de la categoría:", str(e))
        return None, None

    finally:
        if conexion:
            conexion.close()

# Ejemplo de uso
nombre_medio = input("Ingrese nombre de medio: ")
nombre_categoria = input("Ingrese nombre categoria: ")
FK_id_medio = obtener_FK_id_medio(nombre_medio)
PK_id_categoria, url_categoria = obtener_PK_id_categoria_y_URL(nombre_categoria, FK_id_medio)

if not FK_id_medio:
    print("El medio especificado no existe en la base de datos.")
elif not PK_id_categoria or not url_categoria:
    print("La categoría especificada no existe para el medio especificado.")
else:
    print("FK_id_medio:", FK_id_medio)
    print("PK_id_categoria:", PK_id_categoria)
    print("URL de la categoría:", url_categoria)