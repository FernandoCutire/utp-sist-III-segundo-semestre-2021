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

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- LAB7

create table Tipo_ahorro (
ID_ahorro number not null,
ahorro varchar2(20) not null,
interes_ahorro number not null,
constraint ID_ahorro_pk primary key (ID_ahorro)
);

create table Sucursal_ahorro (
Cod_sucursal number not null,
ID_ahorro number not null,
montoahorrado number not null,
constraint Sucursal_ahorro_fk foreign key (Cod_sucursal) references Sucursal (Cod_sucursal),
constraint Id_ah_suc_fk foreign key (ID_ahorro) references Tipo_ahorro (ID_ahorro),
constraint suc_ahorro_pk primary key (Cod_sucursal, ID_ahorro)
);

create table Ahorros (
Cod_sucursal number not null,
ID_Cliente number not null,
ID_ahorro number not null,
Num_ahorro number not null,
fecha_apertura date not null,
letra_dep number not null, 
saldo_ahorro number not null,
saldo_interes number not null,
fecha_deposito date,
fecha_retiro date,
usuario varchar2(20) not null,
fecha_modif date not null,
constraint Suc_ahorro_fk foreign key (Cod_sucursal) references Sucursal (Cod_sucursal),
constraint ID_aho_ahor_fk foreign key (Id_ahorro) references Tipo_ahorro (ID_ahorro),
constraint ID_cliente_aho_fk foreign key (ID_cliente) references Cliente (ID_cliente),
constraint Cliente_ahorro_pk primary key (Num_ahorro)
);

create table Tipo_transaccion (
ID_tipo_transc number not null,
transaccion varchar2(20) not null,
constraint ID_transac_pk primary key (ID_tipo_transc)
);

create table Auditoria (
Id_transaccion number not null,
Tabla varchar2(20) not null,
Id_cliente number not null,
Id_ahorro number not null,
Id_tipo_transc number not null,
saldo_anterior number not null,
monto_dr number not null,
saldo_final number not null,
usuario varchar2(20) not null,
fecha date not null,
constraint aud_id_cl_fk foreign key (ID_cliente) references Cliente (ID_Cliente),
constraint aud_id_ahorro_fk foreign key (ID_ahorro) references Tipo_ahorro (ID_ahorro),
constraint aud_id_transc_fk foreign key (ID_tipo_transc) references Tipo_transaccion (ID_tipo_transc),
constraint aud_id_pk primary key (Id_transaccion)
);

create table Transadeporeti (
Cod_sucursal number not null, 
id_transaccion number not null,
id_cliente number not null,
num_ahorro number not null,
id_ahorro number not null,
fechatransaccion date not null,
id_tipo_transc number not null,
monto_dr number not null,
fechainsercion date not null,
usuario varchar2(20) not null,
constraint cod_suc_tran_fk foreign key (Cod_sucursal) references Sucursal (Cod_sucursal),
constraint id_cl_tran_fk foreign key (ID_Cliente) references Cliente (ID_Cliente),
constraint id_ahor_tran_fk foreign key (id_ahorro) references Tipo_ahorro (id_ahorro),
constraint id_tipo_tran_fk foreign key (id_tipo_transc) references Tipo_transaccion (id_tipo_transc),
constraint num_ahorro_fk foreign key (num_ahorro) references Ahorros (num_ahorro),
constraint id_tran_pk primary key (id_transaccion)
);

CREATE OR REPLACE PROCEDURE add_t_ahorro (
    p_id_ahorro      IN tipo_ahorro.id_ahorro%TYPE,
    p_ahorro         IN tipo_ahorro.ahorro%TYPE,
    p_interes        IN tipo_ahorro.interes_ahorro%TYPE
    ) AS
BEGIN
    INSERT INTO tipo_ahorro (id_ahorro, ahorro, interes_ahorro)
    VALUES (p_id_ahorro, p_ahorro, p_interes);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro la tabla');
COMMIT;
END add_t_ahorro;
/

