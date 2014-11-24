package organizador.partidos.jugador.Infracciones

import java.io.Serializable
import java.util.Date
import javax.persistence.Entity
import javax.persistence.ManyToOne
import organizador.partidos.jugador.Jugador

@Entity
class InfraccionSeDaDeBajaSinRemplazante extends Infraccion implements Serializable {

	@Property int numeroDeInfraccion
	@Property Date fecha
	@Property String descripcion

	@ManyToOne
	@Property Jugador jugador

	override penalizarA(Jugador jugador) {
		val infraccion = new InfraccionSeDaDeBajaSinRemplazante
		this.fecha = new Date
		jugador.bajaTuPeso(10)
		jugador.agregarInfraccion(infraccion)
	}

	override horaInfraccion() {
		this.fecha.hours
	}

	override fechaInfraccion() {
		(this.fecha.date).toString + (this.fecha.month).toString + (this.fecha.year).toString
	}

	override penalizarConDescripcion(String descripcion, Jugador jugador) {
		this.descripcion = descripcion
		this.penalizarA(jugador)
	}

}
