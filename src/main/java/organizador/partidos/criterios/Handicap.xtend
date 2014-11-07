package organizador.partidos.criterios

import organizador.partidos.jugador.Jugador

class Handicap extends Criterios{
	
	@Property String nombre
	
	new(){
		super()
	}
	
	new(String nombreDelCriterio){
		this.nombre = nombreDelCriterio
	}
	
	def definirHandicap(Jugador jugador,int handicap) {
		jugador.handicap = handicap
	}
	
	override aplicarCriterio(Jugador jugador) {
		jugador.handicap
	}
	
}