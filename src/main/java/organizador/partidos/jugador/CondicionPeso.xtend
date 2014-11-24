package organizador.partidos.jugador

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import organizador.partidos.partido.Partido

@Entity
@DiscriminatorValue("P")
class CondicionPeso extends Condicion {
	
	
	@Property int peso

	override puedeInscribirse(Partido partido) {

		partido.inscriptos.forall[jugadores|jugadores.peso >= this.peso]

	}

	new(int peso) {

		this.peso = peso
	}

	new() {

		//lo necesita hibernate
		super()
	}

}
