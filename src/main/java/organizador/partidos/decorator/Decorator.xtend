package organizador.partidos.decorator

import organizador.partidos.partido.Partido
import organizador.partidos.jugador.Jugador

class Decorator extends Partido {

	@Property Partido decorado
	@Property Partido partido //parche para que los decorators funcionen en ambas direcciones

	override inscribir(Jugador unJugador) {
		unJugador.tipo.inscribirseA(this.decorado)
	}
}
