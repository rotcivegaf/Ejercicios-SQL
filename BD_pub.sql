create database pub;
use pub;

-- Borrar todo primero


-- Ahora crear

CREATE TABLE autores
(
   au_id        char(11)          NOT NULL,
   au_apellido  varchar(40)       NOT NULL,
   au_nombre    varchar(20)       NOT NULL,
   telefono     char(12)          NOT NULL,
   direccion    varchar(40)           NULL,
   ciudad       varchar(20)           NULL,
   estado       char(2)               NULL,
   codigopostal char(5)               NULL,
   contrato     bit               NOT NULL,
     PRIMARY KEY(au_id)
);

CREATE TABLE editorial
(
   ed_id    char(4)           NOT NULL,
   ed_name  varchar(40)           NULL,
   ciudad   varchar(20)           NULL,
   estado   char(2)               NULL,
   pais     varchar(30)           NULL,
	PRIMARY KEY(ed_id)
);

CREATE TABLE libros
(
   libro_id       char(6),
   titulo         varchar(80)       NOT NULL,
   clasificacion  char(12)          NOT NULL DEFAULT 'SIN DECIDIR',
   ed_id          char(4)               NULL,
   precio         int                   NULL,
   anticipo       int                   NULL,
   rega           int                   NULL,
   total_ventas   int                   NULL,
   resumen        varchar(200)          NULL,
   fechapub       timestamp          NOT NULL DEFAULT CURRENT_TIMESTAMP,
     PRIMARY KEY(libro_id),
     FOREIGN KEY(ed_id) REFERENCES editorial(ed_id)
);

CREATE TABLE libroautor
(
   au_id    char(11),
   libro_id char(6),
   au_ord   tinyint               NULL,
   regaper  int                   NULL,
	PRIMARY KEY (au_id, libro_id),
	FOREIGN KEY (au_id) REFERENCES autores (au_id),
	FOREIGN KEY (libro_id) REFERENCES libros (libro_id)
);

CREATE TABLE tiendas
(
   tienda_id        char(4)           NOT NULL,
   tienda_nombre    varchar(40)           NULL,
   tienda_direccion varchar(40)           NULL,
   ciudad           varchar(20)           NULL,
   estado           char(2)               NULL,
   codigopostal     char(5)               NULL,
	PRIMARY KEY (tienda_id)
);

CREATE TABLE ventas
(
   tienda_id  char(4)           NOT NULL,
   ord_num    varchar(20)       NOT NULL,
   fecha_ord  timestamp         NOT NULL,
   qty        smallint          NOT NULL,
   terminospa varchar(12)       NOT NULL,
   libro_id   char(6),
	FOREIGN KEY (tienda_id) REFERENCES tiendas(tienda_id),
	FOREIGN KEY (libro_id) REFERENCES libros(libro_id),
	PRIMARY KEY (tienda_id,ord_num,libro_id)
);

CREATE TABLE regalias
(
   libro_id char(6),
   lorange  int                   NULL,
   hirange  int                   NULL,
   rega     int                   NULL,
	FOREIGN KEY (libro_id) REFERENCES libros(libro_id)
);

CREATE TABLE descuentos
(
   tipodescuento  varchar(40)       NOT NULL,
   tienda_id      char(4)				NULL,
   bajaqty        smallint              NULL,
   altaqty        smallint              NULL,
   descuento      dec(4,2)          NOT NULL,
	FOREIGN KEY (tienda_id) REFERENCES tiendas(tienda_id)
);

CREATE TABLE cargo
(
   car_id   smallint          NOT NULL,
   car_desc varchar(50)       NOT NULL DEFAULT 'Nueva - Aun no formalizado',
   min_lvl  tinyint           NOT NULL,
   max_lvl  tinyint           NOT NULL,
	PRIMARY KEY (car_id         )
);

CREATE TABLE empleado
(
   emp_id       char(9),
   nombre       varchar(20)       NOT NULL,
   inic         char(1)               NULL,
   apellido     varchar(30)       NOT NULL,
   car_id       smallint          NOT NULL DEFAULT 1,
   car_lvl      tinyint           NOT NULL DEFAULT 1,
   ed_id        char(4)           NOT NULL DEFAULT 2,
   fecha_inicio timestamp         NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (emp_id),
	FOREIGN KEY (ed_id) REFERENCES editorial(ed_id),
	FOREIGN KEY (car_id         ) REFERENCES cargo(car_id         )
);

Commit;

