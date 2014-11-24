package organizador.partidos.jugador

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import organizador.partidos.partido.Partido
import javax.persistence.Basic
import javax.persistence.Column
import java.io.Serializable

@Entity
@DiscriminatorValue("E")
class CondicionEdad extends Condicion implements Serializable{
	
	@Basic
	@Column(name = "EDADMAXIMA")	
	@Property int edadMaxima
	
	@Basic
	@Column(name = "EDADMINIMA")
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
