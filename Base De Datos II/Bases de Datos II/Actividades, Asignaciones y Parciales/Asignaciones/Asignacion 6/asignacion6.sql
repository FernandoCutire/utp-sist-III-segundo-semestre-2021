/* orden de creacion de las tablas */

CREATE TABLE PROVINCIA (cod_provincia number not null,
	nombre_provincia varchar2(25) not null,
    constraint cod_provincia_pk PRIMARY KEY (cod_provincia)
);

CREATE TABLE CLIENTE (id_cliente number not null,
	nombre_cliente varchar2(100) not null,
	id_provincia number,
    constraint id_cliente_pk PRIMARY KEY (id_cliente),
	constraint fk_id_provincia foreign key (id_provincia) references PROVINCIA (cod_provincia)
);

CREATE TABLE ORDENES (cod_orden number not null,
    cod_cliente number,
    fecha_orden date not null,
    constraint cod_orden_pk PRIMARY KEY,
	constraint fk_id_cliente foreign key (cod_cliente) references (id_cliente)
);

CREATE TABLE ARTICULO (cod_articulo number not null,
	nombre_articulo varchar2(45) not null,
    existencias number default (0);
    precion_unit number(,2) not null,
	constraint cod_articulo_pk PRIMARY KEY (cod_articulo),
);

CREATE TABLE ORDENES (cod_orden number not null,
	cod_cine number,
	id_pelicula number,
	cod_funcion number,
	constraint fk_cod_cine foreign key (cod_cine) references CINES (cod_cine),
	constraint fk_id_pelicula foreign key (id_pelicula) references PELICULAS (cod_pelicula),
	constraint fk_cod_funcion foreign key (cod_funcion) references FUNCIONES (cod_funcion)
);


/* INSERCIONES */

/* GENEROS*/

INSERT INTO GENEROS(cod_genero, genero_nombre) VALUES(1, 'accion');
INSERT INTO GENEROS(cod_genero, genero_nombre) VALUES(2, 'romance');
INSERT INTO GENEROS(cod_genero, genero_nombre) VALUES(3, 'documental');
INSERT INTO GENEROS(cod_genero, genero_nombre) VALUES(4, 'comedia');
INSERT INTO GENEROS(cod_genero, genero_nombre) VALUES(5, 'drama');


/* ACTORES */

INSERT INTO ACTORES(Cod_actor, actor_nombre, actor_apellido) VALUES(1, 'fernando', 'cutire');
INSERT INTO ACTORES(Cod_actor, actor_nombre, actor_apellido) VALUES(2, 'gabriel', 'diaz');
INSERT INTO ACTORES(Cod_actor, actor_nombre, actor_apellido) VALUES(3, 'jorge', 'escobar');
INSERT INTO ACTORES(Cod_actor, actor_nombre, actor_apellido) VALUES(4, 'william', 'feng');

/* CUIDADES */

INSERT INTO CIUDADES (cod_ciudad, ciudad_nombre) VALUES(1, 'ciudad de panama');
INSERT INTO CIUDADES (cod_ciudad, ciudad_nombre) VALUES(2, 'david');
INSERT INTO CIUDADES (cod_ciudad, ciudad_nombre) VALUES(3, 'colon');
INSERT INTO CIUDADES (cod_ciudad, ciudad_nombre) VALUES(4, 'santiago');
INSERT INTO CIUDADES (cod_ciudad, ciudad_nombre) VALUES(5, 'chitre');

/* PELICULAS */ 

INSERT INTO PELICULAS (cod_pelicula, pelicula_nombre, cod_genero) VALUES(1, 'cutire y las ardillas', 4);
INSERT INTO PELICULAS (cod_pelicula, pelicula_nombre, cod_genero) VALUES(2, 'el regreso de escobar', 1);
INSERT INTO PELICULAS (cod_pelicula, pelicula_nombre, cod_genero) VALUES(3, 'feng man' 5, 1);
INSERT INTO PELICULAS (cod_pelicula, pelicula_nombre, cod_genero) VALUES(4, 'gabox' 3, 3);

/* FUNCIONES */

INSERT INTO FUNCIONES VALUES(1, 20-JUN-2021);
INSERT INTO FUNCIONES VALUES(2, 21-JUN-2021);
INSERT INTO FUNCIONES VALUES(3, 22-JUN-2021);
INSERT INTO FUNCIONES VALUES(4, 23-JUN-2021);


/*CINES */

INSERT INTO CINES VALUES(1, 'CUTIROPOLIS', 1);
INSERT INTO CINES VALUES(2, 'CUTIROPOLIS', 3);

/* EXHIBICIONES */

INSERT INTO EXHIBICIONES(cod_exhibicion, cod_cine, id_pelicula, cod_funcion) VALUES (1, 1, 1, 1);
INSERT INTO EXHIBICIONES(cod_exhibicion, cod_cine, id_pelicula, cod_funcion) VALUES (2, 1, 2, 2);
INSERT INTO EXHIBICIONES(cod_exhibicion, cod_cine, id_pelicula, cod_funcion) VALUES (3, 4, 3, 1);
INSERT INTO EXHIBICIONES(cod_exhibicion, cod_cine, id_pelicula, cod_funcion) VALUES (4, 2, 4, 3);
