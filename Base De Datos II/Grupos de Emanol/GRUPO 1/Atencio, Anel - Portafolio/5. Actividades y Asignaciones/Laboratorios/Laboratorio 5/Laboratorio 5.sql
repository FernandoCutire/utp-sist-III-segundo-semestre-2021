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

---------------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE email_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE OR REPLACE PROCEDURE add_email (
    p_id_email      IN email.id_email%TYPE,
    p_tipo_email    IN email.tipo_email%TYPE
    ) AS
BEGIN
    INSERT INTO email (id_email, tipo_email)
    VALUES (email_sequence.nextval, p_tipo_email);
COMMIT;
END add_email;

---------------------------------------------------

CREATE SEQUENCE telefono_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE OR REPLACE PROCEDURE add_telefono (
    p_id_telefono      IN telefono.id_telefono%TYPE,
    p_tipo_telefono    IN telefono.tipo_telefono%TYPE
    ) AS
BEGIN
    INSERT INTO telefono (id_telefono, tipo_telefono)
    VALUES (telefono_sequence.nextval, p_tipo_telefono);
COMMIT;
END add_telefono;

-----------------------------------------------------

CREATE SEQUENCE profesion_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE OR REPLACE PROCEDURE add_profesion (
    p_id_pro      IN profesion.id_pro%TYPE,
    p_profesion    IN profesion.profesion%TYPE
    ) AS
BEGIN
    INSERT INTO profesion (id_pro, profesion)
    VALUES (profesion_sequence.nextval, p_profesion);
COMMIT;
END add_profesion;

-----------------------------------------------------

CREATE SEQUENCE tipo_prestamo_sequence
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

CREATE OR REPLACE PROCEDURE add_tipo_prestamo (
    p_id_tipo           IN tipo_prestamo.id_tipo%TYPE,
    p_tipo              IN tipo_prestamo.tipo%TYPE,
    p_tasa_interes      IN tipo_prestamo.tasa_interes%TYPE
    ) AS
BEGIN
    INSERT INTO tipo_prestamo (id_tipo, tipo, tasa_interes)
    VALUES (tipo_prestamo_sequence.nextval, p_tipo, p_tasa_interes);
COMMIT;
END add_tipo_prestamo;

-----------------------------------------------------------





