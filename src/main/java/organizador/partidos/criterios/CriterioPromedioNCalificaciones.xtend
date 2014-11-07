package organizador.partidos.criterios

import organizador.partidos.jugador.Jugador

class CriterioPromedioNCalificaciones extends Criterios {

	@Property int numero
	
	new(int i) {
		this.numero = i
	}


	def NumeroDeCalificaciones(int numeroDeCalificaciones) {
		this.numero = numeroDeCalificaciones
	}

	override aplicarCriterio(Jugador jugador) {
		(jugador.listaDeCalificaciones.take(numero).fold(0)[a, b|a + b]) / numero
	}

}
