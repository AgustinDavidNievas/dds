package organizador.partidos.creador

import java.util.List
import organizador.partidos.creador.CreadorDeEquipos
import organizador.partidos.jugador.Jugador

class CreadorAlgoritmo1 extends CreadorDeEquipos {

	@Property List<Jugador> equipo1
	@Property List<Jugador> equipo2
	@Property String nombre


	override crearEquiposTentativos(List<Jugador> listaDeJugadores) {

		inicializarEquiposTentativos()
		jugadoresImpares(listaDeJugadores)
		jugadoresPares(listaDeJugadores)
	}

	def jugadoresPares(List<Jugador> listaDeJugadores) {
		this.equipo2.add(0, listaDeJugadores.get(1))
		this.equipo2.add(1, listaDeJugadores.get(3))
		this.equipo2.add(2, listaDeJugadores.get(5))
		this.equipo2.add(3, listaDeJugadores.get(7))
		this.equipo2.add(4, listaDeJugadores.get(9))
	}

	def jugadoresImpares(List<Jugador> listaDeJugadores) {
		this.equipo1.add(0, listaDeJugadores.get(0))
		this.equipo1.add(1, listaDeJugadores.get(2))
		this.equipo1.add(2, listaDeJugadores.get(4))
		this.equipo1.add(3, listaDeJugadores.get(6))
		this.equipo1.add(4, listaDeJugadores.get(8))
	}

	def inicializarEquiposTentativos() {
		this.equipo1 = newArrayList
		this.equipo2 = newArrayList
	}

	override verEquipoTentativo1() {
		this.equipo1
	}

	override verEquipoTentativo2() {
		return equipo2
	}
}
