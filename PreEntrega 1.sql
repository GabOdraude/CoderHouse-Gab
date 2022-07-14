-- Pre Entrega 1 
-- Gabino González

-- ------------ Creación de Base de Datos ------------ --
CREATE SCHEMA IF NOT EXISTS Modelo_Tienda_Celulares;
USE Modelo_Tienda_Celulares;

-- ------------ Creación de tablas ------------ --
-- Tabla Cliente
CREATE TABLE IF NOT EXISTS Cliente(
	ID_Cliente  int           not null auto_increment  primary key, -- (PK)
    Nombre      varchar (50)  not null,
    Dirección   varchar (50)  not null,
	ID_Celular  int           not null,                             -- (FK)
    ID_Contrato int           not null,
    Antiguedad  tinyint       not null,
    Genero      varchar (50)  not null,
    Edad        tinyint       not null
)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Celulares
CREATE TABLE IF NOT EXISTS Celulares(
	ID_Celular  int           not null auto_increment   primary key, -- (PK)
    Marca       varchar (50)  not null,
    Año         date          not null,
	ID_Camara   int           not null,                              -- (FK)
    Memoria     int           not null,
    RAM_MB      smallint      not null,
    Dimensiones varchar (50)  not null,
    Costo       float4        not null,
    ID_Servicio int           not null,                               -- (FK)
	key ID_Celular (ID_Celular)
    -- CONSTRAINT `celulares_ibfk_1` FOREIGN KEY (`ID_Celular`) REFERENCES Cliente (`ID_Celular`)
)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Camara
CREATE TABLE IF NOT EXISTS Camara(
	ID_Camara     int          not null auto_increment   primary key, -- (PK)
    Nombre        varchar (50) not null,
    Marca         varchar (50) not null,
	Tipo_Lente    varchar (50) not null,
    Materiales    varchar (50) not null,
    Pixeles_MP    tinyInt      not null,
    Dimensiones   varchar (50) not null,
    Compatiblidad varchar (50) not null
)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla Servicio Red
CREATE TABLE IF NOT EXISTS Servicio_Red(
	ID_Servicio   int          not null auto_increment   primary key, -- (PK)
    Nombre        varchar (50) not null,
    Compañia      varchar (50) not null,
	Tipo_Servicio varchar (50) not null,
    Cant_Datos_MB smallint     not null,
    Num_Contacto  int          not null
)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;