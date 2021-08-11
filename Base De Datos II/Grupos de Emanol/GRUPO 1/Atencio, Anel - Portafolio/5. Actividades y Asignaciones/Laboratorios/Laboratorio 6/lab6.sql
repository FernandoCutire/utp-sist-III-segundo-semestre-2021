create table PROFESION (
ID_Pro number not null,
profesion varchar2 (30) not null,
constraint ID_Pro_pk primary key (ID_Pro)
);


create table TIPO_PRESTAMO (
ID_tipo number not null,
tipo varchar2 (30) not null,
tasa_interes number not null,
constraint ID_tipo_pk primary key (ID_tipo)
);


create table EMAIL (
ID_email number not null,
Tipo_email varchar2 (20) not null,
constraint ID_email_pk primary key (ID_email)
);


create table TELEFONO (
ID_telefono number not null,
Tipo_telefono varchar2 (20) not null,
constraint ID_telefono_pk primary key (ID_telefono)
);


create table CLIENTE (
ID_Cliente number not null,
ID_Pro number not null,
cedula varchar2 (20) not null,
nombre varchar2 (30) not null,
apellido varchar2 (30) not null,
sexo char not null,
fecha_nac date not null,
constraint ID_Cliente_pk primary key (ID_Cliente),
constraint ID_prof_fk foreign key (ID_Pro) references PROFESION (ID_Pro)
);

create table EMAIL_CLIENTE (
ID_email number not null,
ID_Cliente number not null,
email varchar2 (40) not null,
constraint ID_email_fk foreign key (ID_email) references EMAIL (ID_email),
constraint ID_Cl_email_fk foreign key (ID_Cliente) references CLIENTE (ID_Cliente),
constraint ID_email_cl_pk primary key (ID_email, ID_Cliente)
 );


create table TELEFONO_CLIENTE (
ID_telefono number not null,
ID_Cliente number not null,
telefono varchar2 (20) not null,
constraint ID_tel_fk foreign key (ID_telefono) references TELEFONO (ID_telefono),
constraint ID_cl_tel_fk foreign key (ID_Cliente) references CLIENTE (ID_Cliente),
constraint ID_telef_cl_pk primary key (ID_telefono, ID_Cliente)
);


create table PRESTAMO (
ID_tipo number not null,
ID_Cliente number not null,
Num_prestamo number not null,
fecha_aprob date not null,
monto_aprob number not null,
letra_mensual number not null,
monto_pago number not null,
fecha_pago date not null,
constraint ID_tipo_fk foreign key (ID_tipo) references TIPO_PRESTAMO (ID_tipo),
constraint ID_cliente_prest_fk foreign key (ID_Cliente) references CLIENTE (ID_Cliente),
constraint ID_cl_tipo_prest_pk primary key (ID_tipo, ID_Cliente)
);

create unique index numero_prestamo on PRESTAMO (Num_prestamo);

alter table CLIENTE
add edad number not null;

create table SUCURSAL (
Cod_sucursal number not null,
Nombre_sucursal varchar2 (30) not null,
Constraint Cod_suc_pk primary key (Cod_sucursal)
);

create table SUCURSAL_PRESTAMO(
Cod_sucursal number not null,
ID_tipo number not null,
Constraint ID_tipo_suc_fk foreign key (ID_tipo) references TIPO_PRESTAMO (ID_tipo),
Constraint Cod_sucursal_p_fk foreign key (Cod_sucursal) references SUCURSAL (Cod_sucursal),
Constraint Cod_id_suc_pk primary key (Cod_sucursal, ID_tipo),
Monto_prestamo number not null
);

Alter table CLIENTE
Add (Cod_sucursal number not null, constraint Cod_suc_cl_fk foreign key (Cod_sucursal) references SUCURSAL (Cod_sucursal));

Alter table PRESTAMO 
Add (Cod_sucursal number not null, constraint Cod_suc_pres_fk foreign key (Cod_sucursal) references SUCURSAL (Cod_sucursal));

alter table PRESTAMO
ADD (saldo_actual number not null, interes_pagado number not null, fecha_modif date not null, usuario varchar2 (30) not null);

create table transact_pagos (
ID_transaccion number not null,
constraint ID_transaccion_pk primary key (ID_transaccion), 
Cod_sucursal number not null,
ID_Cliente number not null, 
ID_tipo number not null,
Fechatransaccion date not null,
Monto_pago number not null,
Fecha_insercion date not null,
Usuario varchar2 (30) not null
);