CREATE OR REPLACE PROCEDURE ahorros_aprob(
p_cod_sucursal   IN ahorros.cod_sucursal%TYPE,
P_ID_CLIENTE    IN ahorros.ID_CLIENTE%TYPE,
p_id_ahorro     IN ahorros.id_ahorro%TYPE,
p_num_ahorro     IN ahorros.num_ahorro%TYPE,
P_fecha_apert    IN ahorros.fecha_apertura%TYPE,
P_LETRA_MENSUAL   IN ahorros.LETRA_dep%TYPE,
P_saldo_ahorro   IN ahorros.saldo_ahorro%TYPE,
P_saldo_interes    IN ahorros.saldo_interes%TYPE,
P_fecha_deposito   IN ahorros.fecha_deposito%TYPE,
P_fecha_retiro  IN ahorros.fecha_retiro%TYPE,
P_usuario    	IN ahorros.usuario%TYPE,
P_FECHA_MODIF   IN ahorros.FECHA_MODIF%TYPE
)AS 
BEGIN
INSERT INTO Ahorros (cod_sucursal, ID_CLIENTE, id_ahorro, num_ahorro, fecha_apertura, LETRA_dep, saldo_ahorro, saldo_interes, fecha_deposito, fecha_retiro, usuario, FECHA_MODIF)
VALUES(P_cod_sucursal, P_ID_CLIENTE, P_id_ahorro, P_num_ahorro, P_fecha_apert, P_LETRA_MENSUAL, P_saldo_ahorro, P_saldo_interes, P_fecha_deposito, P_fecha_retiro, P_usuario, P_FECHA_MODIF);
EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE ('No se encontró la tabla');
COMMIT;
END ahorros_aprob;

CREATE SEQUENCE id_transaccion
start with 1
increment by 1;

create or replace PROCEDURE add_transadeporeti (
p_cod_sucursal IN transadeporeti.cod_sucursal%TYPE,
p_id_cliente IN transadeporeti.id_cliente%TYPE,
p_num_ahorro IN transadeporeti.num_ahorro%TYPE,
p_id_ahorro IN transadeporeti.id_ahorro%TYPE,
p_id_tipo_transc IN transadeporeti.id_tipo_transc%TYPE,
p_monto_dr IN transadeporeti.monto_dr%TYPE
    )AS
BEGIN
INSERT INTO transadeporeti (cod_sucursal, id_transaccion, id_cliente, num_ahorro, id_ahorro, fechatransaccion, id_tipo_transc, monto_dr, fechainsercion, usuario)
VALUES (p_cod_sucursal, id_transaccion.nextval, p_id_cliente, p_num_ahorro, p_id_ahorro, sysdate, p_id_tipo_transc, p_monto_dr, sysdate, user);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro la tabla');
COMMIT;
END add_transadeporeti;
/

CREATE SEQUENCE num_cuenta
START WITH     1
 INCREMENT BY   1;

CREATE OR REPLACE PROCEDURE ahorros_aprob(
p_cod_sucursal   IN ahorros.cod_sucursal%TYPE,
P_ID_CLIENTE    IN ahorros.ID_CLIENTE%TYPE,
p_id_ahorro     IN ahorros.id_ahorro%TYPE,
P_fecha_apert    IN ahorros.fecha_apertura%TYPE,
P_LETRA_MENSUAL   IN ahorros.LETRA_dep%TYPE,
P_saldo_ahorro   IN ahorros.saldo_ahorro%TYPE,
P_saldo_interes    IN ahorros.saldo_interes%TYPE,
P_fecha_deposito   IN ahorros.fecha_deposito%TYPE,
P_fecha_retiro  IN ahorros.fecha_retiro%TYPE
)AS 
BEGIN
INSERT INTO Ahorros (cod_sucursal, ID_CLIENTE, id_ahorro, num_ahorro, fecha_apertura, LETRA_dep, saldo_ahorro, saldo_interes, fecha_deposito, fecha_retiro, usuario, FECHA_MODIF)
VALUES(P_cod_sucursal, P_ID_CLIENTE, P_id_ahorro, num_cuenta.nextval, P_fecha_apert, P_LETRA_MENSUAL, P_saldo_ahorro, P_saldo_interes, P_fecha_deposito, P_fecha_retiro, user, sysdate);
UPDATE Sucursal_ahorro
SET
montoahorrado=montoahorrado+p_saldo_ahorro
WHERE
id_ahorro=p_id_ahorro and cod_sucursal=p_cod_sucursal; 
IF SQL%ROWCOUNT=0 THEN
INSERT INTO Sucursal_ahorro (id_ahorro, cod_sucursal, montoahorrado)
Values (p_id_ahorro, p_cod_sucursal,p_saldo_ahorro);
END IF;
EXCEPTION
     WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE ('No se encontró la tabla');
