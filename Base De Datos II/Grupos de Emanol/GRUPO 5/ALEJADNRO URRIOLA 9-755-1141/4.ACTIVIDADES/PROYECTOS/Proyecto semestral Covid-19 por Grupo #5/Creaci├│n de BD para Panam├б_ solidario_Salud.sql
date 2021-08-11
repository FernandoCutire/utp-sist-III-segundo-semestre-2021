
-- Creación de la base de datos 
Create database PANAMA_SOLIDARIO_SALUD

-- Creación de la tabla llamada DONADOR 
use PANAMA_SOLIDARIO_SALUD
Create table DONADOR
 (	DNI_RUC  char (20) not null
          Constraint Donador_DNI_RUC_PK primary key , 
    Nombre  varchar (40) not null, 
	Correo varchar(40), 
	Telefono varchar (15), 
	provincia varchar(20), 
	Distrito varchar (30), 
	Corregimiento varchar (30), 
	calle varchar (20), 
	no_casa varchar (5)
	 ) 
	 
-- Creación de la tabla llamada INSUMOS
Create table INSUMOS
 (	codigo_donación  nchar (10) not null
          Constraint insumos_codigo_donacion_PK primary key , 
    descripción varchar (20), 
	tipo varchar (15), 
	cantidad smallint 
	 )
	 
-- Creación de la tabla llamada CENTROS_DISTRIBUCIÓN 
Create table CENTROS_DISTRIBUCIÓN
 (	codigo_cedis  nchar (10) not null
          Constraint centros_distribución_codigo_cedis_PK primary key , 
    Nombre varchar (40), 
	dirección varchar (30), 
	telefono varchar(15), 
	región varchar (15) 
	 )

-- Creación de la tabla llamada INSTALACION_MEDICA 
Create table INSTALACION_MEDICA
 (	codigo_IM  nchar (10) not null
          Constraint instalacion_medica_codigo_IM_PK primary key , 
    Nombre varchar (30), 
	dirección varchar (30), 
	telefono varchar(15), 
	región varchar (15) 
	 )

-- Creación de la tabla llamada PERSONAL 
Create table PERSONAL
 (	DNI  varchar (10) not null
          Constraint personal_DNI_PK primary key , 
    Nombre varchar (20), 
	Apellido varchar (20),
	fecha_nacimiento date, 
	telefono varchar(15), 
	cargo varchar(20),
	provincia varchar(20), 
	Distrito varchar (20), 
	Corregimiento varchar (20), 
	calle varchar (15), 
	no_casa varchar (5), 
	codigo_cedis nchar(10) 
	       Constraint centros_distribución_codigo_cedis_FK foreign key
		   references centros_distribución(codigo_cedis) 
	 )
/*Creación de una subtabla llamada REPARTIDOR. 
Esta subtabla surge de la tabla Personal ya que contamos con empacadores y repartidores*/
Create table REPARTIDOR
 (	DNI  varchar (10) 
         Constraint repartidor_DNI_FK  foreign key
		   references personal(DNI), 
    Licencia_conducir char (15), 
	) 
	
--Creación de la tabla llamada TRANSPORTE.  
Create table TRANSPORTE
 (	matricula  varchar (10) 
         Constraint transporte_matricula_PK  primary key,   
    tipo  varchar (20), 
	capacidad_cargar varchar(10)
	) 

--Creación de la tabla llamada DONADOR_CENTRO 
create table DONADOR_CENTRO
(	codigo_cedis nchar(10) 
	       Constraint donador_centro_codigo_cedis_FK foreign key
		   references centros_distribución(codigo_cedis), 
	DNI_RUC char(20) 
	       Constraint donador_centro_DNI_RUC_FK foreign key
		   references donador(DNI_RUC)
) 
	
--Creación de la tabla llamada DONADOR_INSUMO 
create table DONADOR_INSUMO
(	codigo_donación nchar(10) 
	       Constraint donador_insumo_codigo_donación_FK foreign key
		   references insumos(codigo_donación), 
	DNI_RUC char(20) 
	       Constraint donador_insumo_DNI_RUC_FK foreign key
		   references donador(DNI_RUC)
) 	

--Creación de la tabla llamada REPARTIDOR_TRANSPORTE
create table REPARTIDOR_TRANSPORTE
(	DNI  varchar (10) 
         Constraint repartidor_transporte_DNI_FK  foreign key
		   references personal(DNI),
	matricula  varchar (10) 
         Constraint repartidor_transporte_matricula_FK  foreign key
		  references transporte(matricula)
) 


