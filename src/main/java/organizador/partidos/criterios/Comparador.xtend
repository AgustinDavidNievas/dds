package organizador.partidos.criterios

import java.util.Comparator
import organizador.partidos.jugador.Jugador

class Comparador implements Comparator<Jugador> {
	
	override compare(Jugador unJugador, Jugador otroJugador) {
		 
		return new Integer(unJugador.handicap).compareTo(new Integer(otroJugador.handicap))
	
	}
	
}