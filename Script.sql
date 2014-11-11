DROP TABLE IF EXISTS `TL_Tipo`;
DROP TABLE IF EXISTS `TL_Jugador`;
DROP TABLE IF EXISTS `TL_Partido`;

CREATE TABLE `TL_Tipo`(
	`ID_Tipo` int NOT NULL AUTO_INCREMENT,
	`Prioridad` int,
	`Descripcion` nvarchar(65),
	PRIMARY KEY (`ID_Tipo`)
)ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;



LOCK TABLES `TL_Tipo` WRITE;
INSERT INTO `TL_Tipo` (ID_Tipo)
VALUES (1), (2), (3);

INSERT INTO `TL_Tipo` (Prioridad)
VALUES (1), (2), (3);

INSERT INTO `TL_Tipo` (Descripcion)
VALUES ('Estandar'), ('Solidario'), ('Condicional');

UNLOCK TABLES;


CREATE TABLE TL_Partido(
    `ID_Partido` int NOT NULL AUTO_INCREMENT,
    `Fecha` datetime,
    `Lugar` NVARCHAR(64),
    `Hora` datetime,
    PRIMARY KEY (`ID_Partido`)
)ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;


LOCK TABLES `TL_Partido` WRITE;

/*TODO: insertar fecha en formato y bla */
INSERT INTO `TL_Partido` (`ID_Partido`) VALUES (1)

UNLOCK TABLES;


CREATE TABLE `TL_Jugador`(
`ID_Jugador` int NOT NULL AUTO_INCREMENT,,
`ID_Tipo` int NOT NULL, -- Pide que se debe lockear o algo asi
`Partido_a_Jugar` int,
`Apodo` NVARCHAR(55),
`Nombre` NVARCHAR(55),
`Apellido` NVARCHAR(55),
`Peso` INT,
`Correo` NVARCHAR(64),
`Edad` INT,
`Fecha_Nacimiento` DATETIME,
`Handicap` INT,
`Promedio_Ultimo_Partido` INT,
`Promedio_Todos_Partidos` INT,
`Partidos_Jugados` INT,
`Numero_de_Equipo` INT DEFAULT NULL,
PRIMARY KEY (`ID_Jugador`),
FOREIGN KEY (`ID_Tipo`) REFERENCES `TL_Tipo` (`ID_Tipo`),
FOREIGN KEY (`Partido_a_Jugar`) REFERENCES `TL_Partido` (`ID_Partido`)
)ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;




LOCK TABLES `TL_Jugador` WRITE;
INSERT INTO `TL_Jugador` (`ID_Jugador`, `ID_Tipo`, `Partido_a_Jugar`, `Apodo`, `Nombre`, `Apellido`, 
						`Peso`, `Correo`, `Edad`, `Handicap`, `Promedio_Ultimo_Partido`, `Promedio_Todos_Partidos` ,`Partidos_Jugados` )VALUES 
										(1, 1, 1, 'Tito', 'Roberto', 'Gomez', 20, 'titogom@gmail.com', 21, 80, 21, 21, 3),
										(2, 1, 1, 'Jor', 'Jorge', 'Gomez', 20, 'jorgom@gmail.com', 21, 80, 21, 21, 3),
										(3, 1, 1, 'Juancho', 'Juan', 'Gonzalez', 20, 'juangon@gmail.com', 21, 80, 21, 21, 3), (1, 1, 1, 'Pepe', 'Pedro', 'charaez', 20, 'peterchar@gmail.com', 21, 80, 21, 21, 3),
										(4, 1, 1, 'Pepito', 'Pedro', 'Trepin', 20, 'Petre@gmail.com', 21, 80, 21, 21, 3),
										(5, 1, 1, 'Elsa', 'Ernesto', 'Saragosa', 20, 'ernesa@gmail.com', 21, 80, 21, 21, 3),
										(6, 1, 1, 'Pipo', 'Pingacho', 'Kirin', 20, 'pipokirin@gmail.com', 21, 80, 21, 21, 3),
										(7, 1, 1, 'Sebas', 'Sebastian', 'Caripela', 20, 'sebacar@gmail.com', 21, 80, 21, 21, 3),
										(8, 1, 1, 'Pepito', 'Pedro', 'Trepin', 20, 'Petre@gmail.com', 21, 80, 21, 21, 3),
										(9, 1, 1, 'Elsa', 'Ernesto', 'Saragosa', 20, 'ernesa@gmail.com', 21, 80, 21, 21, 3),
										(10, 1, 1, 'Pipo', 'Pingacho', 'Kirin', 20, 'pipokirin@gmail.com', 21, 80, 21, 21, 3),;
UNLOCK TABLES;						