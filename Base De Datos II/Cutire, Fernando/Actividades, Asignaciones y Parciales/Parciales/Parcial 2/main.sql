/*
CREATE TABLE tipos_correos (
    cod_correo  NUMBER NOT NULL,
    descripcion VARCHAR2(100),
    CONSTRAINT correo_u UNIQUE ( descripcion ),
    CONSTRAINT tipos_correos_pk PRIMARY KEY ( cod_correo )
);

CREATE TABLE tipos_prestamos (
    cod_prestamo    NUMBER NOT NULL,
    nombre_prestamo VARCHAR2(100) NOT NULL,
    tasa_interes    NUMBER(2, 2) DEFAULT 0,
    CONSTRAINT t_prestam_u UNIQUE ( nombre_prestamo ),
    CONSTRAINT tipos_prestamos_pk PRIMARY KEY ( cod_prestamo )
);
*/


/*
CASO N1

CASO NO. 1 Implementación de Bloques Anónimo PL/Sql.     Valor  15 Ptos

Escribir un bloque PL/SQL anónimo que permita rellenar la tabla AULAS  
con los datos del nuevo Edificio de AULAS de la Universidad Tecnológica de Panamá. 
El Edificio dispone de 4 pisos  de salones, numerados de 1 a 4. 
En el piso 1  habrá que asignar desde el salón 1 al salón 20  para la Facultad de Ing. Sistemas. 
En el piso 2 habrá que asignar del salón 21 al 40 a la Facultad de Ing. Civil. 
En el piso 3 habrá que asignar del salón 41 al 60 a la Facultad de Ing. Industrial. 
En  el piso 4 se asignara del salón 61 al 70 a la Facultad de Ing. Mecánica y  del 
salón 71 al salón 80 a la Facultad Ing. Eléctrica.

Inicialmente todos los salones están disponibles. 
Para los facultades tenemos, 1= ‘Facultad de Ing. Sistemas’, 2= ‘Facultad de Ing. Civil’, 
3= ‘Facultad de Ing. Industrial’,   4= ‘ Facultad de Ing. Mecánica y 5= ‘Facultad de Ing. Eléctrica’. 
Para disponible (S=SI y  N=NO)

La relación  de base de datos tiene la siguiente estructura:  
AULAS ( piso number, salon number, facultad number, disponible char). 
La primary Key (piso, salon, facultad)

*/

CREATE TABLE AULAS (
  aula_id number not null,
  piso number, 
  salon number, 
  facultad number, 
  disponible CHAR,
  constraint disponible CHECK (disponible in ('S','N')),
  CONSTRAINT PK_AULAS PRIMARY KEY ( aula_id, piso, salon, facultad )
);

--Bloque Anonimo CASO 1 
DECLARE
v_aula_id Aulas.aula_id%TYPE;
v_piso Aulas.piso%TYPE;
v_salon Aulas.salon%TYPE;
v_facultad Aulas.facultad%TYPE;
v_disponible Aulas.disponible%TYPE;

BEGIN

--BUCLE PARA FACULTAD SISTEMAS
FOR v_indice IN 1..20 LOOP
 INSERT INTO AULAS (aula_id, piso, salon, facultad, disponible) VALUES (v_indice, 1, 1, 1, 'S' );
    END LOOP;
--BUCLE PARA FACULTAD CIVIL
FOR v_indice IN 21..40 LOOP
 INSERT INTO AULAS (aula_id, piso, salon, facultad, disponible) VALUES (v_indice, 2, 21, 2, 'S' );
    END LOOP;

----BUCLE PARA FACULTAD INDUSTRIAL
FOR v_indice IN 41..60 LOOP
 INSERT INTO AULAS (aula_id, piso, salon, facultad, disponible) VALUES (v_indice, 3, 41, 3, 'N' );
    END LOOP;
--BUCLE PARA FACULTAD MECANICA
FOR v_indice IN 61..70 LOOP
 INSERT INTO AULAS (aula_id, piso, salon, facultad, disponible) VALUES (v_indice, 4, 61, 4, 'S' );
END LOOP;
----BUCLE PARA FACULTAD ELECTRICA
FOR v_indice IN 71..80 LOOP
 INSERT INTO AULAS (aula_id, piso, salon, facultad, disponible) VALUES (v_indice, 4, 71, 5, 'N' );
END LOOP;

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
        dbms_output.put_line('Datos repetidos');
	WHEN VALUE_ERROR THEN
		dbms_output.put_line('Error causado por el tamaño de los datos ingresados');
    WHEN OTHERS THEN
	    dbms_output.put_line('Ocurrió un error en la inserción de los datos');

END;
/

INSERT INTO AULAS VALUES ('1', '1', '1', '1', 'S')