---------------------------------------------------------------------------------- SECUENCIAS

CREATE SEQUENCE email_sequence
 START WITH 1 
INCREMENT BY 1;

CREATE SEQUENCE telefono_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE profesion_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
CREATE SEQUENCE tipo_prestamo_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE cliente_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE pagos_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE sucursales_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

-----------------------------------------------------------------------------Procedimientos de tablas paramétricas

CREATE OR REPLACE PROCEDURE add_email (
    p_id_email      IN email.id_email%TYPE,
    p_tipo_email    IN email.tipo_email%TYPE
    ) AS
BEGIN
    INSERT INTO email (id_email, tipo_email)
    VALUES (p_id_email, p_tipo_email);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro la tabla');
COMMIT;
END add_email;
/

CREATE OR REPLACE PROCEDURE add_telefono (
    p_id_telefono      IN telefono.id_telefono%TYPE,
    p_tipo_telefono    IN telefono.tipo_telefono%TYPE
    ) AS
BEGIN
    INSERT INTO telefono (id_telefono, tipo_telefono)
    VALUES (p_id_telefono, p_tipo_telefono);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro la tabla');
COMMIT;
END add_telefono;
/

CREATE OR REPLACE PROCEDURE add_profesion (
    p_id_pro      IN profesion.id_pro%TYPE,
    p_profesion    IN profesion.profesion%TYPE
    ) AS
BEGIN
    INSERT INTO profesion (id_pro, profesion)
    VALUES (p_id_pro, p_profesion);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro la tabla');
COMMIT;
END add_profesion;
/

-------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE add_tipo_prestamo (
    p_id_tipo           IN tipo_prestamo.id_tipo%TYPE,
    p_tipo              IN tipo_prestamo.tipo%TYPE,
    p_tasa_interes      IN tipo_prestamo.tasa_interes%TYPE
    ) AS
BEGIN
    INSERT INTO tipo_prestamo (id_tipo, tipo, tasa_interes)
    VALUES (p_id_tipo, p_tipo, p_tasa_interes);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro la tabla');
COMMIT;
END add_tipo_prestamo;
/

------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE add_sucursales (
    p_cod_sucursal                 IN sucursal.cod_sucursal%TYPE,
    p_nombre_sucursal              IN sucursal.nombre_sucursal%TYPE
    ) AS
BEGIN
    INSERT INTO sucursal (cod_sucursal, nombre_sucursal)
    VALUES (p_cod_sucursal, p_nombre_sucursal);
EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE ('No se encontró la tabla');
COMMIT;
END add_sucursales;
/

---------------------------------------------------------------------------Funcion para calcular edad

CREATE OR REPLACE FUNCTION calc_edad (fecha_nac CLIENTE.fecha_nac%TYPE) 
RETURN NUMBER AS
BEGIN
RETURN FLOOR (months_between (sysdate, fecha_nac)/12);
END calc_edad;
/

--------------------------------------------------------------------------Procedimiento de tabla Cliente

CREATE OR REPLACE PROCEDURE add_cliente (
    p_id_cliente        IN cliente.id_cliente%TYPE,
    p_id_pro            IN cliente.id_pro%TYPE,
    p_cedula            IN cliente.cedula%TYPE,
    p_nombre            IN cliente.nombre%TYPE,
    p_apellido          IN cliente.apellido%TYPE,
    p_sexo              IN cliente.sexo%TYPE,
    p_fecha_nac         IN cliente.fecha_nac%TYPE,
    p_cod_sucursal      IN cliente.cod_sucursal%TYPE,
    p_error OUT varchar2
     ) AS
P_edad cliente.edad%TYPE;
BEGIN
P_error := 'Registro Creado';
P_edad := calc_edad(p_fecha_nac);
INSERT INTO cliente (id_cliente, id_pro, cedula, nombre, apellido, sexo, fecha_nac, edad, cod_sucursal)
VALUES (p_id_cliente,p_id_pro, p_cedula, p_nombre, p_apellido, p_sexo, p_fecha_nac, p_edad, p_cod_sucursal);
EXCEPTION 
WHEN DUP_VAL_ON_INDEX THEN
P_error := 'Cliente existente';
WHEN OTHERS THEN 
P_error := 'No se creo el registro';
COMMIT;
END add_cliente;
/

---------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE add_email_cliente (
    p_id_email                 	      IN email_cliente.id_email%TYPE,
    p_id_cliente	                 IN email_cliente.id_cliente%TYPE,
    p_email			       IN email_cliente.email%TYPE
    ) AS
