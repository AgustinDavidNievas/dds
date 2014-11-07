package organizador.partidos.jugador

import organizador.partidos.partido.Partido

class CondicionTurno implements Condicion {

@Property String turno

	override puedeInscribirse(Partido partido) {
		
	partido.turno == this.turno 
		
		
	}
	
new(String turno){
	this.turno = turno
}

	
}