package organizador.partidos.jugador

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import organizador.partidos.partido.Partido
import javax.persistence.Basic
import javax.persistence.Column
import java.io.Serializable

@Entity
@DiscriminatorValue("P")
class CondicionPeso extends Condicion implements Serializable {
	
	@Basic
	@Column(name = "PESO")
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
