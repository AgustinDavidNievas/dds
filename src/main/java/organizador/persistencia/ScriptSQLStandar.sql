CREATE TABLE PUBLIC.TL_Partido(
    ID_Partido INTEGER PRIMARY KEY,
    Fecha datetime,
    Lugar NVARCHAR(64),
    Hora datetime
    );
/*
CREATE TABLE [Grupo5].[TL_Tipo](
    ID_Tipo INTEGER PRIMARY KEY,
    Prioridad int,
    Descripcion nvarchar(65)
);


CREATE TABLE [PUBLIC].[TL_Jugador](
[ID_Jugador] NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
[ID_Tipo] NUMERIC(18,0) NOT NULL,
[Partido_a_Jugar] NUMERIC(18,0),
[ID_Amigo] NUMERIC(18,0),
[ID_Estado] NUMERIC(18,0) NOT NULL,
[Apodo] NVARCHAR(55),
[Nombre] NVARCHAR(55),
[Apellido] NVARCHAR(55),
[Peso] INT,
[Correo] NVARCHAR(64),
[Edad] INT,
[Fecha_Nacimiento] DATETIME,
[Handicap] INT,
[Promedio_Ultimo_Partido] INT,
[Promedio_Todos_Partidos] INT,
[Partidos_Jugados] INT,
FOREIGN KEY (ID_Tipo) REFERENCES [PUBLIC].[TL_Tipo] (ID_Tipo),
FOREIGN KEY (ID_Amigo) REFERENCES [PUBLIC].[TL_Jugador] (ID_Jugador),
FOREIGN KEY (Partido_a_Jugar) REFERENCES [PUBLIC].[TL_Partido] (ID_Partido)
);*/

