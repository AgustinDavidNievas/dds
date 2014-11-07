package organizador.partidos.jugador

class Postulante extends Jugador {
	
	@Property String nombre

	new(String nombre, Tipo tipo, int edad) {
		super(nombre, tipo, edad)
	}

	def comoJugador() {
		return Jugador.crearJugador(this)
	}
}