--Creación de la tabla llamada INSUMO_PERSONAL_IM
Create table INSUMO_PERSONAL_IM
(	codigo_donación nchar(10) 
	       Constraint insumo_personal_IM_codigo_donación_FK foreign key
		   references insumos(codigo_donación), 
	DNI varchar(10) 
	       Constraint insumo_personal_IM_DNI_FK foreign key
		   references personal(DNI), 
	codigo_IM nchar(10) 
	       Constraint insumo_personal_IM_codigo_IM_FK foreign key
		   references instalacion_medica(codigo_IM), 
	Cantidad_llevada smallint, 
	fecha_distribución date
)
--Vamos a insertar 10 tuplas de datos de Persona natural a la tabla DONADOR.  
use PANAMA_SOLIDARIO_SALUD
Insert into DONADOR
values ('8-372-782','Milagros Campos','milyg27@gmail.com', '6345-2727', 'Panamá', 'Panamá','chilibre', 'San lorenzo', 'k105'),
       ('4-367-230','Antonio Castillo','a_castillo@gmail.com','6745-2211','Chiriqui','David','Las lomas','B30','103'), 
	   ('3-654-2120','Ernesto Quintana','quintana.20@hotmail.com','6230-9878','Colon','Portobelo','Isla grande','calle 17','B178'), 
	   ('6-2343-3456','Williams Cordoba','w.cordoba1@hotmail.com','6457-6767','Herrera','Los pozos','La arena','tortuga', 'A-102'), 
	   ('7-7890-1000','Guadalupe Castillo','lupe_15@gmail.com','6440-7000','Los Santos','Macaracas', 'la mesa', 'El porvenir', 'W234'), 
	   ('9-245-2300','Elionays Rosas','e.rosas507@gmail.com','61105678','Veraguas','Cañaza','Los valles', 'El arbol', '20'), 
	   ('5-6078-2311','Cristian Asprilla','c.asprilla@hotmail.com','6500-2284', 'Darien', 'Santa Fe', 'Agua fría', 'calle mar', 'K23'), 
	   ('1-230-112','Solangel Barraza','solangelb@hotmail.com','6734-9800', 'Bocas del toro','Almirante','Barrio Frances','los platanos','345'), 
	   ('2-678-900','Ana Frank','ana120@gmail.com','6522-1143','Coclé', 'Ánton','El chirú','Las cerezas', '200'), 
	   ('8-900-2819','Teresa Rodriguez','teresa.r01@icloud.com','6011-9977','Panamá','Panamá','San francisco','calle 75 oeste','90') 

--Vamos a insertar 10 tuplas de datos de Empresas a la tabla donador.  
Insert into DONADOR
values ('16292-152-155203','Deloitte','deloite_uy@deloitte.com', '209-4567', 'Panamá', 'Panamá','Juan díaz','Santa maria','ph30'),
       ('74-109-110-75', 'Cafe Duran','cafedpanama@cafeduran.com', '217-2233', 'Panamá','Panamá','Juan díaz', 'AveJose Agustin A','L-102'), 
	   ('521-136-1131330', 'Cochez y Cia','acochez@cochezycia.com', '257-9087', 'Panamá','Panamá','San Felipe', 'Ave.Eloy Alfaro','L234'), 
	   ('61238-78-348761', 'Mafre', 'info@mapfre.com.pa.', '347-5000', 'Panamá', 'Panamá', 'Juan díaz', 'Costa del este','BP230'), 
	   ('253525-1-403482 ', 'Caja de ahorros', 'info@cajadeahorros.com.pa','800-2252','Panamá', 'Panamá', 'Bella vista', 'Vía españa', '108'), 
	   ('280-134-61098', 'Banco general', 'info@bgeneral.com.','800-5000', 'Panamá', 'Panamá', 'Bella vista', 'Aquilino guardia', 'BG102'), 
	   ('650-529-126088-77', 'Melo S.A', 'grupomeloS.A@grupomelo.com.pa', '224-2311', 'Panamá','San Miguelito','Brisas del golf', 'Via tocumen','810'), 
	   ('346-266-76470-13','Farmacias arrochas', 'servicioalcliente@arrocha.com', '279-9000', 'Panamá', 'Panamá', 'Ancón', 'Albrook', '10-11'), 
	   ('1290101-1-602845', 'Tradex S,A', 'ruc91@clientestgeorges.com', '214-2376', 'Panamá', 'Panamá', 'Betania', 'Los angeles', '0801'), 
	   ('994855-1-534959-48','Claro Panamá','atencion@claropa.com','800-9100','Panamá', 'Panamá', 'San francisco', 'Punta Pacífica' ,'100-8') 


