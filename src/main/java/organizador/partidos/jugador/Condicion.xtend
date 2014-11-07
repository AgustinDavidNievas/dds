package organizador.partidos.jugador

import organizador.partidos.partido.Partido

interface Condicion {
	
	def boolean puedeInscribirse(Partido partido)
	
}