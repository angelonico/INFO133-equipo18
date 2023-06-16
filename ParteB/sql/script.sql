CREATE DATABASE informacion_nacional2;

USE informacion_nacional2;

CREATE TABLE pais (
    codigo_pais VARCHAR(3) PRIMARY KEY,
    nombre_pais VARCHAR(50)
);

CREATE TABLE region (
    codigo_region INT(3) PRIMARY KEY,
    nombre_region VARCHAR(50),
    codigo_pais VARCHAR(3),
    CONSTRAINT fk_pais_region FOREIGN KEY (codigo_pais) REFERENCES pais (codigo_pais)
);

CREATE TABLE comuna (
    codigo_comuna INT(5) PRIMARY KEY,
    nombre_comuna VARCHAR(50),
    numero_habitantes INT(7),
    codigo_region INT(3),
    CONSTRAINT fk_region_comuna FOREIGN KEY (codigo_region) REFERENCES region (codigo_region)
);

CREATE TABLE centro_salud (
    id_centro_salud INT(4) PRIMARY KEY,
    nombre_ce_sa INT(5),
    direccion VARCHAR(50),
    telefono INT(14),
    codigo_comuna INT(5),
    CONSTRAINT fk_comuna_centro_salud FOREIGN KEY (codigo_comuna) REFERENCES comuna (codigo_comuna)
);

CREATE TABLE poblacion (
    id_pobla INT(3) PRIMARY KEY,
    total_viviendas INT(7),
    viviendas_inhabitadas INT(7),
    codigo_comuna INT(5),
    CONSTRAINT fk_comuna_poblacion FOREIGN KEY (codigo_comuna) REFERENCES comuna (codigo_comuna)
);

CREATE TABLE institucion_educacional (
    id_institucion INT(5) PRIMARY KEY,
    nombre_institucion VARCHAR(50),
    matriculados INT(6),
    codigo_comuna INT(5),
    CONSTRAINT fk_comuna_institucion_educacional FOREIGN KEY (codigo_comuna) REFERENCES comuna (codigo_comuna)
);

CREATE TABLE grupo_etario (
    id_grupo INT(4) PRIMARY KEY,
    rango VARCHAR(7),
    cant_h INT(7),
    cant_m INT(7),
    id_pobla INT(3),
    CONSTRAINT fk_poblacion_grupo_etario FOREIGN KEY (id_pobla) REFERENCES poblacion (id_pobla)
);

CREATE TABLE seguridad (
    id_seguridad INT(2) PRIMARY KEY,
    detenciones VARCHAR(7),
    denuncias INT(7),
    codigo_comuna INT(5),
    CONSTRAINT fk_comuna_seguridad FOREIGN KEY (codigo_comuna) REFERENCES comuna (codigo_comuna)
);