package organizador.partidos.jugador

import organizador.partidos.partido.Partido
import organizador.partido.excepciones.EstaCompletoException
import organizador.partido.excepciones.NoCumpleCondicionParaInscribirseException

class Condicional implements Tipo {

	int prioridad = 3

	override def dameTuPrioridad() {
		this.prioridad
	}

	var Jugador jugador

	@Property Condicion condicion

	new() {
		super()
	}

	new(Condicion condicion) {
		this.condicion = condicion
	}

	override inscribirseA(Partido partido) {
		if ((!(partido.plazaLlena)) && this.cualEsTuCondicion().puedeInscribirse(partido)) {
			partido.agregar(this.jugador)
		} else {
			if (partido.plazaLlena) {
				throw new EstaCompletoException("Partido Lleno")
			} else {
				throw new NoCumpleCondicionParaInscribirseException("algun jugador no cumple la condicion solicitada")

			}
		}

	}

	def puedeInscribirse(Partido partido) {
	}

	override setJugador(Jugador tuJugador) {
		this.jugador = tuJugador
	}

	def getJugador() {
		this.jugador
	}

	def cualEsTuCondicion() {
		this.condicion
	}

}
