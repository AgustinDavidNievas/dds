package organizador.partidos.jugador

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import organizador.partidos.partido.Partido
import javax.persistence.DiscriminatorValue

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
	
	
}
