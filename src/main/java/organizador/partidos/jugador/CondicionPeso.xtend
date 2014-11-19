package organizador.partidos.jugador

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import organizador.partidos.partido.Partido

@Entity
class CondicionPeso implements Condicion {
	@Property int peso
	
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

		partido.inscriptos.forall[jugadores|jugadores.peso >= this.peso]

	}

	new(int peso) {

		this.peso = peso
	}
	
	
}
