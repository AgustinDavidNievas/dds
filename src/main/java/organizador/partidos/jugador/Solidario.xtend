package organizador.partidos.jugador

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.OneToOne
import organizador.partidos.partido.Partido
import java.io.Serializable
import javax.persistence.CascadeType
import javax.persistence.JoinColumn

@Entity
@DiscriminatorValue("S")
class Solidario extends Tipo implements Serializable {
		
	int prioridad = 2

	override def dameTuPrioridad() {
		this.prioridad
	}
	
	@OneToOne(cascade=CascadeType.ALL, orphanRemoval=true, mappedBy="tipo")
	@JoinColumn(name="jugador")
	var Jugador jugador

	override inscribirseA(Partido partido) {
		if (partido.plazaLlenaNoAsegurada) {
			partido.quitaUno()
			partido.agregar(this.jugador)

		} else {
			!(partido.plazaLlena)
		}
		partido.agregar(this.jugador)
	}

	/*no ponemos de condicion si la plazallenaasegurada porque ahi no lo agregaria y listo */
	override setJugador(Jugador jugador) {
		this.jugador = jugador
	}
	
	new(){
		//lo necesita hibernate
		super()
	}
}