/*
CASO N2

CASO NO. 2  Implementación de Programación Almacenada  de Base de Datos.     Valor  35 Ptos

Para el siguiente caso levantar los objetos de datos para el Hotel ‘EL DURMIENTE, S.A’, estos son las relaciones o tablas  reservas,  habitaciones, temporadas,  y estadística_hotel realizar lo siguiente :

 a.      Crear el objetos de dato habitaciones  con los 
 siguientes campos(id_cadena nombre,  piso entero no nulo, habitación varchar(2) no nulo,  tipo varchar(10) Default ‘Doble’   CONSTRAINT  de tipo no nulo CONSTRAINT   CHECK (‘Individual’,  ‘Doble’, ‘Suite’) ,  llave primaria  piso y habitación). Y id_cadena es un FK referenciada a  estadística_hotel

 Crear el objeto de dato reservas con los siguientes campos  (piso entero, habitación varchar(2), fechaentrada fecha default sysdate,  noches entero,  llave primaria (piso, habitación, fechaentrada), llave foránea (piso y habitación ) referenciada a habitaciones).

 Crear el objeto de dato temporadas con los siguientes campos ( nombre varchar(10) no nulo, mesinicio entero no nulo, diainicio entero no nulo,  mesfinalizacion entero no nulo, dia_finalizacion entero no nulo, llave primaria (nombre, mesincio,diainicio)).

 Crear el objeto de datos estadística_hotel  (id_cadena number, nombre varchar2(50), habitacionesocupadas number, habitacionesdisponibles number, habitacionesreservadas number) donde id_cadena es el primary key.  10 ptos

 b.      Escribir un procedimiento para Insertar en la tabla temporadas la información para 3 filas ( ‘Alta, 6,1,8,30) (‘Media’, 1,1,31,5) (‘Baja’, 1,9,31,12)   5 ptos.

 c.       Escribir procedimiento almacenado que permita rellenar  la tabla habitaciones con los datos del hotel previamente.  El Hotel dispone de 12 pisos de habitaciones, numeradas del 1 a la 12. En cada planta de la 1  a la 11 hay 25 habitaciones: 20 dobles (numeradas de 1 a 20) y 5 sencillas (de la 21 a la 25). En  la planta 12 solo tiene 8 suites numeradas de la 1  a la 8.    10 Ptos

 d.      Escribir un procedimiento almacenado que permita actualizar las habitaciones que han sido ocupada por los huéspedes los cuales son: las 8 suites y las 20 dobles. Una vez actualizadas las habitaciones debe por medio de funciones determinar cuántas habitaciones están ocupadas, cuantas están disponible y de darse el caso determinar las que están reservadas,  para que sean actualizadas en la tabla estadística_hotel antes de concluir el procedimiento. 10 Ptos

Nota los procedimientos deberán tener las invocaciones correspondientes.

*/




CREATE TABLE ESTADISTICA_HOTEL (
  id_cadena number not null,
  nombre_hotel varchar2(50) not null, 
  habitacionesocupadas number default 0, --Se podría meter default de 0
  habitacionesdisponibles number, 
  habitacionesreservadas number default 0, --Se podría meter default de 0
  CONSTRAINT pk_cadena PRIMARY KEY (id_cadena)
);

CREATE TABLE TEMPORADAS (
  nombre_temporada varchar2(10) not null,
  mesinicio number not null, 
  diainicio number not null, 
  mesfinalizacion number not null, 
  dia_finalizacion number not null, 
  CONSTRAINT pk_nomb_temp PRIMARY KEY (nombre_temporada, mesinicio, diainicio)
);

CREATE TABLE HABITACIONES (
  id_cadena number,
  piso number not null, 
  habitacion varchar2(2) not null, --Revisar esta declaración
  tipo varchar2(10) default 'Doble' not null, 
  CONSTRAINT const_tipo CHECK (tipo in ('Individual','Doble', 'Suite')),
  CONSTRAINT pk_habitaciones PRIMARY KEY (piso, habitacion),
  CONSTRAINT fk_cadena FOREIGN KEY ( id_cadena )
        REFERENCES ESTADISTICA_HOTEL ( id_cadena)
);

CREATE TABLE RESERVAS (
  piso number,
  habitacion varchar2(2), 
  fechaentrada date default sysdate,
  noches number,
  CONSTRAINT const_tipo CHECK (tipo in ('Individual','Doble', 'Suite')),
  CONSTRAINT pk_reservas PRIMARY KEY (piso, habitacion, fechaentrada),
  CONSTRAINT fk_piso FOREIGN KEY ( piso )
    REFERENCES HABITACIONES ( piso),
  CONSTRAINT fk_habitacion FOREIGN KEY ( habitacion )
    REFERENCES HABITACIONES ( habitacion)
        
);

-- Procedimientos 

-- Punto b 

CREATE OR REPLACE PROCEDURE Insertar_temporadas(
	p_nombre_temporada OUT TEMPORADAS.nombre_temporada%TYPE,
	p_mesinicio OUT TEMPORADAS.mesinicio%TYPE,
    p_diainicio OUT TEMPORADAS.diainicio%TYPE,
    p_mesfinalizacion OUT TEMPORADAS.mesfinalizacion%TYPE,
    p_dia_finalizacion OUT TEMPORADAS.dia_finalizacion%TYPE,
	)
BEGIN
    INSERT INTO TEMPORADAS (nombre_temporada,mesinicio,diainicio,mesfinalizacion,dia_finalizacion)
    VALUES(p_nombre_temporada,p_mesinicio,p_diainicio,p_mesfinalizacion,p_dia_finalizacion);
END Insertar_temporadas;
/

EXECUTE Insertar_temporadas('Alta', 6,1,8,30);
EXECUTE Insertar_temporadas('Media', 1,1,31,5);
EXECUTE Insertar_temporadas('Baja', 1,9,31,12);



CREATE OR REPLACE PROCEDURE (


    
)

/*
CREATE SEQUENCE Pisos
INCREMENT BY 1
START WITH 1          -----troleao con los pisos
MAXVALUE 
MINVALUE 1;
*/

CREATE SEQUENCE Habitaciones_dobles
INCREMENT BY 1
START WITH 20
MAXVALUE 20
MINVALUE 1;

CREATE SEQUENCE Habitaciones_sencillas
INCREMENT BY 1
START WITH 21
MAXVALUE 25
MINVALUE 21;

CREATE SEQUENCE Habitaciones_Suits
INCREMENT BY 1
START WITH 1
MAXVALUE 8
MINVALUE 1;



