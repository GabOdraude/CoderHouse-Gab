-- PreEntrega 2
-- Gabino González

-- ---------------------- Creación de Base de Datos ----------------------- --
-- DROP SCHEMA Modelo_Tienda_Celulares;
CREATE SCHEMA IF NOT EXISTS Modelo_Tienda_Celulares;
USE Modelo_Tienda_Celulares;

-- ------------------------- Creación de tablas ------------------------ --
-- --- Tabla Cliente ---
CREATE TABLE IF NOT EXISTS Cliente(
	ID_Cliente  int           not null auto_increment  primary key, -- (PK)
    Nombre      varchar (50)  not null,
    Direccion   varchar (50)  not null,
	ID_Celular  int           not null,                             -- (FK)
    ID_Contrato int           not null,
    Antiguedad  tinyint       not null,
    Genero      varchar (50)  not null,
    Edad        tinyint       not null
);

-- --- Tabla Celulares --- --
CREATE TABLE IF NOT EXISTS Celulares(
	ID_Celular  int           not null auto_increment   primary key, -- (PK)
    Marca       varchar (50)  not null,
    Año         date          not null,
	ID_Camara   int           not null,                              -- (FK)
    Memoria     int           not null,
    RAM_GB      smallint      not null,
    Dimensiones varchar (50)  not null,
    Costo       float4        not null,
    ID_Servicio int           not null                               -- (FK)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --- Tabla Camara --- --
CREATE TABLE IF NOT EXISTS Camara(
	ID_Camara     int          not null auto_increment   primary key, -- (PK)
    Nombre        varchar (50) not null,
    Marca         varchar (50) not null,
	Tipo_Lente    varchar (50) not null,
    Materiales    varchar (50) not null,
    Pixeles_MP    tinyInt      not null,
    Dimensiones   varchar (50) not null,
    Compatiblidad varchar (50) not null
    -- foreign key(ID_Camara) references Celulares(ID_Camara)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --- Tabla Servicio Red --- --
CREATE TABLE IF NOT EXISTS Servicio_Red(
	ID_Servicio   int          not null auto_increment   primary key, -- (PK)
    Nombre        varchar (50) not null,
    Compañia      varchar (50) not null,
	Tipo_Servicio varchar (50) not null,
    Cant_Datos_GB smallint     not null,
    Num_Contacto  int          not null
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ------------------------- Inserción de Datos ------------------------ --
-- ------ Tabla Cliente ------ --
INSERT INTO Cliente (ID_Cliente,Nombre,Direccion,ID_Celular,ID_Contrato,Antiguedad,Genero,Edad)
VALUES 	(1,'Julian Rojas','Bazar 1001',55445,20511,5,'Hombre',21), 
		(2,'Luz Gonzalez','Bazar 1002',55436,20522,6,'Mujer',22),
		(3,'John Casares','Bazar 1003',55437,20533,7,'Hombre',23),
		(4,'Natalia Cruz','Bazar 1004',55438,20544,8,'Mujer',24),
		(5,'Juan Espinos','Bazar 1005',55439,20555,9,'Hombre',25);
-- select * from Cliente;

-- ------ Tabla Celulares ------ --
INSERT INTO Celulares (ID_Celular,Marca,Año,ID_Camara,Memoria,RAM_GB,Dimensiones,Costo,ID_Servicio)
VALUES 	(55445,'Samsung','1997-11-11',1001,128,2,'12mm x 140mm',3200,201),
		(55436,'Xiaomi ','2020-11-11',1002,256,3,'11mm x 141mm',2600,202),
		(55437,'Honor  ','2021-11-11',1003,512,2,'12mm x 142mm',4000,203),
		(55438,'Xperia ','2022-11-11',1004,128,4,'11mm x 143mm',5125,204),
		(55439,'BlackBe','2023-11-11',1005,256,6,'12mm x 144mm',3000,205);
-- select * from Celulares;

-- ------ Tabla Camara ------ --
INSERT INTO Camara (ID_Camara,Nombre,Marca,Tipo_Lente,Materiales,Pixeles_MP,Dimensiones,Compatiblidad)
VALUES 	(1001,'Camara 1','KAM01','Oscuro','Plastico',12,'1.1mm x 0.82mm','Buena'),
		(1002,'Camara 2','KAM02','Blanco','Cristali',10,'1.1mm x 0.78mm','Neutra'),
		(1003,'Camara 3','KAM03','Oscuro','Plastico',18,'1.1mm x 0.81mm','Buena'),
		(1004,'Camara 4','KAM04','Bluero','Cristali',10,'1.1mm x 0.82mm','Neutra'),
		(1005,'Camara 5','KAM05','Transp','Plastico',21,'1.1mm x 0.83mm','Buena');
-- select * from Camara;

-- ------ Tabla Servicio Red ------ --
INSERT INTO Servicio_Red (ID_Servicio,Nombre,Compañia,Tipo_Servicio,Cant_Datos_GB,Num_Contacto)
VALUES 	(201,'Plan Telcel 1000','Telcel','Todo Incluido',4,201),
		(202,'Plan Telcel 2000','Telcel','Todo Incluido',8,202),
		(203,'Plan Movistar 10','MoviSt','Todo Incluido',6,203),
		(204,'Plan Movistar 20','MoviSt','Todo Incluido',8,204),
		(205,'Plan Telcel 3000','Telcel','Todo Incluido',8,205);
-- select * from Servicio_Red;

-- ---------------------- Vistas de Modelo Tiendas Celulares --------------------- --
-- Vista 1: Muestra el conteo de Genero de clientes
create or replace view vw_Genero_Conteo as 
(select Genero, count(*) from cliente
 group by Genero
);
-- select * from vw_Genero_Conteo;

-- Vista 2: Muestra el ID del celular y su costo
create or replace view vw_Celular_Costo as 
(select ID_Celular, Costo from Celulares
 order by costo desc
);
-- select * from vw_Celular_Costo;

-- Vista 3: Muestra las Cámaras, su marca y sus características
create or replace view vw_Camara_Caracteristicas as 
(select Nombre, Marca, concat(Tipo_Lente,' y ',Materiales) as Caracteristicas from Camara
 order by Nombre asc
);
-- select * from vw_Camara_Caracteristicas;

-- Vista 4: Muestra el Nombre del Plan de Datos, su compañia y el servicio incluido
create or replace view vw_Servicio_Datos as 
(select Nombre, Compañia, concat(Tipo_Servicio,' con ',Cant_Datos_GB,' GB') as Servicio from Servicio_Red
 order by Nombre asc
);
-- select * from vw_Servicio_Datos;

-- Vista 5: Muestra el nombre, edad y el celular correspondiente a cada cliente (join de dos tablas)
create or replace view vw_Cliente_Celular_Propio as 
(select A.Nombre, A.Edad, concat('ID Celular: ',B.ID_Celular,' de Marca ',B.Marca) as Celular_Propio 
	from Cliente as A join Celulares as B
    on A.ID_Celular = B.ID_Celular
	order by A.Nombre asc
);
-- select * from vw_Cliente_Celular_Propio;

-- --------------------- Funciones de Modelo Tiendas Celulares --------------------- --
-- Función 1: Conteo de Servicios de Telefonia que cuenten con un plan de Cantidad de Datos y cuya cantidad sea la que el cliente busca
drop function if exists fn_Exploracion_Cant_Datos_Cliente;
delimiter //
CREATE FUNCTION fn_Exploracion_Cant_Datos_Cliente(Cantidad int)
RETURNS CHAR(50)
DETERMINISTIC                                      -- Tipo de la función 
Begin											   -- Empieza código SQL
declare Contador int;
select COUNT(*) into Contador from Servicio_Red where (Cant_Datos_GB = Cantidad);
Return CONCAT('Hay ',Contador,' Servicio(s) con la Cantidad de GB que buscas');  -- Regresa un valor 
End // delimiter ;                   -- Fin del delimitador
-- select fn_Exploracion_Cant_Datos_Cliente(8) as Servicios_con_la_Cantidad;

-- Función 2: Encuentra un cliente rastreando el ID de su celular, Primero se hace el select en la Tabla celular y con el resultado se busca en la Tabla Cliente.
drop function if exists fn_EncontrarCliente_porsu_ID_Celular ;
delimiter //
CREATE FUNCTION fn_EncontrarCliente_porsu_ID_Celular(ID int)
RETURNS CHAR(50)
DETERMINISTIC
Begin
declare Cli_Encontrado int;
set Cli_Encontrado = (select(ID_Celular) from Cliente where ID_Celular = (select(ID_Celular) from Celulares where ID_Celular = ID));
Return Cli_Encontrado;
End // delimiter ;
-- select fn_EncontrarCliente_porsu_ID_Celular(55445) as Cliente_Encontrado;

-- Función 3: Conteo de ID de Celulares
drop function if exists fn_Conteo_ID_Celulares ;
delimiter //
CREATE FUNCTION fn_Conteo_ID_Celulares()
RETURNS CHAR(50)
DETERMINISTIC                    -- tipo de la función 
begin
declare Conteo int;
select COUNT(*) into Conteo from Celulares;
Return CONCAT('Hay ',Conteo,' IDs de Celulares');  -- Regresa un valor 
End // delimiter ;                   -- Fin del delimitador
-- select fn_Conteo_ID_Celulares() as Numero_de_IDs;

-- --------------------- Store Procedures --------------------- --
-- SP 1 = Parámetro 1: Campo de ordenamiento, Parámetro 2: Asc o Desc
drop procedure if exists sp_Ordenar_Campo;
DELIMITER $$
CREATE PROCEDURE sp_Ordenar_Campo(INOUT Orden_Campo VARCHAR(32), INOUT Asc_Desc VARCHAR(32))
BEGIN
	SET @E1 =  CONCAT('select * from Cliente Order by ',Orden_Campo,' ',Asc_Desc);  -- Creamos código para ordenar por un campo y si este es asc o desc
	PREPARE param FROM @E1;
	EXECUTE param;  
	DEALLOCATE PREPARE param;
END $$ DELIMITER ;
/*
SET @Orden_Campo = 'Nombre';   -- Asignamos valor al Primer  parámetro
SET @Asc_Desc    = 'asc';      -- Asignamos valor al Segundo parámetro
call sp_Ordenar_Campo(@Orden_Campo, @Asc_Desc); -- Llamar al Store Procedure
*/

-- SP 2 = Eliminar registro de un Cliente
drop procedure if exists sp_Eliminar_Cliente;
DELIMITER $$
CREATE PROCEDURE sp_Eliminar_Cliente(INOUT Eli_Cliente VARCHAR(32))
BEGIN
	SET @E2 =  CONCAT('Delete from Cliente Where ID_Cliente = ',Eli_Cliente);   -- Creamos código para eliminar registro
	PREPARE param FROM @E2;
	EXECUTE param;  
	DEALLOCATE PREPARE param;
END $$ DELIMITER ;
/*
SET @Eli_Cliente = 1;                     -- Asignamos valor al Unico parámetro
select * from Cliente;                    -- Antes del SP
call sp_Eliminar_Cliente(@Eli_Cliente); -- Llamar al Store Procedure
select * from Cliente;                    -- Después del SP
*/

-- --------------------- Triggers --------------------- --
-- Tabla Auditora 1: Se registran los nuevos Insert de la Tabla Cliente
drop table if  exists Log_Cliente_Auditora;
CREATE TABLE IF NOT EXISTS Log_Cliente_Auditora
(
ID_Log          INT AUTO_INCREMENT,      -- pk de la tabla 
Nombre_Accion   VARCHAR(10),             -- Irá si es insert, update y/o delete
Nombre_Tabla    VARCHAR(50),             -- Tablas anteriormente creadas en el proyecto
Usuario         VARCHAR(100),            -- quien ejecuta la sentencia DML
Fecha_IUD       DATE,                    -- momento exacto en el que se genera DML
PRIMARY KEY (ID_LOG)
);

-- Tabla Auditora 2
drop table if  exists Log_Cliente_Auditora_2;
CREATE TABLE IF NOT EXISTS Log_Cliente_Auditora_2
(
ID_Log          INT AUTO_INCREMENT,      -- pk de la tabla
Viejo_Cliente   VARCHAR(50),             -- Viejo Cliente antes de Actualizar
Nuevo_Cliente   VARCHAR(50),             -- Nuevo Cliente después de Actualizar
Nombre_Accion   VARCHAR(10),             -- Irá si es insert, update y/o delete
Nombre_Tabla    VARCHAR(50),             -- Tablas anteriormente creadas en el proyecto
Usuario         VARCHAR(100),            -- quien ejecuta la sentencia DML
Fecha_IUD       DATE,                    -- momento exacto en el que se genera DML
PRIMARY KEY (ID_LOG)
);


-- Trigger 1 de Auditora 1: AFTER - Se activa después de que insertamos un nuevo registro en la tabla Cliente
DELIMITER $$
create Trigger TRG_Log_Cliente_1 After Insert ON Modelo_Tienda_Celulares.Cliente
FOR EACH ROW 
BEGIN
INSERT INTO Log_Cliente_Auditora (Nombre_Accion, Nombre_Tabla, Usuario, Fecha_IUD)
VALUES ('Insert', 'Cliente', CURRENT_USER(), NOW());
END $$ DELIMITER ;

-- Trigger 2 de Auditora 1: UPDATE - Se activa antes de actualizar un registro en la tabla Cliente
DELIMITER $$
create Trigger TRG_Log_Cliente_4 Before Update ON Modelo_Tienda_Celulares.Cliente
FOR EACH ROW 
BEGIN
INSERT INTO Log_Cliente_Auditora (Nombre_Accion, Nombre_Tabla, Usuario, Fecha_IUD)
VALUES ('Update', 'Cliente', CURRENT_USER(), NOW());
END $$ DELIMITER ;

-- Trigger 1 de Auditora 2: UPDATE - Se activa antes de que actualizar un registro en la tabla Cliente
DELIMITER $$
create Trigger TRG_Log_Cliente_3 Before Update ON Modelo_Tienda_Celulares.Cliente
FOR EACH ROW 
BEGIN
INSERT INTO Log_Cliente_Auditora_2 (Viejo_Cliente, Nuevo_Cliente, Nombre_Accion, Nombre_Tabla, Usuario, Fecha_IUD)
VALUES (old.Nombre, new.Nombre, 'Update', 'Cliente', CURRENT_USER(), NOW());
END $$ DELIMITER ;

-- Trigger 2 de Auditora 2: BEFORE - Se activa antes de que insertamos un nuevo registro en la tabla Cliente
DELIMITER $$
create Trigger TRG_Log_Cliente_2 Before Insert ON Modelo_Tienda_Celulares.Cliente
FOR EACH ROW 
BEGIN
INSERT INTO Log_Cliente_Auditora_2 (Viejo_Cliente, Nuevo_Cliente, Nombre_Accion, Nombre_Tabla, Usuario, Fecha_IUD)
VALUES ('Nuevo Cliente', new.Nombre, 'Update', 'Cliente', CURRENT_USER(), NOW());
END $$ DELIMITER ;

Insert Into Modelo_Tienda_Celulares.Cliente
values (6,'Joshua Rells','Bazar 1006',55640,20566,6,'Mujer',21);

Update Modelo_Tienda_Celulares.Cliente
set Nombre = 'Juancho' where ID_Cliente = 6;

select * from Cliente;
select * from Log_Cliente_Auditora;
select * from Log_Cliente_Auditora_2;