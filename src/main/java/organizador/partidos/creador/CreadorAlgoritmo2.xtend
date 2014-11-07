package organizador.partidos.creador

import organizador.partidos.jugador.Jugador
import java.util.List

class CreadorAlgoritmo2 extends CreadorDeEquipos {

	@Property List<Jugador> equipo1
	@Property List<Jugador> equipo2

	override crearEquiposTentativos(List<Jugador> listaDeJugadores) {

		inicializarEquiposTentativos()
		jugadoresDeEquipo1(listaDeJugadores)
		jugadoresDeEquipo2(listaDeJugadores)
	}

	def jugadoresDeEquipo2(List<Jugador> listaDeJugadores) {
		this.equipo2.add(0, listaDeJugadores.get(0))
		this.equipo2.add(1, listaDeJugadores.get(3))
		this.equipo2.add(2, listaDeJugadores.get(4))
		this.equipo2.add(3, listaDeJugadores.get(7))
		this.equipo2.add(4, listaDeJugadores.get(8))
	}

	def jugadoresDeEquipo1(List<Jugador> listaDeJugadores) {
		this.equipo1.add(0, listaDeJugadores.get(1))
		this.equipo1.add(1, listaDeJugadores.get(2))
		this.equipo1.add(2, listaDeJugadores.get(5))
		this.equipo1.add(3, listaDeJugadores.get(6))
		this.equipo1.add(4, listaDeJugadores.get(9))
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
	
