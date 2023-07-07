import mysql.connector as mariadb
import sys

# Indica si en la posicion se espera un int (False) o string (True)
fundadorB=[False,True]
medioB=[True,True,True,True]
rrssB=[True,True,False,True]


# Recibe la entrada
def recibe(lista,texto):
    entrada=input(texto)
    separado=entrada.split(sep=',') # Separa por ','
    return limpia(lista,separado,texto)
    
# Limpia la entrada
def limpia(lista,palabra,texto):
    for i in range(len(palabra)):
        palabra[i]=palabra[i].strip() # Elimina espacios iniciales y finales
        if(lista[i]): # Agrega ' ' en caso de ser string
            palabra[i]="'"+palabra[i]+"'"
    return palabra

# Conecta a mariaDB
try:
    conn = mariadb.connect(
        user="root",
        password="...",
        host="localhost",
        #port=3306
    )

except mariadb.Error as e:
    print(f"Error: {e}")
    sys.exit(1)

# Obtiene cursor
cur = conn.cursor()
print("Conexion exitosa!")

cur.execute("USE medios_prensa")

# Ingreso de datos
print("A continuacion ingresa los siguientes datos")
medio=recibe(medioB,"Para la tabla medio prensa [Formato: nombre, sitio web, cobertura, año de fundacion]:\n")
fundador=recibe(fundadorB,"Para la tabla fundador [Formato: rut, nombre del fundador]:\n")
ubicacion=recibe(medioB,"Para la tabla ubicacion [Formato: continente, pais, region, ciudad]:\n")
ejemplo_noticia=recibe(medioB,"Para la tabla ejemplo noticia [Formato: url, xpath de titulo, xpath de fecha, xpath de contenido]:\n")
categoria=recibe(medioB,"Para la tabla categoria [Formato:nombre de categoria, url la categoria, url de ejemplo, xpath]:\n")
rrss=recibe(rrssB,"Para la tabla RRSS [Formato: nombre de RRSS, nombre de cuenta, seguidores, fecha de actualizacion]:\n")

# Inserta datos en ubicacion y fundador
cur.execute("INSERT INTO ubicacion (id_ubicacion,continente,pais,region,ciudad) VALUES (NULL,"+ubicacion[0]+","+ubicacion[1]+","+ubicacion[2]+","+ubicacion[3]+")")
cur.execute("INSERT INTO fundador (rut,nombre_fundador) VALUES ("+fundador[0]+","+fundador[1]+")")

# Obtiene id ubicacion para pasarlo a medio
cur.execute("SELECT id_ubicacion FROM ubicacion WHERE continente="+ubicacion[0]+" AND pais="+ubicacion[1]+" AND region="+ubicacion[2]+" AND ciudad="+ubicacion[3])
id_ubicacion=cur.fetchall()
id_ubicacion=str(id_ubicacion[0][0])

# Inserta en medio_prensa
cur.execute("INSERT INTO medio_prensa (id_medio,nombre,sitio_web,cobertura,anio_fundacion,id_ubicacion) VALUES (NULL,"+medio[0]+","+medio[1]+","+medio[2]+","+medio[3]+","+id_ubicacion+")")

# Obtiene id_medio
cur.execute("SELECT id_medio FROM medio_prensa WHERE nombre="+medio[0]+" AND sitio_web="+medio[1]+" AND cobertura="+medio[2]+" AND anio_fundacion="+medio[3])
id_medio=cur.fetchall()
id_medio=str(id_medio[0][0])

# Inserta datos en Crear, ejemplo_noticia, categoria y RRSS respectivamente
cur.execute("INSERT INTO Crear (id_medio,rut) VALUES ("+id_medio+","+fundador[0]+")")
cur.execute("INSERT INTO ejemplo_noticia (url,xpath_titulo,xpath_fecha,xpath_contenido,id_medio) VALUES ("+ejemplo_noticia[0]+","+ejemplo_noticia[1]+","+ejemplo_noticia[2]+","+ejemplo_noticia[3]+","+id_medio+")")
cur.execute("INSERT INTO categoria (id_categoria,nombre_categoria,url_categoria,url_ejemplo,xpath,id_medio) VALUES (NULL,"+categoria[0]+","+categoria[1]+","+categoria[2]+","+categoria[3]+","+id_medio+")")
cur.execute("INSERT INTO RRSS (nombre_RRSS,nombre_cuenta,seguidores,ultima_act,id_medio) VALUES ("+rrss[0]+","+rrss[1]+","+rrss[2]+","+rrss[3]+","+id_medio+")")


conn.commit()
print("Nuevo medio insertado con exito!")
conn.close()
