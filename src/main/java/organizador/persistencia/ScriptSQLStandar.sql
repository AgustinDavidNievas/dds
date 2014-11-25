DROP table Public.TL_Partudo;
DROP table Public.TL_Juagador;
DROP table Public.TL_Tipo;
DROP table PUBLIC.TL_Infraccion;
DROP table PUBLIC.TL_PartidoConfirmadoObserver;
DROP table PUBLIC.TL_NuevoInscriptoObserver;
DROP table Public.TL_Admin;
DROP table Public.TL_Mail;
DROP table Public.TL_EnviadorDeMails;
DROP table Public.TL_InfraccionSeDADEBajaSinRemplazante;
DROP table Public.TL_Postulante;
DROP table Public.TL_Rechazo;
DROP table Public.TL_Condicion;


CREATE TABLE PUBLIC.TL_Condicion (

			ID_Condicion nvarchar(50),
			Discriminador varchar(50),
			Edad_Max numeric(3,0),
			Edad_Min numeric(3,0),
			Peo numeric(3,0),
			Turno nvarchar(50)
);

 CREATE TABLE Public.TL_Tipo(
    ID_Tipo INTEGER PRIMARY KEY,
    Prioridad int,
    Descripcion nvarchar(65)
);


CREATE TABLE PUBLIC.TL_EnviadorDeMails(

			ID_EnviadorDeMails nvarchar(50)
			
);

CREATE TABLE PUBLIC.TL_MAIL(

			ID_Mail nvarchar(50),
			ID_Emisor nvarchar(50),
			ID_Usuario nvarchar(50),
			Fecha_Envio datetime,
			Subject varchar(255),
			Body varchar(255),
			FOREIGN KEY ID_Emisor REFERENCES PUBLIC.TL_Mail ID_Emisor,
			FOREIGN KEY ID_Usuario REFERENCES PUBLIC.TL_Mail ID_Usuario

);



CREATE TABLE PUBLIC.TL_Partido(
    ID_Partido INTEGER PRIMARY KEY,
    Fecha datetime,
    Lugar NVARCHAR(64),
    Hora datetime,
    FechaDePartido datetime,
    ID_Admin nvarchar(50),
    Mail_admin varchar(50),
    Mail_avisoJugadores varchar(50),
    ID_EnviadorDeMails nvarchar(50),
    FOREIGN KEY Mail_admin REFERENCES PUBLIC.TL_Mail Mail_admin,
    FOREIGN KEY Mail_avisoJugadores REFERENCES PUBLIC.TL_Mail Mail_avisoJugadores,
    FOREIGN KEY ID_EnviadorDeMails REFERENCES PUBLIC.TL_EnviadorDeMails ID_EnviadorDeMails,
    );



CREATE TABLE PUBLIC.TL_Jugador(
ID_Jugador NUMERIC(18,0) PRIMARY KEY,
ID_Tipo NUMERIC(18,0) NOT NULL,
Partido_a_Jugar NUMERIC(18,0),
ID_Amigo NUMERIC(18,0),
ID_Estado NUMERIC(18,0) NOT NULL,
Apodo NVARCHAR(55),
Nombre NVARCHAR(55),
Apellido NVARCHAR(55),
Peso INT,
Correo NVARCHAR(64),
Edad INT,
Fecha_Nacimiento DATETIME,
Handicap INT,
Promedio_Ultimo_Partido INT,
Promedio_Todos_Partidos INT,
Partidos_Jugados INT,
FOREIGN KEY ID_Tipo REFERENCES PUBLIC.TL_Tipo ID_Tipo,
FOREIGN KEY ID_Amigo REFERENCES PUBLIC.TL_Jugador ID_Jugador,
FOREIGN KEY Partido_a_Jugar REFERENCES PUBLIC.TL_Partido ID_Partido
);

CREATE TABLE PUBLIC.TL_PartidoConfirmadoObserver(
			ID_PartidoObserver nvarchar(50) PRIMARY key,
			PartidoConfirmado varchar(2),
			ID_EnviadorDeMails nvarchar(50),
			Mail_admin varchar(50),
FOREIGN KEY ID_EnviadorDeMails REFERENCES PUBLIC.TL_EnviadorDeMails ID_EnviadorDeMails,
FOREIGN KEY Mail_admin REFERENCES PUBLIC.TL_Mail Mail_admin
);

CREATE TABLE PUBLIC.TL_NuevoInscriptoObserver (

			ID_NuevoInscriptoObserver nvarchar(50),
			Mail_admin varchar(50),
			ID_EnviadorDeMails nvarchar(50),
FOREIGN KEY ID_EnviadorDeMails REFERENCES PUBLIC.TL_EnviadorDeMails ID_EnviadorDeMails,
FOREIGN KEY Mail_admin REFERENCES PUBLIC.TL_Mail Mail_admin
			
);
			
CREATE TABLE PUBLIC.TL_InfraccionSeDADEBajaSinRemplazante(

			ID_InfraccionSeDADEBajaSinRemplazante nvarchar(50),
			Nro_infraccion numeric(18,0),
			Fecha datetime,
			Descripcion nvarchar(255),
			ID_Jugador nvarchar(50),
			FOREIGN KEY ID_Jugador REFERENCES PUBLIC.TL_Jugador ID_Jugador
			

);


CREATE TABLE PUBLIC.TL_Admin(

			ID_Admin nvarchar(50),
			Correo varchar(255),
			ID_Partido nvarchar(50),
			ID_Condicion nvarchar(50),
			FOREIGN KEY ID_Partido REFERENCES PUBLIC.TL_Partido ID_Partido
			FOREIGN KEY ID_Condicion REFERENCES PUBLIC.TL_Condicion ID_Condicion
);

CREATE TABLE PUBLIC.TL_Postulante(

			ID_Postulante nvarchar(50),
			Nombre varchar(255),
			ID_Admin nvarchar(50),
			FOREIGN KEY ID_Admin REFERENCES PUBLIC.TL_Admin ID_Admin

);



CREATE TABLE PUBLIC.TL_Rechazo (

			ID_Rechazo nvarchar(50),
			Descripcion varchar(255),
			Fecha datetime,
			ID_Postulante nvarchar(50),
			ID_Admin nvarchar(50),
			FOREIGN KEY ID_Postulante REFERENCES PUBLIC.TL_Postulante ID_Postulante
			FOREIGN KEY ID_Admin REFERENCES PUBLIC.TL_Admin ID_Admin
);


			
			

			