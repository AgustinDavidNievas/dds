package organizador.partidos.jugador

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import organizador.partidos.partido.Partido

@Entity
class CondicionTurno implements Condicion {

	@Property String turno
	
	Integer id

	@Id
	@GeneratedValue
	override getId() {
		this.id
	}

	@Id
	@GeneratedValue
	override setId(Integer idWacho) {
		this.id = idWacho
	}

	override puedeInscribirse(Partido partido) {

		partido.turno == this.turno

	}

	new(String turno) {
		this.turno = turno
	}
	
	
}
