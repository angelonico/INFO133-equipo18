CREATE DATABASE medios_prensa;

USE medios_prensa;

CREATE TABLE ubicacion (
	id_ubicacion INT(3) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	continente VARCHAR(10),
	pais VARCHAR(20),
	region VARCHAR(30),
	ciudad VARCHAR(30)
);

CREATE TABLE fundador (
	rut INT(9) PRIMARY KEY,
	nombre_fundador VARCHAR(150)
);

CREATE TABLE medio_prensa (
	id_medio INT(3) AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(200),
	sitio_web VARCHAR(250),
	cobertura VARCHAR(14),
	anio_fundacion DATE,
	id_ubicacion INT(3),
	FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_ubicacion)
);

CREATE TABLE crear (
	id_medio INT(3),
	rut INT(9),
	FOREIGN KEY (id_medio) REFERENCES medio_prensa(id_medio),
	FOREIGN KEY (rut) REFERENCES fundador(rut)
);

CREATE TABLE ejemplo_noticia (
	url VARCHAR(300) PRIMARY KEY,
	xpath_titulo VARCHAR(300),
	xpath_fecha VARCHAR(300),
	xpath_contenido VARCHAR(300),
	id_medio INT(3),
	FOREIGN KEY (id_medio) REFERENCES medio_prensa(id_medio)
);

CREATE TABLE categoria (
	id_categoria INT(3) PRIMARY KEY AUTO_INCREMENT,
	nombre_categoria VARCHAR(30),
	url_categoria VARCHAR(250),
	url_ejemplo VARCHAR(250),
	xpath VARCHAR(250),
	id_medio INT(3),
	FOREIGN KEY (id_medio) REFERENCES medio_prensa(id_medio)
);

CREATE TABLE RRSS (
	nombre_RRSS VARCHAR(50),
	nombre_cuenta VARCHAR(50),
	seguidores INT(8),
	ultima_act DATE,
	id_medio INT(3),
	PRIMARY KEY (nombre_RRSS, nombre_cuenta),
	FOREIGN KEY (id_medio) REFERENCES medio_prensa(id_medio)
);

