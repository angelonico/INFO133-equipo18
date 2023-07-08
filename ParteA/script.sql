CREATE DATABASE medios_prensa;

USE medios_prensa;

CREATE TABLE ubicacion (
	id_ubicacion INT(3) AUTO_INCREMENT PRIMARY KEY,
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
	id_categoria INT(3) AUTO_INCREMENT PRIMARY KEY,
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

INSERT INTO ubicacion (id_ubicacion,continente,pais,region,ciudad) VALUES
(1,'America','Costa Rica','Region Central','San Jose'),
(2, 'America', 'Costa Rica', 'Chorotega', 'Nicoya');

INSERT INTO fundador (rut,nombre_fundador) VALUES
(11234567,'Marco Tulio Soto Castro');

INSERT INTO medio_prensa (id_medio,nombre,sitio_web,cobertura,anio_fundacion,id_ubicacion) VALUES
(1, 'La Teja','https://www.lateja.cr/','Nacional','1991-06-06',1),
(2, 'The Couch', 'https://thecouch.world', 'Internacional','2015-01-01',1),
(3, 'The Tico Times', 'https://ticotimes.net', 'Internacional', '1956-05-18', 1),
(4, 'Primera Plana', 'https://primeraplana.or.cr/es/', 'Nacional', NULL, 1),
(5, 'La Voz de Guanacaste', 'https://vozdeguanacaste.com', 'Internacional', NULL, 2),
(6, 'Guanacaste a la Altura', 'https://www.guanacastealaaltura.com', 'Nacional', NULL, 2),
(7, 'Guana Noticias', 'https://guananoticias.com', 'Nacional', '2017-12-05', 2);

INSERT INTO crear (id_medio,rut) VALUES
(1,11234567);


INSERT INTO ejemplo_noticia (url,xpath_titulo,xpath_fecha,xpath_contenido,id_medio) VALUES
('https://www.lateja.cr/sucesos/gatillero-se-mete-a-bar-y-asesina-de-varios/OZQ7RHS3F5CMLCM34NAHKPOL64/story/','//div//h1',"//time[@class='primary-font__PrimaryFontStyles-o56yd5-0 idKzkX date undefined']//@datetime",'/html/body/div[1]/section/div/div[2]/div/article/p',1),
('https://thecouch.world/across-the-spiderverse-y-la-superacion-de-una-barra-imposible/','//div//h1',"//meta[@property='article:published_time']//@content",NULL,2),
('https://ticotimes.net/2023/07/03/costa-ricas-tourism-sector-struggles-with-vat-increase','//div//h1',"//meta[@property='article:published_time']//@content","//div[@class='tdb-block-inner td-fix-index']/p",3),
('https://www.primeraplana.or.cr/es/Contorno/Publicistas_conversaron_sobre_el_impacto_de_la_IA/',"//div//h2",NULL,NULL,4),
('https://vozdeguanacaste.com/reconstruccion-sin-gimnasio-escuela-cacique-nicoa/', '//div//h1',"//meta[@property='article:published_time']//@content","//div[@class='entry-content']/p",5),
('https://www.guanacastealaaltura.com/centro-de-investigacion-y-desarrollo-de-semillas-de-bayer-celebra-25-aniversario/',NULL,NULL,NULL, 6),
('https://guananoticias.com/mas/tecnologia/sector-aeroportuario-tecnologia-e-innovacion-para-la-eficiencia-operativa/','//div/h1', "//meta[@property='article:published_time']//@content", "//div[@id='mvp-content-main']/p", 7);

INSERT INTO categoria (id_categoria,nombre_categoria,url_categoria,url_ejemplo,xpath,id_medio) VALUES
(1,'Deportes','https://www.lateja.cr/deportes/','https://www.lateja.cr/deportes/que-falta-de-respeto-medio-mexicano-escribe-mal/J2ZPCI4TPRCMJG2I6ZPXL5534U/story/','xpath',1),
(2,'Cine & TV','https://thecouch.world/category/cine-tv/','https://thecouch.world/feliz-4-de-mayo-fans-de-star-wars/','xpath',2),
(3,'Videojuegos','https://thecouch.world/category/videojuegos/','https://thecouch.world/feliz-4-de-mayo-fans-de-star-wars/','xpath',2),
(4,'Libros & Comics', 'https://thecouch.world/category/libros-y-comics/','https://thecouch.world/resena-de-hogwarts-legacy-sin-spoilers-un-juego-magicamente-atrapante/','xpath',2),
(5, 'Arte & Cultura', 'https://ticotimes.net/categories/arts-culture', 'https://ticotimes.net/2023/02/05/bad-bunny-and-anitta-add-latin-touch-to-the-grammys','xpath', 3),
(6, 'Deportes', 'https://ticotimes.net/categories/sport', 'https://ticotimes.net/2023/07/07/costa-rica-vs-mexico-a-historic-rivalry-continues', 'xpath', 3),
(7, 'Viajes', 'https://ticotimes.net/categories/topics/travel', 'https://ticotimes.net/2023/07/01/why-visit-costa-ricas-barra-honda-national-park', 'xpath', 3),
(8, 'Actualidad', 'https://www.primeraplana.or.cr/es/Actualidad/', 'https://www.primeraplana.or.cr/es/Actualidad/Colper_avanza_en_construccion_de_nuevo_codigo_de_etica/', 'xpath', 4),
(9, 'Opinion', 'https://www.primeraplana.or.cr/es/Opinion/', 'https://www.primeraplana.or.cr/es/Opinión/Debe_haber_un_plan_nacional_de_lucha_contra_la_desinformacion_y_la_violencia_digital/', 'xpath', 4),
(10, 'Cultura', 'https://www.primeraplana.or.cr/es/Trazos/', 'https://www.primeraplana.or.cr/es/Trazos/125_poemas_por_y_para_las_mujeres/', 'xpath', 4),
(11, 'Derechos Humanos', 'https://vozdeguanacaste.com/category/derechos-humanos/','https://vozdeguanacaste.com/costa-rica-albergue-periodismo-centroamericano/','xpath', 5),
(12, 'Medio Ambiente', 'https://vozdeguanacaste.com/category/naturaleza/', 'https://vozdeguanacaste.com/bosque-guanacaste-donde-nace-el-agua/', 'xpath', 5),
(13, 'La Provincia', 'https://www.guanacastealaaltura.com/la-provincia/', 'https://www.guanacastealaaltura.com/este-lunes-inicia-ejecucion-de-la-estrategia-ifam-infinito/', 'xpath', 6),
(14, 'El Pais', 'https://www.guanacastealaaltura.com/el-pais/', 'https://www.guanacastealaaltura.com/costa-rica-y-paises-del-cmar-reciben-16-millones-del-fondo-mundial-para-el-medio-ambiente/', 'xpath', 6),
(15, 'Politica', 'https://guananoticias.com/category/politica/', 'https://guananoticias.com/politica/presidente-rodrigo-chaves-ocupa-el-cuarto-lugar-de-popularidad-a-nivel-mundial-segun-encuesta/', 'xpath', 7),
(16, 'Salud', 'https://guananoticias.com/category/salud/', 'https://guananoticias.com/salud/polemica-por-traslado-de-plaza-de-hospital-de-puntarenas-a-san-jose-para-nombrar-a-joselyn-chacon/', 'xpath', 7);

INSERT INTO RRSS (nombre_RRSS,nombre_cuenta,seguidores,ultima_act,id_medio) VALUES
('Facebook','latejaoficial',662000,'2023-04-07',1),
('Instagram','latejacr',106000,'2023-05-07',1),
('Facebook', 'The Couch', 99000,'2023-07-07',2),
('Instagram','thecouchcr',6604,'2023-07-07',2),
('Twitter', 'The Couch', 716, '2023-07-07',2),
('Facebook','The Tico Times',127000,'2023-07-07',3),
('Twitter', 'TheTicoTimes', 35100, '2023-07-07',3),
('Instagram','theticotimes',22000,'2023-07-07',3),
('Facebook','La Voz de Guanacaste',63000,'2023-07-07',5),
('Twitter', 'VozdeGuanacaste', 8458, '2023-07-07',5),
('Instagram','vozdeguanacaste',18400,'2023-07-07',5),
('Twitter', 'PeriodicoGALA', 289, '2023-07-07',6),
('Facebook', 'Guana/Noticias.com', 289000, '2023-07-07', 7),
('Twitter', 'guananoticias', 161, '2023-07-07', 7),
('Instagram', 'guananoticias', 18600, '2023-07-07', 7);