package organizador.partidos.jugador

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import organizador.partidos.partido.Partido
import javax.persistence.DiscriminatorValue

@Entity
@DiscriminatorValue("E")
class CondicionEdad extends Condicion {

	@Property int edadMaxima
	@Property int edadMinima

	override puedeInscribirse(Partido partido) {

		partido.inscriptos.forall[jugadores|jugadores.edad > this.edadMinima && jugadores.edad < this.edadMaxima]

	//devuelve un booleano
	}

	new(int edadMinima, int edadMaxima) {
		this.edadMaxima = edadMaxima
		this.edadMinima = edadMinima
	}

	new() {

		//lo necesita hibernate
		super()
	}

}
