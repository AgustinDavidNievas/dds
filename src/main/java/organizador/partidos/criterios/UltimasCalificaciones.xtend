package organizador.partidos.criterios

import organizador.partidos.jugador.Jugador

class UltimasCalificaciones extends Criterios {

	override aplicarCriterio(Jugador jugador) {

		(jugador.calificacionesDelUltimoPartido.fold(0)[a, b|a + b]) /
			(jugador.calificacionesDelUltimoPartido.size)

	}
}
