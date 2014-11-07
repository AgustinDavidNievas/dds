package organizador.partidos.jugador

import organizador.partidos.partido.Partido

class CondicionEdad implements Condicion {

@Property int edadMaxima
@Property int edadMinima

	override puedeInscribirse(Partido partido) {
		
	partido.inscriptos.forall[jugadores | jugadores.edad > this.edadMinima && jugadores.edad < this.edadMaxima] 
		//devuelve un booleano
		
	}
	
new(int edadMinima, int edadMaxima){
	this.edadMaxima = edadMaxima
	this.edadMinima = edadMinima
}

	
}