--Vamos a insertar 20 tuplas de datos a la tabla Insumos 
insert into INSUMOS
values    (37322, 'Bata Desechables', 'Protección', 6400 ),
          (37323, 'Bata AAMI lvl 3', 'Protección', 1040),
          (37324, 'Bata AAMI lvl 4', 'Protección', 900),
          (56790, 'Cama hidraulica', 'Mobiliario', 5),
          (56791, 'Cama hospitalaria', 'Mobiliario', 15),
          (37400, 'Cubre Zapato', 'Protección', 16000),
          (33490, 'Delantal de fluido', 'Protección', 200),
          (33430, 'Gntes de Nitrilo', 'Protección', 10000),
          (33431, 'Gntes de latex', 'Protección', 5000),
          (33432, 'Gntes sin latex', 'Protección', 5000),
          (36782, 'Lentes de prot.', 'Protección', 15000),
          (36767, 'Face Shield', 'Protección', 3000),
          (60943, 'Masc. 3 pliegues', 'Protección', 5000),
          (60944, 'Masc. N95', 'Protección', 30000),
          (47685, 'Ropa medica', 'Protección', 5000),
          (66660, 'Funda de cadaver', 'Protección', 100),
          (56723, 'RespiradorArtificial', 'Mobiliario', 20),
          (45632, 'Red de cabello', 'Protección', 3000),
          (45678, 'Kit diagnostico', 'Medicina', 5000),
          (43908, 'Termo. Digital', 'Mobiliario',100)
	
--Vamos a insertar los datos de los 5 centros de distribución con los que cuenta en estos momentos Panamá Solidario 
Insert into CENTROS_DISTRIBUCIÓN
values (001,'Centro de Convenciones Atlapa', 'Avenida 5B Sur' , '526-7200', 'Panamá'),
        (002,'Gimnasio Orlando Winter', 'San Miguelito', '364-6790', 'San Miguelito'),
        (003,'CEO Aguadulce', 'Calle Molino', '280-2341', 'Aguadulce'),
        (004,'Centro Divisa', 'Divisa', '270-4578', 'Divisa'),
        (005,'IMA', 'San Pablo Viejo', '345-2134', 'David')

--Vamos a insertar 20 tuplas de datos a la tabla transporte
insert into TRANSPORTE
values    ('395741', 'Pick - Up', '1260 lbs' ),
          ('201109', 'C. 2 ejes', '19 TON' ),
          ('188766', 'C. 4 ejes', '32 TON' ),
          ('AS3047', 'C. 3S2', '46 TON' ),
          ('022111', 'C. 3S3', '49 TON' ),
          ('676476', 'C. 3 ejes', '26 TON' ),
          ('275813', 'Pick - Up', '2138 lbs' ),
          ('AG5936', 'Pick - Up', '1260 lbs' ),
          ('676620', 'Pick - Up', '1911 lbs' ),
          ('HP-1762', 'Helicoptero', '7716 lbs' ),
          ('NI626L', 'Helicoptero', '14330 lbs'  ),
          ('AK4700', 'Pick - Up', '1260 lbs' ),
          ('AA5741', 'C. 2 ejes', '19 TON' ),
          ('AA7500', 'Pick - Up', '1260 lbs' ),
          ('663011', 'C. 4 ejes', '32 TON' ),
          ('AX0762', 'Pick - Up', '1260 lbs' ),
          ('465809', 'C. 3 ejes', '26 TON' ),
          ('358429', 'Pick - Up', '2242 lbs' ),
          ('766944', 'Pick - Up', '1984 lbs' ),
          ('BIM-3618', 'Lancha', '2242 lbs' )

--Vamos unir datos de las tabla Donador y centro 
Insert into donador_centro 
values (001,'8-372-782'),  
       (005,'4-367-230'),
	   (001,'3-654-2120'),
	   (004,'6-2343-3456'),
	   (004,'7-7890-1000'),  
	   (004,'9-245-2300'), 
	   (002,'5-6078-2311'),
	   (005,'1-230-112'),
	   (003,'2-678-900'),
	   (002,'8-900-2819'),
	   (001,'16292-152-155203'),
       (001,'74-109-110-75'),
	   (002,'521-136-1131330'),
	   (001,'61238-78-348761'), 
	   (002,'253525-1-403482'),
	   (001,'280-134-61098'),
	   (001,'650-529-126088-77'),
	   (002,'346-266-76470-13'),
	   (002,'1290101-1-602845'),
	   (002,'994855-1-534959-48')

