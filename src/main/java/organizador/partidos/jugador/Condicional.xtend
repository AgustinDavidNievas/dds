package organizador.partidos.jugador

import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.OneToOne
import organizador.partido.excepciones.EstaCompletoException
import organizador.partido.excepciones.NoCumpleCondicionParaInscribirseException
import organizador.partidos.partido.Partido
import java.io.Serializable
import javax.persistence.CascadeType

@Entity
@DiscriminatorValue("C")
class Condicional extends Tipo implements Serializable{
	
	
	@OneToOne(cascade=CascadeType.ALL, orphanRemoval=true, mappedBy="tipo")
	@Property Jugador jugador2
	
	int prioridad = 3

	override def dameTuPrioridad() {
		this.prioridad
	}

	var Jugador jugador

	@Property Condicion condicion

	new() {
		super()
	}

	new(Condicion condicion) {
		this.condicion = condicion
	}

	override inscribirseA(Partido partido) {
		if ((!(partido.plazaLlena)) && this.cualEsTuCondicion().puedeInscribirse(partido)) {
			partido.agregar(this.jugador)
		} else {
			if (partido.plazaLlena) {
				throw new EstaCompletoException("Partido Lleno")
			} else {
				throw new NoCumpleCondicionParaInscribirseException("algun jugador no cumple la condicion solicitada")

			}
		}

	}

	def puedeInscribirse(Partido partido) {
	}

	override setJugador(Jugador tuJugador) {
		this.jugador = tuJugador
	}

	def getJugador() {
		this.jugador
	}

	def cualEsTuCondicion() {
		this.condicion
	}

}
