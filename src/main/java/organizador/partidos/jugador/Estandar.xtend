package organizador.partidos.jugador

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.OneToOne
import organizador.partidos.partido.Partido
import java.io.Serializable
import javax.persistence.CascadeType
import javax.persistence.JoinColumn

@Entity
@DiscriminatorValue("E")
class Estandar extends Tipo implements Serializable{
	
	@OneToOne(cascade=CascadeType.ALL, orphanRemoval=true, mappedBy="tipo")
	@JoinColumn(name="jugador2")
	@Property Jugador jugador2
		
	int prioridad = 1
	
	
	override def dameTuPrioridad() {
		this.prioridad
	}
	
	@OneToOne(cascade=CascadeType.ALL, orphanRemoval=true, mappedBy="tipo")
	@JoinColumn(name="jugador")
	var Jugador jugador

	override setJugador(Jugador jugador) {
		this.jugador = jugador
	}

	override inscribirseA(Partido partido) {
		if (!(partido.plazaLlena)) {
			partido.agregar(this.jugador)
		} else {
			if (partido.plazaLlenaNoAsegurada) { //dice "source fail" antes del assert que supuestamente si se ejecuta porque es lo que dice el test  
				partido.quitaUno()
				partido.agregar(this.jugador)
			}
		}
	}
	
	new(){
		//lo necesita hibernate
		super()
	}
}