COMMIT;
END ahorros_aprob;
/

CREATE OR REPLACE FUNCTION interes_deposito (
p_monto_dep transadeporeti.monto_dr%TYPE,
p_interes tipo_ahorro.interes_ahorro%TYPE )
RETURN NUMBER AS 
BEGIN 
RETURN (p_monto_dep * p_interes)/100;
END interes_deposito;
/

create or replace PROCEDURE update_dr 
AS
CURSOR c_depret IS
SELECT cod_sucursal, id_cliente, id_ahorro, monto_dr, id_tipo_transc, num_ahorro 
from Transadeporeti;
p_sucursal transadeporeti.cod_sucursal%TYPE;
p_cliente transadeporeti.id_cliente%TYPE;
p_transac transadeporeti.id_transaccion%TYPE;
p_tipotrans transadeporeti.id_tipo_transc%TYPE;
p_montod transadeporeti.monto_dr%TYPE;
p_funcion ahorros.saldo_interes%TYPE;
p_tipoa transadeporeti.id_ahorro%TYPE;
p_interes tipo_ahorro.interes_ahorro%TYPE;
p_saldo_actual ahorros.saldo_ahorro%TYPE;
p_num_ahorro transadeporeti.num_ahorro%TYPE;
BEGIN
OPEN c_depret;
LOOP
FETCH c_depret INTO p_sucursal, p_cliente, p_tipoa, p_montod, p_tipotrans, p_num_ahorro;
SELECT interes_ahorro INTO p_interes 
FROM tipo_ahorro WHERE id_ahorro = p_tipoa;
SELECT saldo_ahorro INTO p_saldo_actual FROM Ahorros WHERE id_ahorro = p_tipoa and id_cliente =p_cliente and cod_sucursal=p_sucursal;
IF ((p_tipoa = 1 OR p_tipoa = 3) AND p_tipotrans = 1) THEN
p_funcion := interes_deposito (p_montod, p_interes);
UPDATE Ahorros
SET
saldo_ahorro = saldo_ahorro+p_montod+p_funcion,
saldo_interes = saldo_interes+p_funcion,
fecha_deposito = sysdate,
usuario = user,
fecha_modif = sysdate
WHERE id_cliente = p_cliente and num_ahorro=p_num_ahorro;
ELSIF (p_tipoa = 2 AND p_tipotrans = 1) THEN 
UPDATE Ahorros
SET
saldo_ahorro = saldo_ahorro+p_montod,
fecha_deposito = sysdate,
usuario = user,
fecha_modif = sysdate
WHERE id_cliente = p_cliente and num_ahorro=p_num_ahorro;
ELSIF (p_tipoa = 2 AND p_tipotrans = 2 )THEN
IF (p_saldo_actual >= p_montod) THEN
UPDATE Ahorros
SET
saldo_ahorro = saldo_ahorro - p_montod,
usuario = user,
fecha_modif = sysdate
WHERE id_cliente = p_cliente and num_ahorro=p_num_ahorro;
ELSE
DBMS_OUTPUT.PUT_LINE ('No hay suficientes fondos');
END IF;
END IF;
EXIT WHEN c_depret%NOTFOUND;
END LOOP;
CLOSE c_depret;
EXCEPTION
WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE ('No se encontró los datos');
COMMIT;
END update_dr;

create table temp_suc(
upd_suc number,
cod_sucursal number,
id_ahorro number,
monto_aho_v number,
monto_aho_n number,
usuario varchar2(20),
fecha date
);

create sequence trig_suc 
start with 1
increment by 1;

