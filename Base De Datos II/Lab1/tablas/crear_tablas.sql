CREATE TABLE cantidades (
    receta      NUMBER NOT NULL,
    ingrediente NUMBER NOT NULL,
    cantidad    NUMBER NOT NULL,
    medida      NUMBER NOT NULL
);

ALTER TABLE cantidades
    ADD CONSTRAINT cantidades_pk PRIMARY KEY ( receta,
                                               ingrediente,
                                               medida );

CREATE TABLE categoria (
    id_cat     NUMBER NOT NULL,
    combre_cat VARCHAR2(45)
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_cat );

CREATE TABLE ingredientes (
    id_ingrediente     NUMBER NOT NULL,
    nombre_ingrediente VARCHAR2(100)
);

ALTER TABLE ingredientes ADD CONSTRAINT ingredientes_pk PRIMARY KEY ( id_ingrediente );

CREATE TABLE medidas (
    id_umedida    NUMBER NOT NULL,
    nombre_medida VARCHAR2(100)
);

ALTER TABLE medidas ADD CONSTRAINT medidas_pk PRIMARY KEY ( id_umedida );

CREATE TABLE recetas (
    id_receta     NUMBER NOT NULL,
    nombre_receta VARCHAR2(100),
    preparacion   VARCHAR2(500),
    duracion      VARCHAR2(10),
    comentarios   VARCHAR2(500),
    tipoplato     NUMBER NOT NULL
);

ALTER TABLE recetas ADD CONSTRAINT recetas_pk PRIMARY KEY ( id_receta );

CREATE TABLE tipoplatos (
    id_plato     NUMBER NOT NULL,
    nombre_plato VARCHAR2(45),
    cod_cat      NUMBER NOT NULL
);

ALTER TABLE tipoplatos ADD CONSTRAINT tipoplatos_pk PRIMARY KEY ( id_plato );

ALTER TABLE cantidades
    ADD CONSTRAINT cantidades_ingredientes_fk FOREIGN KEY ( ingrediente )
        REFERENCES ingredientes ( id_ingrediente );

ALTER TABLE cantidades
    ADD CONSTRAINT cantidades_medidas_fk FOREIGN KEY ( medida )
        REFERENCES medidas ( id_umedida );

ALTER TABLE cantidades
    ADD CONSTRAINT cantidades_recetas_fk FOREIGN KEY ( receta )
        REFERENCES recetas ( id_receta );

ALTER TABLE recetas
    ADD CONSTRAINT recetas_tipoplatos_fk FOREIGN KEY ( tipoplato )
        REFERENCES tipoplatos ( id_plato );

ALTER TABLE tipoplatos
    ADD CONSTRAINT tipoplatos_categoria_fk FOREIGN KEY ( cod_cat )
        REFERENCES categoria ( id_cat );