--Vamos a insertar los datos de la tabla Personal. 
--Como podemos observar se utilizo un convertidor para la cambiar de string a fecha. 
insert into PERSONAL
values  ('8-727-945','Carmen', 'Gomez',convert(date,'1995-12-25'), '6346-0214', 'Empacador', 'Panamá',' Panamá', 'Pedregal', 'Villa Lobos', 'E-110', 001),
        ('9-9428-944','Carlos', 'Castillo',convert(date,'1996-10-23'), '6959-8214', 'Empacador','Veraguas','Sona','Guarumal','Los Mangos', 'E12', 004),
        ('7-676-744', 'Fredy', 'Rodriguez',convert(date,'1998-09-30'), '6896-0214', 'Repartidor','Panamá',' Panamá','Pedregal','Nazareno', 'ERT4',001),
        ('8-6061-945','Andrea', 'Tenorio',convert(date,'1987-01-14'), '6006-0124', 'Empacador','Los Santos', 'las Tablas','Las Tablas', 'Nva. Esperanza','EP-34', 003),
        ('8-967-3452','Hanna', 'Rivera', convert(date,'1978-06-27'), '6912-3414', 'Repartidor','Panamá',' Panamá','Pedregal', 'San Joaquin', 'E-110',002),
        ('8-1231-145','Victoria', 'Villareal',convert(date,'1989-05-22'), '6098-0214', 'Empacador','Panamá',' Panamá','Pedregal',  'Villa Lobos', 'JK78',002),
        ('8-321-2352','Javier', 'Romero', convert(date,'1999-03-31'), '6956-0902', 'Repartidor','Panamá',' Panamá', 'Chanis','141 Este', 'E21', 002),
        ('4-678-0956','Ariel', 'Polanco', convert(date,'1999-02-02'), '6756-0289', 'Repartidor','Chiriqui', ' David', 'Pedregal','Salsipuedes', 'V45', 005),
        ('8-076-2311','Tomas', 'Perez',convert(date,'1997-02-01'), '6556-0235', 'Repartidor','Panamá',' Panamá','Pedregal',  'Rana de Oro', 'E-101', 002),
        ('8-724-0685','Emmanuel', 'Miranda', convert(date,'1995-10-13'), '6356-0280', 'Empacador','Panamá Oeste', 'Chorrera','Caimitillo', 'Vereda 5', 'E-S32',001),
        ('8-756-800','José', 'Farrier', convert (date,'1994-10-15'), '6351-2340', 'Repartidor','Panamá', 'Panamá','CDE', 'Calle 124 oeste', 'G56',001),
        ('9-237-1221','Andrea', 'Silva',convert(date,'1996-08-16'), '6906-0280', 'Empacador', 'Veraguas','La mesa','Paraiso', 'Calle el padre', '231', 004),
        ('4-4727-001','Raul', 'Road', convert(date,'1985-12-13'), '6356-0371', 'Empacador', 'Chiriqui','David','Pedregal','la escalera', '345', 005),
        ('5-727-7693','Erick', 'Abrego',convert(date,'1975-06-12'), '6567-4880', 'Empacador','Darien', 'La Palma', 'Caimito','El nance', '901', 002),
        ('8-5678-001', 'Ashley', 'Adames', convert(date,'1989-05-10'), '6456-0200', 'Repartidor','Panamá', 'Juan Diaz', 'Cda. Radial', 'Vereda 8', 'KL90',002),
        ('8-890-122', 'Valery', 'Atencio', convert(date,'1998-11-01'), '6256-0278', 'Empacador', 'Panamá','Don Bosco','Versalles', 'Calle 57', 'GH56',002),
        ('7-456-543', 'Samuel', 'Lewis',convert(date,'1997-12-17'), '6556-0270', 'Repartidor', 'Los Santos','Las Tablas','Calle Arriba', 'Paraiso 3', '632', 004),
        ('8-890-000', 'Emma', 'Tuñon',convert(date,'1993-09-20'), '6156-0283', 'Repartidor', 'Panamá','Chepo','Caimitillo', 'Porvenir', 'S12',002),
        ('8-1200-122','Carolina','Tristan',convert(date,'1992-03-22'), '6256-0284', 'Empacador',  'Panamá Oeste', 'Arraijan', 'Vacamonte', 'La aroboleda', 'VB32',001),
        ('8-7897-944','Pablo', 'Fernandez',convert(date,'1991-10-03'), '6784-0280', 'Empacador', 'Panamá Oeste', 'Chorrera', 'Caimitillo',  'Central', 'S33', 001)

