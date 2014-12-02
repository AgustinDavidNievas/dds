package organizador.partidos.jugador

import java.io.Serializable
import javax.persistence.Entity
import javax.persistence.Column

@Entity
class Postulante extends Jugador implements Serializable {
	
//	@Column(name="nombre")	 //ya hereda el nombre de jugador
//	@Property String nombre

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
