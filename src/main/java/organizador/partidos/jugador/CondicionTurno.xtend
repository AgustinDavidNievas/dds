package organizador.partidos.jugador

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import organizador.partidos.partido.Partido
import javax.persistence.Basic
import javax.persistence.Column

@Entity
@DiscriminatorValue("T")
class CondicionTurno extends Condicion {
	
	@Basic
	@Column(name = "TURNO")
	@Property String turno

	override puedeInscribirse(Partido partido) {

		partido.turno == this.turno

	}

	new(String turno) {
		this.turno = turno
	}
	
	new(){
		//lo necesita hibernate
		super()
	}
}
