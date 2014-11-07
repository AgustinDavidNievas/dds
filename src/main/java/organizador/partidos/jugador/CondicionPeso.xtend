package organizador.partidos.jugador

import organizador.partidos.partido.Partido

class CondicionPeso implements Condicion {
@Property int peso
	
	override puedeInscribirse(Partido partido){
		
		partido.inscriptos.forall[jugadores | jugadores.peso >= this.peso]
		
		
	}
	
	new(int peso){
		
	this.peso = peso 
						}
	
}