CREATE OR REPLACE TRIGGER Update_sucursal
AFTER UPDATE ON Ahorros
FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO Temp_suc (upd_suc, cod_sucursal, id_ahorro, monto_aho_v, monto_aho_n, usuario, fecha)
VALUES (trig_suc.nextval, cod_sucursal, id_ahorro, null, saldo_ahorro, user, sysdate);
ELSIF UPDATING
UPDATE Temp_suc
	SET saldo_ahorro = saldo_ahorro + :new.saldo_ahorro
	where id_ahorro = :new.id_ahorro AND cod_sucursal = :new.cod_sucursal;
END Update_sucursal;

CREATE TABLE Temporal_Auditoria(
  id_audi  int,
  Id_transaccion number not null,
  Tabla varchar2(20) not null,
    Id_cliente number not null,
    Id_ahorro number not null,
    Id_tipo_transc number not null,
    saldo_anterior number not null,
    monto_dr number not null,
    saldo_final number not null,
    usuario varchar2(20) not null,
    fecha date not null,
    accion VARCHAR2(20)  
);

create or replace procedure add_auditoria (
    p_id_transaccion	IN auditoria.id_transaccion%TYPE,
    p_tabla		IN auditoria.tabla%TYPE,
    p_id_cliente	IN auditoria.id_cliente%TYPE,
    p_id_ahorro		IN auditoria.id_ahorro%TYPE,
    p_id_tipo_transc	IN auditoria.id_tipo_transc%TYPE,
    p_saldo_anterior	IN auditoria.saldo_anterior%TYPE,
    p_monto_dr		IN auditoria.monto_dr%TYPE,
    p_saldo_final	IN auditoria.saldo_final%TYPE
)as
begin
insert into auditoria (id_transaccion, tabla, id_cliente, id_ahorro, id_tipo_transc, saldo_anterior, monto_dr, saldo_final, usuario, fecha)
values (p_id_transaccion, p_tabla, p_id_cliente, p_id_ahorro, p_id_tipo_transc, p_saldo_anterior, p_monto_dr, p_saldo_final, user, sysdate);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro la tabla');
COMMIT;
end add_auditoria;
/

begin
add_auditoria (1, 'auditoria', 1, 1, 1, 0, 100, 106);
end;
/

select * from temporal_auditoria;

CREATE SEQUENCE auto_triggerA
start with 1
increment by 1
maxvalue 99999
minvalue 1;

CREATE OR REPLACE TRIGGER Insercion_Aud
 BEFORE INSERT ON Auditoria
 FOR EACH ROW
 DECLARE
 v_TipoCambio CHAR(1);
 BEGIN
 /* Usar 'I' para INSERTAR*/
 IF INSERTING THEN
 v_TipoCambio := 'I';
 END IF;
 DBMS_OUTPUT.put_line(v_TipoCambio ||' '|| USER ||' ' ||SYSDATE);
 INSERT INTO Temporal_Auditoria
 VALUES(auto_triggerA.NEXTVAL,:NEW.id_transaccion,:NEW.tabla,:NEW.id_cliente,:NEW.id_ahorro,:NEW.id_tipo_transc,:NEW.saldo_anterior,:NEW.monto_dr,:NEW.saldo_final,user,sysdate,v_TipoCambio);
 END Insercion_Aud;
/

----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER Update_sucursal_bef 
BEFORE UPDATE ON Sucursal_ahorro
FOR EACH ROW
BEGIN
INSERT INTO Temp_suc (upd_suc, cod_sucursal, id_ahorro, montoahorrado, usuario, fecha)
VALUES (trig_suc.nextval, cod_sucursal, id_ahorro, montoahorrado, user, sysdate);
END Update_sucursal_bef;

CREATE OR REPLACE TRIGGER Update_sucursal_aft 
AFTER UPDATE ON Sucursal_ahorro
FOR EACH ROW
BEGIN
INSERT INTO Temp_suc (upd_suc, cod_sucursal, id_ahorro, montoahorrado, usuario, fecha)
VALUES (trig_suc.nextval, cod_sucursal, id_ahorro, montoahorrado, user, sysdate);
END Update_sucursal_aft;