BEGIN
    INSERT INTO email_cliente(id_email, id_cliente, email)
    VALUES (p_id_email, p_id_cliente, p_email);

EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE ('No se encontró la tabla');
COMMIT;
END add_email_cliente;
/

----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE add_telefono_cliente (
    p_id_telefono                 	      IN telefono_cliente.id_telefono%TYPE,
    p_id_cliente	                 IN telefono_cliente.id_cliente%TYPE,
    p_telefono			       IN telefono_cliente.telefono%TYPE
    ) AS
BEGIN
    INSERT INTO telefono_cliente(id_telefono, id_cliente, telefono)
    VALUES (p_id_telefono, p_id_cliente, p_telefono);
EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE ('No se encontró la tabla');
COMMIT;
END add_telefono_cliente;
/

---------------------------------------------------------------------------Procedimiento tablas Prestamo y Sucursal_prestamo

CREATE OR REPLACE PROCEDURE prestamos_aprob(
P_ID_Tipo    IN Prestamo.ID_TIPO%TYPE,
P_ID_CLIENTE    IN Prestamo.ID_CLIENTE%TYPE,
P_NUM_PRESTAMO     IN Prestamo.NUM_PRESTAMO%TYPE,
P_FECHA_APROB     IN Prestamo.FECHA_APROB%TYPE,
P_MONTO_APROB    IN Prestamo.MONTO_APROB%TYPE,
P_LETRA_MENSUAL   IN Prestamo.LETRA_MENSUAL%TYPE,
P_MONTO_PAGO    IN Prestamo.MONTO_PAGO%TYPE,
P_FECHA_PAGO    IN Prestamo.FECHA_PAGO%TYPE,
P_COD_SUCURSAL   IN Prestamo.COD_SUCURSAL%TYPE,
P_SALDO_ACTUAL   IN Prestamo.SALDO_ACTUAL%TYPE,
P_INTERES_PAGADO    IN Prestamo.INTERES_PAGADO%TYPE,
P_FECHA_MODIF   IN Prestamo.FECHA_MODIF%TYPE,
P_USUARIO    IN Prestamo.USUARIO%TYPE
)AS 
BEGIN
INSERT INTO Prestamo (ID_TIPO, ID_CLIENTE, NUM_PRESTAMO, FECHA_APROB, MONTO_APROB, LETRA_MENSUAL, MONTO_PAGO, FECHA_PAGO, COD_SUCURSAL, SALDO_ACTUAL, INTERES_PAGADO, FECHA_MODIF, USUARIO)
VALUES(P_ID_Tipo, P_ID_CLIENTE, P_NUM_PRESTAMO, P_FECHA_APROB, P_MONTO_APROB, P_LETRA_MENSUAL, P_MONTO_PAGO, P_FECHA_PAGO, P_COD_SUCURSAL, P_SALDO_ACTUAL, P_INTERES_PAGADO, P_FECHA_MODIF, P_USUARIO);
UPDATE Sucursal_Prestamo 
SET  
Monto_prestamo = Monto_prestamo + p_monto_aprob 
where ID_tipo = P_ID_TIPO AND Cod_sucursal = P_COD_SUCURSAL;
IF SQL%ROWCOUNT=0 THEN
INSERT INTO Sucursal_prestamo (id_tipo, cod_sucursal, monto_prestamo)
Values (p_id_tipo, p_cod_sucursal,p_monto_aprob );
END IF;
EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE ('No se encontró la tabla');
COMMIT;
END prestamos_aprob;
/

-----------------------------------------------------------------------------------------------------------Procedimiento tabla transact_pagos

CREATE OR REPLACE PROCEDURE add_pagos (
p_id_transac    IN transact_pagos.id_transaccion%TYPE,
p_cod_sucursal   IN transact_pagos.cod_sucursal%TYPE,
p_id_cliente   IN transact_pagos.id_cliente%TYPE,
p_id_tipo IN transact_pagos.id_tipo%TYPE,
p_fechatransac IN transact_pagos.fechatransaccion%TYPE,
p_monto_pago IN transact_pagos.monto_pago%TYPE,
p_fecha_insercion IN transact_pagos.fecha_insercion%TYPE,
p_usuario IN transact_pagos.usuario%TYPE ) AS
BEGIN
    INSERT INTO transact_pagos (id_transaccion, cod_sucursal, id_cliente, id_tipo, fechatransaccion, monto_pago, fecha_insercion, usuario)
    VALUES (p_id_transac, p_cod_sucursal, p_id_cliente, p_id_tipo, p_fechatransac, p_monto_pago, p_fecha_insercion, p_usuario);