INSERT INTO autores (au_id, au_apellido, au_nombre, telefono, direccion, ciudad, estado, codigopostal, contrato) VALUES
(1,'Perez','Gustavo','1154666666','','','SO','',1),
(2,'Garcia','Juan','11636666','','','CA','',1),
(3,'Perez','Carlos','1154456666','','','VI','',1),
(4,'Fernandez','Paula','115324456666','','','CA','',1),
(5,'Velez','Alfredo','115445633666','','','NN','',1);

INSERT INTO editorial(ed_id, ed_name, ciudad, estado, pais) VALUES
(1,'Continental','Capital Federal','BA','Argentina'),
(2,'America','Capital Federal','BA','Argentina'),
(3,'Libre','Cordoba','CO','Argentina'),
(4,'El Gringo','Miami','MI','Estados Unidos'),
(5,'Colombian','Bogota','BO','Colombia');

INSERT INTO libros(libro_id, titulo, clasificacion, ed_id, precio, anticipo, rega, total_ventas, resumen, fechapub) VALUES
('000009', 'Casper'             , 'Infantil', 4, 40  , 20  , 35  , 5000 ,'es un fantasmita'             , '1970-10-24 09:52:00'),
('000666', 'Satanic'            , 'Terror'  , 5, 200 , 50  , 190 , 666  ,'el mismisimo diablo'          , '1996-06-06 06:06:06'),
('000002', 'Gold'               , 'Rico'    , 3, 5000, 2000, 4800, 51   ,'las recetas del alquimista'   , '2010-12-20 10:41:55'),
('000003', 'Cheeper'            , 'Pobre'   , 2, 1   , 0.1 , 0.75, 2516 ,'un pobreton en la cuidad'     , '1990-01-23 15:41:55'),
('000004', 'La naranja Mecanica', 'Adultos' , 2, 65  , 30  , 60  , 30333,'el mundo de la ultraviolencia', '2017-10-24 16:41:55'),
('000005', 'Hobbit'             , 'Fantacia', 1, 99  , 23  , 89  , 10000,'un viaje inesperado'          , '2010-05-30 09:41:55');

INSERT INTO libroautor(au_id, libro_id) VALUES
(1, '000002'),
(1, '000003'),
(2, '000666'),
(3, '000005'),
(4, '000004'),
(5, '000009');

INSERT INTO tiendas (tienda_id, tienda_nombre) VALUES
(1, 'librosTec'),
(2, 'librosTec2'),
(3, 'todostuslibro'),
(4, 'booker');

INSERT INTO ventas (tienda_id, ord_num, fecha_ord, qty, terminospa, libro_id) VALUES
(1, '000256', '2017-05-23 09:41:55', 666, 'efectivo', '000666'),
(4, '000695', '2016-07-25 09:41:55', 6, 'tarjeta', '000002'),
(3, '000584', '2017-05-30 09:41:55', 66, 'efectivo', '000009'),
(4, '000369', '2017-04-11 09:41:55', 52, 'efectivo', '000009'),
(3, '152632', '2017-06-15 09:41:55', 12, 'tarjeta', '000004'),
(3, '955844', '2017-04-11 09:41:55', 1, 'efectivo', '000005'),
(2, '415166', '2017-07-12 09:41:55', 32, 'tarjeta', '000004'),
(2, '154626', '2017-06-13 09:41:55', 90, 'efectivo', '000002');

INSERT INTO regalias (libro_id) VALUES
('000009'),
('000004'),
('000666'),
('000002'),
('000005'),
('000004');

INSERT INTO descuentos (tipodescuento, tienda_id, descuento) VALUES
('regalo', 1, 10.3),
('socio', 2, 15),
('regalo', 4, 33.3),
('regalo', 3, 15.3),
('socio', 1, 20),
('socio', 2, 22),
('fallo', 3, 50),
('socio', 4, 20);

INSERT INTO cargo (car_id, car_desc, min_lvl, max_lvl) VALUES
(1, 'encargado', 1, 5),
(2, 'limpieza y mantenimiento', 1, 1),
(3, 'cajero', 1, 3);


INSERT INTO empleado (emp_id, nombre, apellido, car_id, car_lvl) VALUES
(1, 'pepe', 'salva', 1, 1),
(2, 'juan', 'perez', 3, 1),
(3, 'pablo', 'carballo', 2, 1),
(4, 'jose', 'quiebra', 2, 1),
(5, 'alfonsa', 'cuesta', 3, 1);

Commit;
