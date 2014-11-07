package organizador.partidos.jugador

import organizador.partidos.partido.Partido

class Solidario implements Tipo {

	int prioridad = 2

	override def dameTuPrioridad() {
		this.prioridad
	}

	var Jugador jugador

	override inscribirseA(Partido partido) {
		if (partido.plazaLlenaNoAsegurada) {
			partido.quitaUno()
			partido.agregar(this.jugador)

		} else {
			!(partido.plazaLlena)
		}
		partido.agregar(this.jugador)
	}

	/*no ponemos de condicion si la plazallenaasegurada porque ahi no lo agregaria y listo */
	override setJugador(Jugador jugador) {
		this.jugador = jugador
	}
}