COMMIT;
END add_pagos;
/

-----------------------------------------------------Funcion calcular interes

create or replace function c_interes (
p_saldo Prestamo.saldo_actual%TYPE,
p_interes Tipo_prestamo.tasa_interes%TYPE)
RETURN NUMBER AS
BEGIN 
    return p_saldo*p_interes;
END c_interes;
/

--------------------------------------------------Procedimiento actualizar pagos

create or replace procedure update_pago
AS
CURSOR act_pago IS
SELECT monto_pago, cod_sucursal, id_tipo, id_cliente, id_transaccion
FROM Transact_pagos;
v_pago prestamo.interes_pagado%TYPE;
v_tasa tipo_prestamo.tasa_interes%TYPE;
v_saldo transact_pagos.monto_pago%TYPE;
v_monto prestamo.monto_aprob%TYPE;
v_saldo_act prestamo.saldo_actual%TYPE;
v_apago prestamo.interes_pagado%TYPE;
BEGIN
FOR i IN act_pago LOOP
SELECT tasa_interes into v_tasa from tipo_prestamo
where id_tipo = i.id_tipo;
SELECT saldo_actual into v_saldo_act from prestamo 
where id_tipo=i.id_tipo and id_cliente=i.id_cliente;
v_apago :=c_interes (v_saldo_act, v_tasa);
v_saldo:= v_apago-i.monto_pago;
IF (v_saldo > 0) THEN
UPDATE PRESTAMO
SET
Monto_pago = v_saldo,
Interes_pagado = v_apago,
Saldo_actual = saldo_actual – v_saldo,
Fecha_pago = sysdate,
Usuario= user
WHERE id_cliente=i.id_cliente and id_tipo = i.id_tipo;
UPDATE SUCURSAL_PRESTAMO 
SET 
monto_prestamo = monto_prestamo - v_saldo
where id_tipo = i.id_tipo and cod_sucursal = i.cod_sucursal;
ELSE
UPDATE PRESTAMO
SET
Monto_pago = v_saldo,
Interes_pagado = v_apago,
Fecha_pago = sysdate,
Usuario= user
WHERE
id_cliente = i.id_cliente and id_cliente=i.id_cliente;
END IF;
END LOOP;
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro datos');
COMMIT;
END update_pago;
/

-------------------------------------------------------------------------------------------------------------Invocaciones

---------------------------------Email
BEGIN 
Add_email (1, 'Personal');
Add_email (2, 'Académico');
Add_email (3, 'Laboral');
END;
/

----------------------------------Telefono
BEGIN 
Add_telefono (1, 'Residencial');
Add_telefono (2, 'Celular');
Add_telefono (3, 'Conyuge');
Add_telefono (4, 'Familiar');
END;
/

-----------------------------------Tipo prestamo
BEGIN
add_tipo_prestamo (1, 'Personal', 0.07);
add_tipo_prestamo (2, 'Auto', 0.0725);
add_tipo_prestamo (3, 'Hipoteca', 0.0650);
add_tipo_prestamo (4, 'Garantizado con ahorros', 0.055);
END;
/

------------------------------------------Profesion
BEGIN
add_profesion (1, 'Psicólogo');
add_profesion (2, 'Abogado');
add_profesion (3, 'Doctor');
add_profesion (4, 'Ingeniero en Sistemas');
add_profesion (5, 'Arquitecto');
add_profesion (6, 'Ingeniero Industrial');
add_profesion (7, 'Contable'); 
add_profesion (8, 'Veterinario');
add_profesion (9, 'Chef');
add_profesion (10,'Policía');
END;
/

------------------------------------------Sucursal
BEGIN
    add_sucursales (1, 'Los Andes Mall');
    add_sucursales (2, 'Metromall');
    add_sucursales (3, 'Albrook Mall');
    add_sucursales (4, 'Multi Plaza');
    add_sucursales (5, 'Alta Plaza');
END;
/

