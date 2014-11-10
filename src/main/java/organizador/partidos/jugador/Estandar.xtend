package organizador.partidos.jugador

import organizador.partidos.partido.Partidoimport javax.persistence.Id
import javax.persistence.GeneratedValue

class Estandar implements Tipo {
	
	@Id
	@GeneratedValue
	@Property Integer id
	
	int prioridad = 1
	
	
	override def dameTuPrioridad() {
		this.prioridad
	}

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
