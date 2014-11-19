package organizador.partidos.jugador

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import organizador.partidos.partido.Partido
import javax.persistence.DiscriminatorValue

@Entity
@DiscriminatorValue("T")
class CondicionTurno extends Condicion {

	@Property String turno

	override puedeInscribirse(Partido partido) {

		partido.turno == this.turno

	}

	new(String turno) {
		this.turno = turno
	}

}