--------------------------------------------Transaccion
BEGIN
add_pagos(1, 1, 1, 1, to_date('17/11/2020','dd/mm/yyyy'), 356, sysdate, user);
add_pagos(2, 2, 2, 2, to_date('17/11/2020','dd/mm/yyyy'), 400, sysdate, user);
add_pagos(3, 3, 3, 3, to_date('17/11/2020','dd/mm/yyyy'), 500, sysdate, user);
add_pagos(4, 4, 4, 4, to_date('17/11/2020','dd/mm/yyyy'), 100, sysdate, user);
END;
/

------------------------------------------------Cliente
set serveroutput on;
DECLARE
 v_error varchar2 (100);
BEGIN
add_cliente (1, 1, '8-789-4532', 'Carlos', 'González', 'M', TO_DATE('13/10/1995', 'DD/MM/YYYY'), 1, v_error);
add_cliente (2, 2, '8-925-546', 'Alicia', 'Navarro', 'F', TO_DATE('10/01/1993','DD/MM/YYYY'), 3, v_error);
add_cliente (3, 3, '8-948-754', 'Jorge', 'Perez', 'M', TO_DATE('27/05/1997','DD/MM/YYYY'), 2, v_error);
add_cliente (4, 4, '8-950-479', 'Sonia', 'Ortiz', 'F', TO_DATE('24/03/1998','DD/MM/YYYY'), 9, v_error);
add_cliente (5, 5, '8-960-521', 'Juan', 'Castillo', 'M', TO_DATE('29/12/1997','DD/MM/YYYY'), 4, v_error);
DBMS_OUTPUT.PUT_LINE (v_error);
END;
/

----------------------------------------------email_cliente
BEGIN
add_email_cliente (1, 1, 'carlosg06@hotmail.com');
 add_email_cliente (2, 1, 'carlos.gonzalez@utp.ac.pa');
 add_email_cliente (1, 2, 'alicianav87@gmail.com');
 add_email_cliente (1, 3, 'jorge8778@gmail.com');
 add_email_cliente (1, 5, 'ortizson2554@gmail.com');
 add_email_cliente (2, 5, 'sonia.ortiz@utp.ac.pa');
  END;
  /

-------------------------------------------------telefono_cliente
BEGIN
Add_telefono_cliente (1, 1, '268-8564');
Add_telefono_cliente (2, 1, '6654-8574');
Add_telefono_cliente (1, 2, '352-7584');
Add_telefono_cliente (2, 3, '6587-8214');
Add_telefono_cliente (1, 3, '268-8795');
Add_telefono_cliente (3, 2, '6574-8941');
Add_telefono_cliente (4, 3, '6978-3210');
Add_telefono_cliente (1, 5, '236-8741');
END; 
/

--------------------------------------------------------------prestamo
BEGIN
prestamos_aprob (1, 1, 1, to_date('12-OCT-20'), 20000, 356,0,TO_DATE ('17-NOV-20'), 1, 20000, 0, to_date('18-NOV-20'), user);
prestamos_aprob (2, 2, 2, to_date('18-OCT-20'), 30000, 400, 0,to_date('17-NOV-20'), 2, 30000, 0, to_date('18-NOV-20'), user);
prestamos_aprob (3, 3, 3, to_date('20-OCT-20'), 200000, 500, 0,to_date('17-NOV-20'), 3, 200000, 0, to_date('18-NOV-20'), user);
prestamos_aprob (4, 5, 4, to_date('21-OCT-20'), 5000, 100, 0,to_date('17-NOV-20'), 4, 5000, 0, to_date('18-NOV-20'), user);
END;
/

-------------------------------------------------------------------------------------------------------------------------Vistas

create view CLIENTE_TIPO as select c.nombre, c.apellido, c.cedula, t.tipo from cliente c join prestamo p on p.id_cliente = c.id_cliente join tipo_prestamo t on t.id_tipo = p.id_tipo;

create view PROFESION_CLIENTE as select p.profesion, c.nombre, c.apellido from cliente c join profesion p on c.id_pro = p.id_pro;

create view Cliente_monto as select c.nombre, c.apellido, p.monto_aprob, p.letra_mensual from cliente c join prestamo p on c.id_cliente = p.id_cliente;


-------------------------------------------------------------------------------------------------------------------------- Consultas

select * from cliente_tipo;

select * from profesion_cliente;

select * from cliente_monto;

--------------------------------------------------------------------------------------------------------------------------

select * from cliente;
select * from email;
select * from email_cliente;
select * from prestamo;
select * from profesion;
select * from sucursal;
select * from sucursal_prestamo;
select * from telefono;
select * from telefono_cliente;
select * from tipo_prestamo;
select * from transact_pagos;