--Vamos a insertar los datos de la tabla Instalación Medica 
Insert into INSTALACION_MEDICA
values  (100, 'Irma de Lourdes T.', '24 de dic', '320-2345', 'Panamá'),
        (200, 'Dr. Arnulfo Arias M.', 'Tansístmica', '295-3880', 'Panamá'),
        (300, 'Manuel Amador G.', 'Avenida Meléndez', '245-2313', 'Colón'),
        (400, 'Aquilino Tejeira', 'Penonomé', '997-9386', 'Coclé'),
        (500, 'Chiriquí', 'Calle Central', '774-0128', 'Chiriquí'),
        (600, 'Nicolas A. Solano', 'La Chorrera', '650-3456', 'Panamá Oeste'),
        (700, 'General Cecilio A.C.', 'Chitré', '340-4789', 'Herrera'),
        (800, 'Anita Moreno', 'Ave. Dr. Belisario P.', '356-8130', 'Los Santos'),
        (900, 'Regional Metetí', 'Metetí', '213-2567', 'Darién'),
        (1000, 'Luis Chico Fábrega', 'Santiago', '567-3489', 'Veraguas')

--Vamos a unir los datos de la tabla DONADOR_INSUMO

alter table donador_insumo 
check constraint[donador_insumo_codigo_donación_FK]

insert into DONADOR_INSUMO
values (56790,'8-372-782'),
       (56791,'4-367-230'),
       (66660,'3-654-2120'),
       (56723,'6-2343-3456'),
       (43908,'7-7890-1000'),
       (33490,'9-245-2300'),
       (37324,'5-6078-2311'),
       (37323,'1-230-112'),
       (33432,'2-678-900'),
       (36782,'8-900-2819'),
       (33431,'16292-152-155203'),
       (36767,'74-109-110-75'),
       (60944,'521-136-1131330'),
       (47685,'61238-78-348761'),
       (45632,'253525-1-403482'),
       (45678,'280-134-61098'),
       (37400,'650-529-126088-77'),
	   (37322,'346-266-76470-13'),
       (33430,'1290101-1-602845'),
       (60943,'994855-1-534959-48')

--Vamos a insertar los datos a la tabla REPARTIDOR
insert into REPARTIDOR
values  ('7-676-744', 'Tipo D'),
        ('8-321-2352', 'Tipo F'),
        ('4-678-0956', 'Tipo F'),
        ('8-076-2311', 'Tipo D'),
        ('8-756-800', 'Tipo G'),
        ('8-5678-001', 'Tipo H'),
        ('7-456-543', 'PilotoComercial'),
        ('8-890-000', 'PilotoComercial')

--Vamos a unir la tabla Repartidor_transporte 
insert into REPARTIDOR_TRANSPORTE
values    ('7-676-744', '201109'),
          ('8-321-2352', 'AS3047'),
          ('4-678-0956', '022111'),
          ('8-076-2311', '766944'),
          ('8-756-800', '465809'),
          ('8-5678-001', '663011'),
          ('7-456-543', 'HP-1762'),
          ('8-890-000', 'NI626L')

--Vamos a unir los datos de la tabla INSUMO_PERSONAL_IM
insert into INSUMO_PERSONAL_IM
values    (37322,'8-1231-145', 200,1000, convert(date, '2020-07-04')),  
          (37323,'4-4727-001', 500,600, convert(date, '2020-07-01')), 
          (37324,'5-727-7693',900,500, convert(date, '2020-06-04')),
          (56790,'4-678-0956',200, 2, convert(date, '2020-05-20')),
          (56791,'8-756-800',500,5, convert(date,'2020-07-15')),
          (37400,'8-727-945',100,2000,convert(date,' 2020-07-10')),
          (33490,'9-9428-944',1000,50,convert(date, '2020-07-15')),
          (33430,'8-890-122',100,250, convert(date, '2020-05-30')),
          (33431,'8-7897-944',200, 1500, convert(date, '2020-06-12')),
          (33432,'7-456-543',400,1500, convert(date, '2020-07-12')),        
          (36782,'7-676-744',200,1500, convert(date, '2020-07-09')),
          (36767,'8-321-2352',100,500, convert(date,'2020-04-20')),
          (60943,'8-890-000',100,600, convert(date, '2020-07-05')),
          (60944,'8-967-3452',200, 1000,convert(date,'2020-07-20')),
          (47685,'8-076-2311',600, 800, convert(date, '2020-06-17')),
          (66660,'8-321-2352',300,40,convert(date, '2020-07-15')),
          (56723,'8-6061-945',700, 5, convert(date, '2020-07-01')),
          (45632,'8-724-0685',400, 2000, convert(date, '2020-07-18')),
          (45678,'8-1200-122',900,1500, convert(date, '2020-07-19')),
          (43908,'8-5678-001',800, 50, convert(date,'2020-07-10'))
	
