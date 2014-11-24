package organizador.partidos.jugador

import javax.persistence.Id
import javax.persistence.GeneratedValue
import java.io.Serializable
import javax.persistence.Entity

@Entity
class Postulante extends Jugador implements Serializable {
	
	@Id
	@GeneratedValue
	@Property Integer id
	
	@Property String nombre

	new(String nombre, Tipo tipo, int edad) {
		super(nombre, tipo, edad)
	}

	def comoJugador() {
		return Jugador.crearJugador(this)
	}
}