---------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER insercion_auditoria
AFTER INSERT ON auditoria

---------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION interes_corriente (
p_montod ahorros.saldo_ahorro%TYPE,
p_interes tipo_ahorro.interes_ahorro%TYPE)
RETURN NUMBER AS
BEGIN
RETURN (p_montod * p_interes)/100;
END interes_corriente;

CREATE OR REPLACE PROCEDURE update_corriente 
AS
CURSOR c_corriente IS
SELECT id_cliente, id_ahorro, saldo_ahorro, num_ahorro
FROM Ahorros where id_ahorro=2;
v_cliente Ahorros.id_cliente%TYPE;
v_ahorro Ahorros.id_ahorro%TYPE;
v_saldoa Ahorros.saldo_ahorro%TYPE;
v_funcion Ahorros.saldo_interes%TYPE;
v_interes Tipo_ahorro.interes_ahorro%TYPE;
v_num Ahorros.num_ahorro%TYPE;
BEGIN
OPEN c_corriente;
LOOP
FETCH c_corriente INTO v_cliente, v_ahorro, v_saldoa, v_num;
SELECT interes_ahorro INTO v_interes 
FROM tipo_ahorro WHERE id_ahorro = v_ahorro;
v_funcion := interes_corriente (v_saldoa, v_interes);
UPDATE Ahorros
SET
saldo_ahorro = saldo_ahorro + v_funcion,
saldo_interes = saldo_interes + v_funcion,
usuario = user,
fecha_modif = sysdate
WHERE id_cliente = v_cliente AND num_ahorro = v_num;
EXIT WHEN c_corriente%NOTFOUND;
END LOOP;
CLOSE c_corriente;
EXCEPTION
WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE ('No se encontró los datos');
COMMIT;
END update_corriente;

CREATE OR REPLACE PROCEDURE add_t_transac (
    p_id_tipo      IN tipo_transaccion.id_tipo_transc%TYPE,
    p_transac         IN tipo_transaccion.transaccion%TYPE
    ) AS
BEGIN
    INSERT INTO tipo_transaccion (id_tipo_transc, transaccion)
    VALUES (p_id_tipo, p_transac);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE ('No se encontro la tabla');
COMMIT;
END add_t_transac;

----------------------------------------------------------

BEGIN
ADD_T_AHORRO (01,'Navidad', 6);
ADD_T_AHORRO (02,'Corriente',4);
ADD_T_AHORRO (03,'Escolar', 6);
END;

BEGIN
AHORROS_APROB (1,1,1,TO_DATE('27-OCT-20'),100,0,0,NULL,NULL);
AHORROS_APROB (2,2,2,TO_DATE('31-OCT-20'),50,0,0,NULL,NULL);
AHORROS_APROB (3,3,3,TO_DATE('01-NOV-20'),200,0,0,NULL,NULL);
AHORROS_APROB (4,5,1,TO_DATE('01-NOV-20'),100,0,0,NULL,NULL);
AHORROS_APROB (3,2,2,TO_DATE('05-NOV-20'),200,0,0,NULL,NULL);
END;

BEGIN
ADD_T_TRANSAC (1, 'Depósito');
ADD_T_TRANSAC (2, 'Retiro');
END;


BEGIN 
ADD_TRANSADEPORETI (1,1,2,1,1,100);
ADD_TRANSADEPORETI (2,2,3,2,1,100);
ADD_TRANSADEPORETI (3,3,4,3,1,200);
ADD_TRANSADEPORETI (4,5,5,1,1,100);
ADD_TRANSADEPORETI (3,2,6,2,1,200);
END;

BEGIN
update_dr;
END;

BEGIN
update_corriente;
END;

select * from ahorros;
select * from cliente;
select * from email;
select * from email_cliente;
select * from prestamo;
select * from profesion;
select * from sucursal;
select * from sucursal_ahorro;
select * from sucursal_prestamo;
select * from telefono;
select * from telefono_cliente;

select * from tipo_ahorro;
select * from tipo_prestamo;
select * from tipo_transaccion;
select * from transact_pagos;
select * from transadeporeti;