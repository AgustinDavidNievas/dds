package organizador.partidos.jugador

import java.io.Serializable
import javax.persistence.Entity

@Entity
class Postulante extends Jugador implements Serializable {
	
	
	@Property String nombre

	new(String nombre, Tipo tipo, int edad) {
		super(nombre, tipo, edad)
	}

	def comoJugador() {
		return Jugador.crearJugador(this)
	}
	
	new(){
		super()
	}
}
