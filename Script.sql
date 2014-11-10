DROP TABLE IF EXISTS `TL_Tipo`;
DROP TABLE IF EXISTS `TL_Jugador`;
DROP TABLE IF EXISTS `TL_Partido`;

CREATE TABLE `TL_Tipo`(
	`ID_Tipo` NUMERIC(18,0) NOT NULL AUTO_INCREMENT,
	`Prioridad` int,
	`Descripcion` nvarchar(65),
	PRIMARY KEY (`ID_Tipo`)
)ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;



LOCK TABLES `TL_Tipo` WRITE;
INSERT INTO `TL_Tipo` (ID_Tipo)
VALUES (“1”), (“2”), (“3”);

INSERT INTO `TL_Tipo` (Prioridad)
VALUES (“1”), (“2”), (“3”);

INSERT INTO `TL_Tipo` (Descripcion)
VALUES (“Estandar”), (“Solidario”), (“Condicional”);

UNLOCK TABLES;


CREATE TABLE TL_Partido(
    `ID_Partido` NUMERIC(18,0) NOT NULL AUTO_INCREMENT,
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
`ID_Jugador` NUMERIC(18,0) NOT NULL AUTO_INCREMENT,,
`ID_Tipo` NUMERIC(18,0) NOT NULL,
`Partido_a_Jugar` NUMERIC(18,0),
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
						`Peso`, `Correo`, `Edad`, `Handicap`, `Promedio_Ultimo_Partido`, `Promedio_Todos_Partidos` ,`Partidos_Jugados` )VALUES (1, 1, 1, 'Tito', 'Roberto', 'Gomez', 20, 'titogom@gmail.com', 21, 80, 21, 21, 3);
UNLOCK TABLES;						